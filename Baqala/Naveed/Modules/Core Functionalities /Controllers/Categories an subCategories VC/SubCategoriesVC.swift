//
//  SubCategoriesVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import PullToRefreshKit
import MIBadgeButton_Swift

class SubCategoriesVC: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    //MARK:- properties and Structures
    var getModel: CategoryModel?
    var mySubCategoryModel = RootCategoryModel()
    var filteredList  = RootCategoryModel()
    
    
    let cartBadgeBtn = MIBadgeButton(type: .custom)
    //MARK:- lifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackButton()
        self.title = setDefaultLanguage(body: (getModel?.title)!)
        self.searchView.setLightShadow()
        self.setCustomNavigationBar()
        self.myCollectionView.registerCustomCell(withCellId: "CategoreisCollectionViewCell")
        self.configCollectionCellLayout()
        
        // self.requestToFetchCatgoryList()
        self.configureCollectionViewRefresh()
        
        self.setBarBtnsByAccountType(cartBadgeBtn: cartBadgeBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadLocalization()
        //Update badgNumber
        self.refresh(cartBadgeBtn: cartBadgeBtn)
    }
    
    fileprivate func loadLocalization() {
        self.searchTextField.placeholder = "Search Keyword".localized
        let tfs = [searchTextField] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
    }
    
    //MARK:- Actions
    @IBAction func searchBtnTapped(_ sender: Any) {
        
        //disable user interaction till process is complete
        self.view.isUserInteractionEnabled = false
        self.searchTextField.isUserInteractionEnabled = false
        self.searchBtn.isUserInteractionEnabled = false
        //refresh server request
        self.configureCollectionViewRefresh()
    }
    
    @IBAction func searchTxtDidEditingChange(_ sender: Any) {

    }
    
    
    
    
}


//MARK:- ws: Web Services Requests
extension SubCategoriesVC {
    func requestToFetchSubCatgoryList() {
        
        var title: String?
        if searchTextField.text! != "" {
            title = searchTextField.text!
        }
        
        CategoryManager.shared.fetchSubCatgoryList(title: title, model: self.getModel!)  { (error, categoryModel) in
            if error == nil {
                self.mySubCategoryModel = categoryModel!
                self.myCollectionView.reloadData()
                self.myCollectionView.switchRefreshHeader(to: .normal(.success, 0.0))
                
                if self.mySubCategoryModel.data?.count == 0 {
                    nvMessage.showError(title:self.title!, body: appConstant.noMoreData)
                  
                }
            }
            else {
                nvMessage.showError(body: error!)
                self.myCollectionView.switchRefreshHeader(to: .normal(.failure, 0.0))
            }
        }
        
        delay(bySeconds: 0.5, closure: {
            //enable user interacation
            self.searchBtn.isUserInteractionEnabled = true
            self.searchTextField.isUserInteractionEnabled = true
            self.view.isUserInteractionEnabled = true
        })
        
    }
}

//MARK:- collectionView Extension
extension SubCategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
         return self.mySubCategoryModel.data?.count ?? 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoreisCollectionViewCell", for: indexPath) as! CategoreisCollectionViewCell
        
      
        
            let model = self.mySubCategoryModel.data![indexPath.row]
            cell.setData(body: model)
            //cell actions
            cell.btnCell.onTap {
                let storyboard = UIStoryboard.init(name: "Core", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
                
                vc.categoryId = self.getModel?.id
                vc.subCatagoryId = model.id
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
     
        return cell
    }
    
    
    
}

//MARK:- base configuration ( on load View)
extension SubCategoriesVC {
    fileprivate func configureCollectionViewRefresh() {
       
        self.searchTextField.isUserInteractionEnabled = false
        self.searchBtn.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        
        let header = DefaultRefreshHeader.header()
        self.myCollectionView.configRefreshHeader(with: header,container:self) { [weak self] in
            //call your function to update table View
            self?.requestToFetchSubCatgoryList()
            
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
}





