//
//  StoreListVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class StoreListVC: UIViewController {

        
        //MARK:- outlets
        @IBOutlet weak var myCollectionView: UICollectionView!
        @IBOutlet weak var searchView: UIView!
        //MARK:- properties and Structures
        //MARK:- lifeCycle
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Stores"
            self.setNavigationBar()
            self.myCollectionView.registerCustomCell(withCellId: "StoreListCollectionViewCell")
            self.configCollectionCellLayout()
            self.searchView.setLightShadow()
        }
    
        override func viewWillAppear(_ animated: Bool) {
          
        }
    
    
    }

//MARK:- actions

//MARK:- base configuration ( on load View)
extension StoreListVC {
    
    fileprivate func configCollectionCellLayout() {
        let width = (self.view.frame.size.width - 40) / 2
        let layout = self.myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: width, height: 255)
    }
    
}

//MARK:- ws: Web Services Requests

    //MARK:- collectionView Extension
    extension StoreListVC: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreListCollectionViewCell", for: indexPath) as! StoreListCollectionViewCell
//            cell.mytitle.text = "Item at: \(indexPath.row)"
//            cell.btnCell.on(.touchUpInside) { control, event in
//                self.navigateToSubCatgories()
//            }
            return cell
            
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print(indexPath.row)
            self.navigateToStoreDetail()
        }
        
    }



//MARK:- helpers ( include form Validation and other Methods )
extension StoreListVC {
   
    fileprivate func navigateToStoreDetail() {
         self.title = "Store Name"
        let storyboard = UIStoryboard(name: "Core", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StorePagerVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
