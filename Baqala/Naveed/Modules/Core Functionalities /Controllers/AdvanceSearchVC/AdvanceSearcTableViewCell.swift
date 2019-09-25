//
//  AdvanceSearcTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/11/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import RangeSeekSlider
import DLRadioButton
import DropDown
import GooglePlacePicker
import NVActivityIndicatorView



//MARK:- protocols
//passing product model to advance saarch vc
protocol AdvanceSearcTableViewCellDelegate:class {
    func myRootProductModel(model: RootProductModel)
    func mySelectedString(searchSting: String?, category: String?, subCategory: String?, sortBy: String?, location:CLLocationCoordinate2D?,priceRange:[CGFloat]?, priceType:String?  )
}


class AdvanceSearcTableViewCell: UITableViewCell, NVActivityIndicatorViewable {
    
    //MARK:- outlets
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var txtSearchProduct: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var lblcategory: UILabel!
    @IBOutlet weak var subCategoryButton: UIButton!
    @IBOutlet weak var lblsubCategory: UILabel!
    
    
    @IBOutlet weak var nearToFarButton: UIButton!
    @IBOutlet weak var selectDistance: UILabel!
  
    @IBOutlet weak var nearByLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
  
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
  
    
    @IBOutlet weak var priceTypeLabel: UILabel!
    @IBOutlet weak var perKgBtn: DLRadioButton!
    @IBOutlet weak var perItemBtn: DLRadioButton!
  
   
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    //MARK:- properties and Structures
    
    var selectedlocation: CLLocationCoordinate2D?
    
    var vc: UIViewController?
    var advanceSearchVC: AdvanceSearchVC?
    var delegate: AdvanceSearcTableViewCellDelegate?
    //if category and subcategory is exist
    var categoryModel: CategoryModel?
    var subCategoryModel: CategoryModel?
    
    var searchString : String?
    var sortBy: String?
    var selectedPriceType: String?
    //fill data  on load VC
    var  myRootCategoryModel = RootCategoryModel()
    var  myRootSubCategoryModel = RootCategoryModel()
    
    //fill list price type
    var myRootSettingModel: RootSettingModel?
    
    //fill data model on search action response
    var  myRootProductModel = RootProductModel()
    
    //dropdown instance and intialization
    let categoryDropDown = DropDown()
    let subCategoryDropDown = DropDown()
    let nearByDropDown = DropDown()
    //this attribute use is optional - target for all dropdowns customization
    lazy var dropDowns: [DropDown] = { return[
        self.categoryDropDown,
        self.subCategoryDropDown,
        self.nearByDropDown
        ] }()
    
    
    //HandlePriceType ( maintain sequence )
     //  perkgId = 5c0a49a012bdb10af00c2af9 at 0 index
    // perItemId = 5c07c03de6406a2b74302c4f at 1 index
   
    let priceType = ["5c0a49a012bdb10af00c2af9","5c07c03de6406a2b74302c4f"]
    var priceIndex = -1
    
    
    
    
    
    //MARK:- lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.loadLocalization()
        // Initialization code
      //  self.perKgBtn.isSelected = true
        self.addressView.setLightShadow()
        
        //drop downs setup call
        self.setupDropDowns()
        
        self.rangeSlider.selectedMaxValue = 10000
        self.rangeSlider.selectedMinValue = 0
        
        self.searchView.setLightShadow()
        
        self.requestTofetchSettings()
        
