//
//  CategoriesVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import Closures
import PullToRefreshKit
import MIBadgeButton_Swift

 //MARK:- protocols
class CategoriesVC: UIViewController {
   
   
    //MARK:- outlets
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    //MARK:- properties and Structures
    
    var myCategoryModel = RootCategoryModel()
    var filteredList  = RootCategoryModel()
   
    let cartBadgeBtn = MIBadgeButton(type: .custom)
    
    //MARK:- lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories".localized
        
        self.setCustomNavigationBar()
        //self.addBackButton()
        self.myCollectionView.registerCustomCell(withCellId: "CategoreisCollectionViewCell")
        self.configCollectionCellLayout()
        self.searchView.setLightShadow()
        
       // self.requestToFetchCatgoryList()
        self.configureCollectionViewRefresh()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadLocalization()
        
        self.refresh(cartBadgeBtn: cartBadgeBtn)
        self.title = "Categories".localized
        //navigation button global config
        self.setBarBtnsByAccountType(cartBadgeBtn: cartBadgeBtn)
    }
    
    fileprivate func loadLocalization() {
        self.searchTextField.placeholder = "Search Keyword".localized
        let tfs = [searchTextField] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
    }
    
    //MARK:- Actions
    @IBAction func searchBtnTapped(_ sender: Any) {
        //disable user interaction till process is complete
        self.searchTextField.isUserInteractionEnabled = false
        self.searchBtn.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        
    
        //refresh server request
        self.configureCollectionViewRefresh()
    }
    @IBAction func searchTxtDidEditingChange(_ sender: Any) {
        

    }
    
}


//MARK:- ws: Web Services Requests
extension CategoriesVC {
   
    func requestToFetchCatgoryList() {
       
        //optional title for search
        var title: String?
        if searchTextField.text! != "" {
            title = searchTextField.text!
        }
    
        CategoryManager.shared.fetchCatgoryList(title: title) { (error, categoryModel) in
           
            if error == nil {
              
                self.myCategoryModel = categoryModel!
                self.myCollectionView.reloadData()
                self.myCollectionView.switchRefreshHeader(to: .normal(.success, 0.0))
                
                if self.myCategoryModel.data?.count == 0 {
                    nvMessage.showError(title:self.title!, body: appConstant.noMoreData)
                }
                
            }
            else {
                nvMessage.showError(body: error!)
                self.myCollectionView.switchRefreshHeader(to: .normal(.failure, 0.0))
            }
            
            delay(bySeconds: 0.5, closure: {
                self.searchTextField.isUserInteractionEnabled = true
                self.searchBtn.isUserInteractionEnabled = true
                self.view.isUserInteractionEnabled = true
            })
            
            
         }
    }
    
    
}

//MARK:- collectionView Extension
extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.myCategoryModel.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //cell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoreisCollectionViewCell", for: indexPath) as! CategoreisCollectionViewCell
       
           
            // list object
            let model = self.myCategoryModel.data![indexPath.row]
            cell.controller = self
            cell.setData(body: model)
            
            //cell actions
            cell.btnCell.on(.touchUpInside) { control, event in
                self.navigateToSubCatgories(model: model)
           
        }
        
        return cell
        
    }
    
}

//MARK:- base configuration ( on load View)
extension CategoriesVC {
    fileprivate func configureCollectionViewRefresh() {
        
       //disable interaction
        self.searchTextField.isUserInteractionEnabled = false
        self.searchBtn.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        
        let header = DefaultRefreshHeader.header()
        
       
        self.myCollectionView.configRefreshHeader(with: header,container:self) { [weak self] in
            //call your function to update table View
          
            
            self?.requestToFetchCatgoryList()
            
        }
        delay(bySeconds: 0.2, closure: {
            self.myCollectionView.switchRefreshHeader(to: .refreshing)
        })
        
    }

    fileprivate func configCollectionCellLayout() {
        let width = (self.view.frame.size.width - 40) / 2
        let layout = self.myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: width, height: 150)
    }
    
    fileprivate func navigateToSubCatgories(model: CategoryModel) {
        let storyboard = UIStoryboard(name: "Core", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SubCategoriesVC") as! SubCategoriesVC
         vc.getModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK:- helpers ( include form Validation and other Methods )

