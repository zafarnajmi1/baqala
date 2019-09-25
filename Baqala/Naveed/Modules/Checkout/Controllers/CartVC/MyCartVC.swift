//
//  MyCartVC.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import PullToRefreshKit
import GradientLoadingBar

class MyCartVC: UIViewController {

    //MARK:- outlets
    
    @IBOutlet weak var tableView: UITableView!
 
    
    //MARK:- properties and Structures
    
     var subTotalAmount: Double = 0
     private var myRootCartModel = RootMyCardModel()
     private var  gradientLoadingBar: GradientLoadingBar!
    
    
    //MARK:- lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewWillAppear(false)
        
        self.setViewDirectionByLanguage()
       
        //register custom cell
        self.tableView.registerCustomCell(withCellId: "MyCartTableViewCell")
        self.tableView.registerCustomCell(withCellId: "myCartTotalTableViewCell")
        
        //load base config
        self.configureTableViewRefresh()
        
        //  gradientLoadingBar = BottomGradientLoadingBar(onView: self.myContentView)
        gradientLoadingBar = BottomGradientLoadingBar(height: 4, durations: Durations.default, gradientColorList: [#colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1), #colorLiteral(red: 0.5229000449, green: 0.6485285163, blue: 0.1439691782, alpha: 1), #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)], isRelativeToSafeArea: true, onView: self.navigationController?.navigationBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setCustomNavigationBar()
        //setup navigation
        self.setBackButton()
        self.title = "My Cart".localized
        
        if myDefaultAccountType == .buyer {
            setSellerBarBtn()
        }
        
    }
    
   
    
    //MARK:- actions
    
    func NavigateToBilling() {
    
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BillingAddressVC") as! BillingAddressVC
        vc.myCartRootModel = myRootCartModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //MARK:- Base Configuration
    
    fileprivate func configureTableViewRefresh() {
        let header = DefaultRefreshHeader.header()
        self.tableView.configRefreshHeader(with: header,container:self) { [weak self] in
            //call your function to update table View
            self?.subTotalAmount = 0
            self?.requestToFetchMyCartList()
            
        }
        delay(bySeconds: 0.2, closure: {
            self.tableView.switchRefreshHeader(to: .refreshing)
        })
        
    }
}



//MARK:- ws: Web Services Requests

extension MyCartVC {
    
    func requestToFetchMyCartList() {
        
        CartManager.shared.fetchMyCartList { (error, rootModel) in
            
            if error == nil {
                
                self.myRootCartModel = rootModel!
                self.subTotalAmount = 0
                self.tableView.reloadData()
                self.tableView.switchRefreshHeader(to: .normal(.success, 0.0))
               
                if rootModel?.data?.count == 0 {
                    nvMessage.showError(title:self.title!, body: appConstant.noMoreData)
                }
               
            }
            else {
                nvMessage.showError(body: error!)
                self.tableView.switchRefreshHeader(to: .normal(.failure, 0.0))
            }
        }
        
    }
    
    func requestToRefreshMyCartList() {
       
        self.gradientLoadingBar.show()
        self.view.isUserInteractionEnabled = false
       
        CartManager.shared.fetchMyCartList { (error, rootModel) in
            
            self.gradientLoadingBar.hide()
            self.view.isUserInteractionEnabled = true
            
            if error == nil {
                self.myRootCartModel = rootModel!
            
             
                var totalItems = 0
                //some of each item quantity
                for model in (rootModel?.data!)!{
                    totalItems = totalItems + model.quantity!
                }
                //save totals in user defaults
                Sharedata.shareInfo.cartItemsTotal = totalItems
               
                //reset total items on refresh list
                self.subTotalAmount = 0
                self.tableView.reloadData()
                
                if rootModel?.data?.count == 0 {
                    nvMessage.showError(title:self.title!, body: appConstant.noMoreData)
                    self.navigationController?.popViewController(animated: true)
                    
                    Sharedata.shareInfo.cartItemsTotal = 0
                }
               
            }
            else {
                nvMessage.showError(body: error!)
               
            }
        }
    }
    
}
//MARK:- tableView Extension
extension MyCartVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        switch section {
      
        case 1: // total static cell
           let total = self.myRootCartModel.data?.count ?? 0
           return total > 0 ? 1:0 // return 1 if cart items exist
        
        default: // list of cells
            return self.myRootCartModel.data?.count ?? 0
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCartTotalTableViewCell") as! myCartTotalTableViewCell
            
           cell.setData(subTotal: self.subTotalAmount)
            
            cell.checkOutBtn.on(.touchUpInside) { control, event in
                            self.NavigateToBilling()
            }
            return cell
            
        default:
           
            let cartCell = tableView.dequeueReusableCell(withIdentifier: "MyCartTableViewCell") as! MyCartTableViewCell
            
            cartCell.myController = self
            cartCell.delegate = self
            cartCell.myRootCartModel = self.myRootCartModel
            let model = self.myRootCartModel.data![indexPath.row]
            cartCell.setData(model: model)
            
            return cartCell
        }
       
    }
  
}
//MARK:- helpers ( include form Validation and other Methods )


extension MyCartVC: MyCartTableViewCellDelegate {
    func totalAmountByEachProduct(amount: Double) {
        
        self.subTotalAmount = amount + subTotalAmount
        
        let rowNumber: Int = 0
        let sectionNumber: Int = 1
        
        let indexPath = IndexPath(item: rowNumber, section: sectionNumber)
        
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
  
    
    func productUpdated() {
        self.requestToRefreshMyCartList()
    }
    
    
}
