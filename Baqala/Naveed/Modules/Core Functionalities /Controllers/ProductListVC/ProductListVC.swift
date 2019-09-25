//
//  ProductListVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import PullToRefreshKit
import MIBadgeButton_Swift

//MARK:- Protocols
protocol ProductListVCDelegate: class {
    func cartBadgeNumberUpdated(value: Int)
}



class ProductListVC: UIViewController {

    //MARK:- outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
   
    
    
    //MARK:- properties and Structures
    var categoryId: String?
    var subCatagoryId: String?
    //pass data
    var storeId: String?
    var isFromSellerMenu = false

    var delegate: ProductListVCDelegate?
    var myRootProductModel = RootProductModel()
    
    let footerPull = DefaultRefreshFooter.footer()
    var skip: Int?
    let badgeBtn = MIBadgeButton(type: .custom)
   
    //MARK:- lifeCycle
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
       
        viewWillAppear(true)
     
        //requestToFetchProductList
        self.configureTableViewRefresh()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.title = "Product List".localized
        self.loadLocalization()
        self.setCustomNavigationBar()
        self.setBackButton()
        
        self.setBarBtnsByAccountType(cartBadgeBtn: self.badgeBtn)
        self.refresh(cartBadgeBtn: badgeBtn)
       
        self.searchView.setLightShadow()
       
        self.tableView.registerCustomCell(withCellId: "ProductListTableViewCell")
        self.tableView.registerCustomCell(withCellId: "ProductListSellerTableViewCell")
       
        
      
        
    }
    
    //MARK:- Base Configuration
    
    func loadLocalization()  {
       
        self.searchTextField.placeholder = "Search Keyword".localized
        let tfs = [searchTextField] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
       
        self.setViewDirectionByLanguage()
    }
    
    fileprivate func configureTableViewRefresh() {
        
        self.searchTextField.isUserInteractionEnabled = false
        self.searchBtn.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        
        let header = DefaultRefreshHeader.header()
        self.tableView.configRefreshHeader(with: header,container:self) { [weak self] in
            //call your function to update table View
            self?.skip = 0
            self?.requestToFetchProductList()
           
        }
        delay(bySeconds: 0.2, closure: {
            self.tableView.switchRefreshHeader(to: .refreshing)
        })
        
    }
    
   
    
    
    //MARK:- actions
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        //disable user interaction till process is complete
        self.view.isUserInteractionEnabled = false
        self.searchTextField.isUserInteractionEnabled = false
        self.searchBtn.isUserInteractionEnabled = false
        //refresh server request
         self.configureTableViewRefresh()
      
        
    }
    
    
    
    
    
}


//MARK:- ws: Web Services Requests

extension ProductListVC {
   
    func requestToFetchProductList() {
       
        //default parameter
        var params = ["locale": myDefaultLanguage.rawValue ] as [String: Any]
        
        //add current location to get distance
        let latti = Sharedata.shareInfo.userLatitude
        let long = Sharedata.shareInfo.userLongitude
        let location = [long, latti] as! [Double] //take care of indx
        params.updateValue(location, forKey: "location")
        
        //for pagination
        params.updateValue(self.skip!, forKey: "skip")
        
        //filter by store id
        if isFromSellerMenu == true {
            self.storeId = Sharedata.shareInfo.id
        }
        if storeId != nil {
            params.updateValue(self.storeId!, forKey: "user")
        }
        
        // filter by category parameter
        if (searchTextField.text! != "") {
            params.updateValue(searchTextField.text!, forKey: "keyword")
        }
        
        // filter by category parameter
        if  self.categoryId != nil && self.subCatagoryId != nil {
            let categories = [self.categoryId!, self.subCatagoryId!]
            params.updateValue(categories, forKey: "categories")
        }
        
        
        
        
        
        ProductManager.shared.fetchProductListBy(params: params, completion: { (error, rootModel) in
            //hide loader on scroll
            ProgressHUD.dismiss(animated: true)
            
            if error == nil {
               
                self.updateProductListByPagination(rootModel)
                
              
                self.tableView.switchRefreshHeader(to: .normal(.success, 0.0))
                
                if self.myRootProductModel.data?.products?.count == 0 {
                    nvMessage.showError(title: self.title! , body: appConstant.noMoreData)
                    
                    self.skip = self.myRootProductModel.data?.products?.count
                }
            }
            else {
                nvMessage.showError(body: error!)
                self.tableView.switchRefreshHeader(to: .normal(.failure, 0.0))
            }
        })
        
        
        delay(bySeconds: 0.5, closure: {
            //enable user interacation
            self.view.isUserInteractionEnabled = true
            self.searchBtn.isUserInteractionEnabled = true
            self.searchTextField.isUserInteractionEnabled = true
        })
    }
    
    fileprivate func updateProductListByPagination(_ rootModel: RootProductModel?) {
        if self.skip == 0 {
            
            self.myRootProductModel = rootModel!
            self.skip = self.myRootProductModel.data?.products?.count
        }
        else { //append
            
            if let productList = rootModel?.data?.products {
                self.myRootProductModel.data?.products!.append(contentsOf: productList)
                self.skip = self.myRootProductModel.data?.products?.count
            }
 
        }
        
          self.tableView.reloadData()
    }
    
    
    
    
}
//MARK:- tableView Extension
extension ProductListVC: UITableViewDelegate, UITableViewDataSource , ProductListTableViewCellDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myRootProductModel.data?.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch myDefaultAccountType {
       
        case .seller, .guest:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListSellerTableViewCell") as! ProductListSellerTableViewCell
            cell.myController = self
            cell.isFromSellerMenu = isFromSellerMenu
            let product = self.myRootProductModel.data?.products![indexPath.row]
            cell.setData(body: product!)
             return cell
       
        case .buyer: // Buyer
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell") as! ProductListTableViewCell
            cell.myController = self
            cell.delegate = self
            
            let product = self.myRootProductModel.data?.products![indexPath.row]
            cell.setData(body: product!)
            
            
            return cell
       
        case .notExist:
            nvMessage.showError(body: "User Account type not selected")
            return UITableViewCell()
        }
        
        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if (tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height - 20 {
            ProgressHUD.present(animated: true)
            self.requestToFetchProductList()
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.myRootProductModel.data?.products![indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.id = product?.id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func addToCartBtnDidTap(BadgNumber: Int) {
     
        if BadgNumber > 0 {
             badgeBtn.showBadge()
             badgeBtn.badgeString = "\(BadgNumber)"
            //update value in pager
            delegate?.cartBadgeNumberUpdated(value: BadgNumber)
        }
      
    }
    
}

