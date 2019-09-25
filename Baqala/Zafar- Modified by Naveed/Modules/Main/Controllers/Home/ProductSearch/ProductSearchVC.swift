//
//  ProductSearchVC.swift
//  Baqala
//
//  Created by apple on 1/14/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import UIKit
import DropDown
import MIBadgeButton_Swift
import PullToRefreshKit
import CoreLocation


class ProductSearchVC: UIViewController {

    //MARK:- protocols
    
    //MARK:- outlets
    
    @IBOutlet var txtSearchProduct: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBtn: UIButton!
    
    //dropdown outlets
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var subCategoryButton: UIButton!
    @IBOutlet var lblcategories: UILabel!
    @IBOutlet var lblSubCategories: UILabel!
    
     //MARK:- properties and Structures
    
    //dropdown instance and intialization
    let categoryDropDown = DropDown()
    let subCategoryDropDown = DropDown()
    
    //this attribute use is optional - target for all dropdowns customization
    lazy var dropDowns: [DropDown] = { return[
        self.categoryDropDown,
        self.subCategoryDropDown
        ] }()
    
    //Root Model
    var myRootCategoryModel = RootCategoryModel()
    var myRootSubCategoryModel = RootCategoryModel()
    
    
    var categoryModel: CategoryModel?
    var subCategoryModel: CategoryModel?
    var searchString : String?
    
  //  var delegate: ProductListVCDelegate?
    var myRootProductModel = RootProductModel()
    var skip: Int?
    let cartBadgeButton = MIBadgeButton(type: .custom)

    var selectedLocation: CLLocationCoordinate2D?
    var sortBy: String?
    var priceRange: [CGFloat]?
    var selectedPriceType: String?
    
    
    
    
    //MARK:- lifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewWillAppear(true)
   
        self.filterBarBtn()
        self.setCustomNavigationBar()
        
        self.searchView.setLightShadow()
        self.tableView.registerCustomCell(withCellId: "ProductListTableViewCell")
        self.tableView.registerCustomCell(withCellId: "ProductListSellerTableViewCell")
        //requestToFetchProductList
        self.configureTableViewRefresh()
        
        if searchString != nil {
            self.txtSearchProduct.text = searchString
        }
       
        self.setupDropDowns()
        
       
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.loadLocalization()
        self.setBackButton()
        
        self.title = "Search Product".localized
        
