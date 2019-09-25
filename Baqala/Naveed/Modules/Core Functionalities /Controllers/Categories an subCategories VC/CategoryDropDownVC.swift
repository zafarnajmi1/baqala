//
//  CategoryDropDownVC.swift
//  Baqala
//
//  Created by apple on 2/12/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import UIKit
import DropDown

open class CategoryDropDownVC: UIViewController {

    //dropdown outlets
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var subCategoryButton: UIButton!
    @IBOutlet var lblcategories: UILabel!
    @IBOutlet var lblSubCategories: UILabel!
    
    //dropdown instance and intialization
    let categoryDropDown = DropDown()
    let subtCategoryDropDown = DropDown()
    //this attribute use is optional - target for all dropdowns customization
    lazy var dropDowns: [DropDown] = { return[
        self.categoryDropDown,
        self.subtCategoryDropDown
        ] }()
    
    //Root Model
    var myRootCategoryModel = RootCategoryModel()
    var myRootSubCategoryModel = RootCategoryModel()
    var categoryModel: CategoryModel?
    var subCategoryModel: CategoryModel?
    
    


}




// MARK:- dropdown setup

extension CategoryDropDownVC {
    
    @IBAction func categoryBtnTapped(_ sender: AnyObject) {
        if myRootCategoryModel.data == nil {
            requestToFetchCatgoryList()
        }
        self.categoryDropDown.show()
    }
    @IBAction func subcategoryBtnTapped(_ sender: AnyObject) {
        self.subtCategoryDropDown.show()
    }
    
    
    func setupDropDowns() {
        self.requestToFetchCatgoryList()
        setupCategoryDropDown(list: nil )
        setupSubCategoryDropDown(list: nil)
    }
    
    func setupCategoryDropDown(list:[String]?  ) {
        
        categoryDropDown.anchorView = categoryButton
        
        categoryDropDown.bottomOffset = CGPoint(x: 0, y: categoryButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        var mylist = list ?? []
        mylist.insert("Categories", at: 0) //static at 0 index
        categoryDropDown.dataSource =  mylist
        
        // Action triggered on selection
        categoryDropDown.selectionAction = { [weak self] (index, item) in
            self?.lblcategories.text = item
            
            if index == 0 { return } // handle static 0 index
            
            //get model at selected index
            guard let model = self?.myRootCategoryModel.data?[index-1] else {
                nvMessage.showError(body: "Something Went Wrong")
                return
            }
            self?.categoryModel = model
            self!.requestToFetchSubCatgoryList(model: model)
        }
    }
    
    func setupSubCategoryDropDown(list:[String]? ) {
        
        self.subtCategoryDropDown.anchorView = self.subCategoryButton
        
        
        self.subtCategoryDropDown.bottomOffset = CGPoint(x: 0, y: categoryButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        var mylist = list ?? []
        mylist.insert("Sub Categories", at: 0) //static at 0 index
        subtCategoryDropDown.dataSource =  mylist
        self.subtCategoryDropDown.dataSource = mylist
        
        // Action triggered on selection
        self.subtCategoryDropDown.selectionAction = { [weak self] (index, item) in
            
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
        
      //  self.categoryLoadingBar.show()
        
        CategoryManager.shared.fetchCatgoryList(title: nil) { (error, categoryModel) in
          //  self.categoryLoadingBar.hide()
            
            if error == nil {
                
                self.myRootCategoryModel = categoryModel!
                
                var list = [String]()
                for item in self.myRootCategoryModel.data! {
                    let title = setDefaultLanguage(body: item.title!)
                    list.append(title)
                }
                self.setupCategoryDropDown(list: list)
                
                
            }
            else {
                nvMessage.showError(body: error!)
                
            }
        }
    }
    
    
    func requestToFetchSubCatgoryList(model: CategoryModel) {
       // self.subCategoryLoadingBar.show()
        CategoryManager.shared.fetchSubCatgoryList(title: nil, model:model, completion: { (error, categoryModel) in
          //  self.subCategoryLoadingBar.hide()
            
            if error == nil {
                
                self.myRootSubCategoryModel = categoryModel!
                
                var list = [String]()
                for item in self.myRootSubCategoryModel.data! {
                    let title = setDefaultLanguage(body: item.title!)
                    list.append(title)
                }
                self.setupSubCategoryDropDown(list: list)
                
                
                if self.myRootSubCategoryModel.data?.count == 0 {
                    
                    self.subCategoryModel = nil
                }
                
            }
            else {
                nvMessage.showError(body: error!)
                self.subCategoryModel = nil
            }
        })
    }
    
    
}
