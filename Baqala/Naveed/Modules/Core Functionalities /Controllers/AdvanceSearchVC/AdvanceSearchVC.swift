//
//  AdvanceSearchVC.swift
//  Baqala
//
//  Created by apple on 12/11/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import CoreLocation

//passing product model to Product saarch vc
protocol advanceSearchVCDelegate:class {
    func myRootProductModel(model: RootProductModel)
    func mySelectedString(searchSting: String?, category: String?, subCategory: String?, sortBy: String?, location:CLLocationCoordinate2D?,priceRange:[CGFloat]?, priceType:String?  )
}



class AdvanceSearchVC: UIViewController {

    //MARK:- outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- properties and Structures
    var delegate: advanceSearchVCDelegate?
    
    var myRootCategoryModel = RootCategoryModel()
    var myRootSubCategoryModel = RootCategoryModel()
    
    
    var categoryModel: CategoryModel?
    var subCategoryModel: CategoryModel?
    var searchString : String?
    
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewDirectionByLanguage()
        self.title = "Advance Search".localized
        self.setBackButton()
        self.setCustomNavigationBar()
        self.tableView.registerCustomCell(withCellId: "AdvanceSearcTableViewCell")
        
    }
    
    
    
}

//MARK:- actions
//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
extension AdvanceSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdvanceSearcTableViewCell") as! AdvanceSearcTableViewCell
        cell.vc = self
        cell.advanceSearchVC = self
        cell.delegate = self
        cell.searchString = searchString
        cell.categoryModel = categoryModel
        cell.subCategoryModel = subCategoryModel
        cell.myRootCategoryModel = myRootCategoryModel
        cell.myRootSubCategoryModel = myRootSubCategoryModel
        return cell
    }
    
    
}


//MARK:- helpers ( include form Validation and other Methods )
extension AdvanceSearchVC: AdvanceSearcTableViewCellDelegate {
   
    func mySelectedString(searchSting: String?, category: String?, subCategory: String?, sortBy: String?, location: CLLocationCoordinate2D?, priceRange: [CGFloat]?, priceType: String?) {
        self.delegate?.mySelectedString(searchSting: searchSting, category: category, subCategory: subCategory, sortBy: sortBy, location: location, priceRange: priceRange, priceType: priceType)
    }
    
   
    
    func myRootProductModel(model: RootProductModel) {
        
        self.delegate?.myRootProductModel(model: model)
        self.navigationController?.popViewController(animated: true)
    }
    
}