        //show cart number if value exist
        if Sharedata.shareInfo.cartItemsTotal != nil {
            cartBadgeButton.showBadge()
            cartBadgeButton.badgeString = "\(Sharedata.shareInfo.cartItemsTotal ?? 0)"
        }
        
    }
    
    //MARK:- Base Configuration
    
    func loadLocalization() {

        self.txtSearchProduct.placeholder = "Search your Product".localized
        let tfs = [txtSearchProduct] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
       
        switch myDefaultLanguage {
        case .ar:
            categoryDropDown.anchorView = subCategoryButton
            subCategoryDropDown.anchorView = categoryButton
            
            
        default:
            categoryDropDown.anchorView = categoryButton
            subCategoryDropDown.anchorView = subCategoryButton
        }
    }
    
    
    fileprivate func configureTableViewRefresh() {
        
        self.txtSearchProduct.isUserInteractionEnabled = false
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
    
  
    
    
    
    func filterBarBtn(){
        
        let filterBtn = UIButton(type: .custom)
        filterBtn.setImage(UIImage(named: "Option"), for: .normal)
        filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        filterBtn.addTarget(self, action: #selector(btnFilterTapped(_:)), for: .touchUpInside)
        
        filterBtn.widthAnchor.constraint(equalToConstant: 32.0).isActive = true
        filterBtn.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        
        let filterBarBtn = UIBarButtonItem(customView: filterBtn)
        //add buttons to navigationsBaR RightBarButtonItems
        self.navigationItem.setRightBarButtonItems([filterBarBtn], animated: true)
    }
    
    
    
    
    @objc func btnFilterTapped (_ sender: Any)
    {
        let storyBoard = UIStoryboard.init(name: "Core", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AdvanceSearchVC") as! AdvanceSearchVC
        vc.delegate = self
        vc.searchString = self.txtSearchProduct.text
        vc.myRootCategoryModel = self.myRootCategoryModel
        vc.myRootSubCategoryModel = self.myRootSubCategoryModel
        vc.categoryModel = self.categoryModel
        vc.subCategoryModel = self.subCategoryModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
  
    
    @IBAction func BtnSearchPRoductAction(_ sender: UIButton) {
     
        //disable user interaction till process is complete
        self.view.isUserInteractionEnabled = false
        self.txtSearchProduct.isUserInteractionEnabled = false
        self.searchBtn.isUserInteractionEnabled = false
        //refresh server request
        self.configureTableViewRefresh()
        
    }
    
    
}


//MARK:- ws: Web Services Requests
extension ProductSearchVC {
    
    func requestToFetchProductList() {
       
        //default parameter
        var params = ["locale": myDefaultLanguage.rawValue ] as [String: Any]
        
        //for pagination
        params.updateValue(self.skip!, forKey: "skip")
        
       
        //add current location to get distance
        let latti = Sharedata.shareInfo.userLatitude
        let long = Sharedata.shareInfo.userLongitude
        let location = [long, latti] as! [Double] //take care of indx
        params.updateValue(location, forKey: "location")
        
        
        
        
        // filter by category
        if (self.categoryModel?.id != nil) {
            let list = [self.categoryModel?.id]
            params.updateValue(list, forKey: "categories")
        }
        
        
        // filter by category  and subcategory parameter
        if (self.subCategoryModel?.id != nil) {
            let list = [self.categoryModel?.id, subCategoryModel?.id]
            params.updateValue(list, forKey: "categories")
        }
        
        if  self.txtSearchProduct.text! != "" {
            params.updateValue(self.txtSearchProduct.text!, forKey: "keyword")
        }
        
        
        //added range slider - optional
        if let items = priceRange {
            params.updateValue([items[0]], forKey: "minPrice")
            params.updateValue(items[1], forKey: "maxPrice")
            params.updateValue(myDefaultCurrency.rawValue, forKey: "currency")
        }
     
        
        
        
        // filter by Price Type
        if let type = selectedPriceType {
            params.updateValue(type, forKey: "priceType")
            
        }
        
        
        // filter by Selected location
        if let location = selectedLocation {
            let list = [location.longitude, location.latitude]
            params.updateValue(list, forKey: "location")
            
        }
        else { // Default filter by user current location
            let list = [Sharedata.shareInfo.userLongitude, Sharedata.shareInfo.userLatitude]
            params.updateValue(list, forKey: "location")
        }
        
        //sort by
        if sortBy != nil {
            params.updateValue(sortBy!, forKey: "sortBy")
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
            self.txtSearchProduct.isUserInteractionEnabled = true
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
                let totalFetch = self.myRootProductModel.data?.products?.count ?? 0
                self.skip =  totalFetch
            }
            
        }
        
        self.tableView.reloadData()
    }
    
    
}


//MARK:- tableView Extension
extension ProductSearchVC: UITableViewDelegate, UITableViewDataSource , ProductListTableViewCellDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myRootProductModel.data?.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch myDefaultAccountType {
            
        case .seller, .guest:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListSellerTableViewCell") as! ProductListSellerTableViewCell
            cell.myController = self
            
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.myRootProductModel.data?.products![indexPath.row]
        let storyboard = UIStoryboard(name: "Core", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.id = product?.id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if (tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height - 20 {
            ProgressHUD.present(animated: true)
            self.requestToFetchProductList()
        }
    }
    
    
    
    func addToCartBtnDidTap(BadgNumber: Int) {
        
        if BadgNumber > 0 {
            cartBadgeButton.showBadge()
            cartBadgeButton.badgeString = "\(BadgNumber)"
            //update value in pager
           // delegate?.cartBadgeNumberUpdated(value: BadgNumber)
        }
        
    }
    
}

 //MARK:-  custome delegate
extension ProductSearchVC: advanceSearchVCDelegate {
   
    func mySelectedString(searchSting: String?,
                          category: String?, subCategory: String?,
                          sortBy: String?, location: CLLocationCoordinate2D?,
                          priceRange: [CGFloat]?, priceType: String?) {
        
      
        self.lblcategories.text = category
        self.lblSubCategories.text = subCategory
        self.selectedLocation = location
        self.sortBy = sortBy
        self.selectedPriceType = priceType
        if let list = priceRange {
               self.priceRange = [list[0], list[1]] //[minValue, maxValue]
        }
        if searchSting != nil {
            self.txtSearchProduct.text = searchSting
        }
     
    }
    

    
    func myRootProductModel(model: RootProductModel) {
        self.myRootProductModel = model
        self.tableView.reloadData()
    }
    
    
}




// MARK:- dropdown Implementation
extension ProductSearchVC {
    
    //MARK:- Actions
    
    @IBAction func categoryBtnTapped(_ sender: AnyObject) {
        if myRootCategoryModel.data == nil {
            requestToFetchCatgoryList()
        }
        self.categoryDropDown.show()
    }
    @IBAction func subcategoryBtnTapped(_ sender: AnyObject) {
        self.subCategoryDropDown.show()
    }
    
    // MARK:- dropdown setup
    func setupDropDowns() {
        
        
        if self.categoryModel != nil {
            self.lblcategories.text = setDefaultLanguage(body: (self.categoryModel?.title)!)
        }
        else{
            self.lblcategories.text = "Categories".localized
        }
        
        
        if self.subCategoryModel != nil {
            self.lblSubCategories.text = setDefaultLanguage(body: (self.subCategoryModel?.title)!)
        }
        else{
            self.lblSubCategories.text = "Subcategories".localized
        }
        
        
        guard let categorylist = self.myRootCategoryModel.data else {
            self.requestToFetchCatgoryList()
            return
        }
        
        
        var list = [String]()
        for item in categorylist {
            let title = setDefaultLanguage(body: item.title!)
            list.append(title)
        }
        
        //category drop down
        self.setupCategoryDropDown(list: list)
        
        list = [String]()
        
        guard let catList = self.myRootSubCategoryModel.data else {
            return
        }
    
        for item in catList {
            let title = setDefaultLanguage(body: item.title!)
            list.append(title)
        }
        
        self.setupSubCategoryDropDown(list: nil)
        
        
        
    }
    
    
    func setupCategoryDropDown(list:[String]?  ) {
        
        categoryDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .center
            
        }
        
        categoryDropDown.bottomOffset = CGPoint(x: 0, y: categoryButton.bounds.height)
        
        
        var mylist = list ?? []
        mylist.insert("Categories".localized, at: 0) //static at 0 index
        categoryDropDown.dataSource =  mylist
        
        // Action triggered on selection
        categoryDropDown.selectionAction = { [weak self] (index, item) in
            self?.lblcategories.text = item
            
            if index == 0 { return } // handle static 0 index
            
            //get model at selected index
            let model = self?.myRootCategoryModel.data?[index-1]
            guard let myModel = model else {return}
            self?.categoryModel = myModel
            self?.subCategoryModel = nil
            self!.requestToFetchSubCatgoryList(model: myModel)
        }
    }
    
    func setupSubCategoryDropDown(list:[String]? ) {
        
        subCategoryDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .center
            
        }
        
        
        self.subCategoryDropDown.bottomOffset = CGPoint(x: 0, y: categoryButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        var mylist = list ?? []
        mylist.insert("Subcategories".localized, at: 0) //static at 0 index
        subCategoryDropDown.dataSource =  mylist

        
        // Action triggered on selection
        self.subCategoryDropDown.selectionAction = { [weak self] (index, item) in
            
            self?.lblSubCategories.text = item
            if index == 0 { return } // handle static 0 index
            guard let model = self?.myRootSubCategoryModel.data?[index-1] else {
                nvMessage.showError(body: "Something Went Wrong")
                return
            }
            
            self?.subCategoryModel = model
        }
        
    }
    
    //MARK:- ws: Web Services Requests
    
    func requestToFetchCatgoryList() {
        
        self.showNvLoader()
        
        self.subCategoryModel = nil
        self.lblSubCategories.text = "Subcategories".localized
        
        CategoryManager.shared.fetchCatgoryList(title: nil) { (error, categoryModel) in
            
            self.hideNvloader()
            
            if error == nil {
                
                self.myRootCategoryModel = categoryModel!
                
                var list = [String]()
                for item in self.myRootCategoryModel.data! {
                    let title = setDefaultLanguage(body: item.title!)
                    list.append(title)
                }
                self.setupCategoryDropDown(list: list)
                
                if self.myRootCategoryModel.data?.count == 0 {
                    self.subCategoryModel = nil
                    self.lblSubCategories.text = "Subcategories".localized
                }
                
            }
            else {
                nvMessage.showError(body: error!)
                
            }
        }
    }
    
    
    func requestToFetchSubCatgoryList(model: CategoryModel) {
        
        CategoryManager.shared.fetchSubCatgoryList(title: nil, model:model, completion: { (error, categoryModel) in
            
            if error == nil {
                
                self.myRootSubCategoryModel = categoryModel!
                
                var list = [String]()
                for item in self.myRootSubCategoryModel.data! {
                    let title = setDefaultLanguage(body: item.title!)
                    list.append(title)
                }
                self.lblSubCategories.text = "Subcategories".localized
                self.setupSubCategoryDropDown(list: list)
                
                
                if self.myRootSubCategoryModel.data?.count == 0 {
                    self.lblSubCategories.text = "Subcategories".localized
                    // nvMessage.showError(title: "Subcategory DropDown", body: appConstant.noMoreData)
                }
                
            }
            else {
                nvMessage.showError(body: error!)
                
            }
        })
    }
    
    
}
