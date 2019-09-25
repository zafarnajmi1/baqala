//
//  StoreListVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import PullToRefreshKit
import MIBadgeButton_Swift

class StoreListVC: UIViewController {

    
    //MARK:- outlets
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
  

        //MARK:- properties and Structures
        let headerPull = DefaultRefreshHeader.header()
    
        let badgeBtn = MIBadgeButton(type: .custom)
    
        var myRootStoreModel = RootStoreModel()
        var nextPage = 1
        var totalPage: Int!
        //MARK:- lifeCycle

        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Stores".localized
         
            //custom navigationBar
            self.searchView.setLightShadow()
            self.setCustomNavigationBar()
            
            //regist cell
            self.myCollectionView.registerCustomCell(withCellId: "StoreListCollectionViewCell")
            self.configCollectionCellLayout()
          
            
            //Pull to refresh Table and footer scroll
            self.refreshHeader()
            
        }
    
        override func viewWillAppear(_ animated: Bool) {
        
            self.loadLocalization()
            //show cart number if value exist
            self.refresh(cartBadgeBtn: badgeBtn)
        
        }
    
    fileprivate func loadLocalization() {
        self.searchTextField.placeholder = "Search Keyword".localized
        let tfs = [searchTextField] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
    }
    
    
    //MARK:- Actions
    
    @IBAction func btnSearchStore(_ sender: Any) {
        //disable user interaction till process is complete
        self.view.isUserInteractionEnabled = false
        self.searchTextField.isUserInteractionEnabled = false
        self.searchBtn.isUserInteractionEnabled = false
        //refresh server request
       self.refreshHeader()
    }
    
    
    
}

//MARK:- base configuration ( on load View)


extension StoreListVC {
   
    fileprivate func refreshHeader() {
        
        //disable user interaction till process is complete
        self.view.isUserInteractionEnabled = false
        self.searchTextField.isUserInteractionEnabled = false
        self.searchBtn.isUserInteractionEnabled = false
        
       
        self.myCollectionView.configRefreshHeader(with: headerPull,container:self) { [weak self] in
            //call your function to update table View
            self?.nextPage = 1
            self?.requestToFetchStoreListByUserLocation()
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
        layout.itemSize = CGSize(width: width, height: 255)
    }
    
}

//MARK:- ws: Web Services Requests
extension StoreListVC {
    
    fileprivate func updateStoreListByPagination(_ rootStoreModel: RootStoreModel?) {
        if self.nextPage == 1 { // replace
            
            self.myRootStoreModel =  rootStoreModel!
        }
        else { //append
            
            if let storeList = rootStoreModel?.data?.stores {
                self.myRootStoreModel.data?.stores!.append(contentsOf: storeList)
            }
            
            
        }
        
        //handle pagination
        let pagination = rootStoreModel!.data?.pagination
        self.totalPage = pagination?.pages
        
        if pagination!.pages! >= self.nextPage {
            self.nextPage =  (pagination?.page)! + 1
        }
    }
    
    func requestToFetchStoreListByUserLocation() {
       
        var storeName: String?
        if searchTextField.text! != "" {
            storeName = searchTextField.text!
        }
      
        StoreManager.shared.fetchStoreListby(storeName: storeName, lat: nil, long: nil, page: self.nextPage) { (error, rootStoreModel) in
            
            ProgressHUD.dismiss(animated: true)
           
            if error == nil {
                
        
                self.updateStoreListByPagination(rootStoreModel)
            
                self.myCollectionView.reloadData()
                self.myCollectionView.switchRefreshHeader(to: .normal(.success, 0.0))
               
                if self.myRootStoreModel.data?.stores?.count == 0 {
                    nvMessage.showError(title: self.title! , body: appConstant.noMoreData)
                }
            }
            else {
                nvMessage.showError(body: error!)
                self.myCollectionView.switchRefreshHeader(to: .normal(.failure, 0.0))
            }
            
            delay(bySeconds: 0.5, closure: {
                //enable user interacation
                self.view.isUserInteractionEnabled = true
                self.searchBtn.isUserInteractionEnabled = true
                self.searchTextField.isUserInteractionEnabled = true
            })
            
        }
    }
}
    //MARK:- collectionView Extension
    extension StoreListVC: UICollectionViewDelegate, UICollectionViewDataSource {
       
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
            return self.myRootStoreModel.data?.stores?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreListCollectionViewCell", for: indexPath) as! StoreListCollectionViewCell
            

                let model = self.myRootStoreModel.data?.stores![indexPath.row]
                cell.setData(model: model!)
            
            return cell
            
        }
        
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            
            if (myCollectionView.contentOffset.y + myCollectionView.frame.size.height) >= myCollectionView.contentSize.height - 20 {
                ProgressHUD.present(animated: true)
                self.requestToFetchStoreListByUserLocation()
            }
        }
        
        
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            //self.navigateToStoreDetail()
            
            let storyboard = UIStoryboard(name: "Core", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "StorePagerVC") as! StorePagerVC
            
            let model = self.myRootStoreModel.data?.stores![indexPath.row]
            vc.storeId = (model?.id)!
    
            vc.title = setDefaultLanguage(body: (model?.storeName)!)
            self.navigationController?.pushViewController(vc, animated: true)
         
        }
        
    }