        if (searchString != nil) {
            self.txtSearchProduct.text = searchString
        }
        
    }
    
    
    //MARK:- base configuration ( on load View)
    func loadLocalization() {
       
        self.searchBtn.setTitle("Search".localized, for: .normal)
        self.perKgBtn.setTitle("Per KG".localized, for: .normal)
        self.perItemBtn.setTitle("Per Item".localized, for: .normal)
       
       
        self.priceTypeLabel.text = "Price Criteria:".localized
        self.priceRangeLabel.text = "Price Range".localized
        self.nearByLabel.text = "Near By:".localized
        self.selectDistance.text = "Select Distance".localized
      
        self.lblcategory.text = "Categories".localized
        self.lblsubCategory.text = "Subcategories".localized
        
        self.address.placeholder = "Select Location".localized
        self.txtSearchProduct.placeholder = "Search your Product".localized
        let tfs = [txtSearchProduct, address] as [UITextField]
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
    
    //MARK:- actions
    
    @IBAction func categoryBtnTapped(_ sender: Any) {
        if myRootCategoryModel.data == nil {
            requestToFetchCatgoryList()
        }
        self.categoryDropDown.show()
        
    }
    
    @IBAction func subCategoryBtnTapped(_ sender: Any) {
              self.subCategoryDropDown.show()
    }
   
    @IBAction func nearByBtnTapped(_ sender: Any) {
        self.nearByDropDown.show()
    }
  
    
    
    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
        radioButton.deselectOtherButtons()
        for(_, button)  in radioButton.selectedButtons().enumerated() {
            print(button.tag)
            self.priceIndex = button.tag
           
        }
        
        
    }
    
   
    
    @IBAction func BtnSearchLocation(_ sender: UIButton) {
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        self.advanceSearchVC!.present(placePicker, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func BtnSearchProductAction(_ sender: UIButton) {
        
        self.requestToFetchProductList()
        
    }
    
    // MARK:- dropdown setup
    func setupDropDowns() {
        
          self.setupNearByDropDown()
        
        if self.categoryModel != nil {
            self.lblcategory.text = setDefaultLanguage(body: (self.categoryModel?.title)!)
        }
        
        if self.subCategoryModel != nil {
            self.lblsubCategory.text = setDefaultLanguage(body: (self.subCategoryModel?.title)!)
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
        self.setupCategoryDropDown(list: list)
        
        list = [String]()
        for item in self.myRootSubCategoryModel.data! {
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
        
     
        categoryDropDown.selectionAction = { [weak self]
            (index, item) in
            self?.lblcategory.text = item
            
            if index == 0 { return } // handle static 0 index
            
            //get model at selected index
            guard let model = self?.myRootCategoryModel.data?[index-1] else {
                nvMessage.showError(body: "Something Went Wrong")
                return
            }
            self?.categoryModel = model
            self?.subCategoryModel = nil
            self!.requestToFetchSubCatgoryList(model: model)
            
        }
    }
    
    func setupSubCategoryDropDown(list:[String]? ) {
        
        
        subCategoryDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .center
            
        }
        
        self.subCategoryDropDown.bottomOffset = CGPoint(x: 0, y: categoryButton.bounds.height)
    
        var mylist = list ?? []
        mylist.insert("Subcategories".localized, at: 0) //static at 0 index
        subCategoryDropDown.dataSource =  mylist
    
    
        // Action triggered on selection
        self.subCategoryDropDown.selectionAction = { [weak self]
            (index, item) in
            
            self?.lblsubCategory.text = item
           
            if index == 0 { return } // handle static 0 index
            let model = self?.myRootSubCategoryModel.data?[index-1]
            guard let myModel = model else {return}

            self?.subCategoryModel = myModel
        }
        
    }
    
    
    func setupNearByDropDown(){
       
        nearByDropDown.anchorView = nearToFarButton
       
        nearByDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .center
            
        }
        
        nearByDropDown.bottomOffset = CGPoint(x: 0, y: nearToFarButton.bounds.height)
        
        
        nearByDropDown.dataSource = ["Select Distance".localized,
                                     "Near To Far".localized]
       
        nearByDropDown.selectionAction = {[unowned self]
            (index: Int, item: String) in
            self.selectDistance.text = item
            switch index {
            case 1:
               self.sortBy = "near"
            default: // at 0 index
                self.sortBy = nil
            }
            
        }
    }
    
   
    
}







//MARK:- ws: Web Services Requests
extension AdvanceSearcTableViewCell {
    
    func requestToFetchProductList() {
         //loader
          self.advanceSearchVC?.showNvLoader()
        
        
        //default parameter - required
        var params = ["locale": myDefaultLanguage.rawValue ] as [String: Any]
       
        if self.txtSearchProduct.text != "" {
            params.updateValue(self.txtSearchProduct.text!, forKey: "keyword")
        }
        
        // filter by category - optional
        if (self.categoryModel?.id != nil) {
            let list = [self.categoryModel?.id]
            params.updateValue(list, forKey: "categories")
        }
        
        
        // filter by category  and subcategory parameter - optional
        if (self.subCategoryModel?.id != nil) {
            let list = [self.categoryModel?.id, subCategoryModel?.id]
            params.updateValue(list, forKey: "categories")
        }
        
        
        //added range slider - optional
        params.updateValue(self.rangeSlider.selectedMinValue, forKey: "minPrice")
        params.updateValue(self.rangeSlider.selectedMaxValue, forKey: "maxPrice")
        params.updateValue(myDefaultCurrency.rawValue, forKey: "currency")
        
       
        
          // filter by Price Type
        if priceIndex != -1 {
            selectedPriceType = priceType[priceIndex]
            params.updateValue(selectedPriceType!, forKey: "priceType")
            
        }
      
        
        // filter by Selected location
        if self.selectedlocation != nil {
            let list = [selectedlocation?.longitude, selectedlocation?.latitude]
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
            
            //hide loader
            self.advanceSearchVC?.hideNvloader()
            
            if error == nil {
                self.myRootProductModel = rootModel!
               
               
                 //Show message on 0 record
                if self.myRootProductModel.data?.products?.count == 0 {
                    nvMessage.showError( body: appConstant.noMoreData)
                }
                //send model to AdvanceSearchVC
                else {
                 self.delegate?.myRootProductModel(model: self.myRootProductModel)
                    self.delegate?.mySelectedString(searchSting: self.txtSearchProduct.text!,
                                                    category: self.lblcategory.text!,
                                                    subCategory: self.lblsubCategory.text!,
                                                    sortBy: self.sortBy,
                                                    location:self.selectedlocation,
                                                    priceRange: [self.rangeSlider.selectedMinValue, self.rangeSlider.selectedMaxValue],
                                                    priceType: self.selectedPriceType)
                }
           
            }
            else { nvMessage.showError(body: error!) }
        })
    }
    
    
    
    func requestTofetchSettings() {
      
        self.advanceSearchVC?.showNvLoader()
        
        SettingManager.shared.fetchSettingList { (error, rootModel) in
        self.advanceSearchVC?.hideNvloader()
           
            if error == nil {
                
                self.myRootSettingModel = rootModel!
                if self.myRootSettingModel?.data?.priceTypes?.count == 0 {
                    nvMessage.showError(title: "Setting Price Type", body: appConstant.noMoreData)
                }
            }
            else {
                nvMessage.showError(body: error!)
                
            }
        }
    }
    
    
    
    
    
    
}

//MARK:- ws: Web Services Requests
extension AdvanceSearcTableViewCell {
    
    func requestToFetchCatgoryList() {
       
        self.advanceSearchVC?.showNvLoader()
        self.subCategoryModel = nil
        self.lblsubCategory.text = "Subcategories".localized
        
        
        CategoryManager.shared.fetchCatgoryList(title: nil) { (error, categoryModel) in
           
            self.advanceSearchVC?.hideNvloader()
            
            if error == nil {
                
                self.myRootCategoryModel = categoryModel!
                
                var list = [String]()
                for item in self.myRootCategoryModel.data! {
                    let title = setDefaultLanguage(body: item.title!)
                    list.append(title)
                }
                self.setupCategoryDropDown(list: list)
              
                
                if self.myRootCategoryModel.data?.count == 0 {
                    nvMessage.showError(title: "Category DropDown", body: appConstant.noMoreData)
                }
                
            }
            else {
                nvMessage.showError(body: error!)
                
            }
        }
    }
    
    
    func requestToFetchSubCatgoryList(model: CategoryModel) {
        
        self.advanceSearchVC?.showNvLoader()
        
        CategoryManager.shared.fetchSubCatgoryList(title: nil, model:model, completion: { (error, categoryModel) in
           
            self.advanceSearchVC?.hideNvloader()
            
            if error == nil {
                
                self.myRootSubCategoryModel = categoryModel!
                
                var list = [String]()
                for item in self.myRootSubCategoryModel.data! {
                    let title = setDefaultLanguage(body: item.title!)
                    list.append(title)
                }
                self.setupSubCategoryDropDown(list: list)
                
                
                if self.myRootSubCategoryModel.data?.count == 0 {
                 self.lblsubCategory.text = "Subcategories".localized
                }
                
            }
            else {
                nvMessage.showError(body: error!)
                
            }
        })
    }
    
    
}


extension AdvanceSearcTableViewCell: GMSPlacePickerViewControllerDelegate {
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        

        self.selectedlocation = place.coordinate
        if place.formattedAddress != nil {
            self.address.text = place.formattedAddress!
        }
        else {
            let coordinate = "selected coordinat: \(place.coordinate.latitude), \(place.coordinate.longitude)"
            self.address.text = "Unkown Address, \(coordinate)"
        }
        
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    

    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        nvMessage.showError(body: error.toJSONString() ?? "didFailAutocompleteWithError")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.vc!.dismiss(animated: true, completion: nil)
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}
