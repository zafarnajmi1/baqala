//
//  CategoriesVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import Closures
 //MARK:- protocols
class CategoriesVC: UIViewController {
   
    //MARK:- outlets
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    //MARK:- properties and Structures
    //MARK:- lifeCycle
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        self.setNavigationBar()
        self.myCollectionView.registerCustomCell(withCellId: "CategoreisCollectionViewCell")
        self.configCollectionCellLayout()
        self.searchView.setLightShadow()
    }
    //MARK:- actions
    
}


//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
//MARK:- collectionView Extension
extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoreisCollectionViewCell", for: indexPath) as! CategoreisCollectionViewCell
        cell.mytitle.text = "Item at: \(indexPath.row)"
        cell.myImage.image = UIImage(named: "Category-1")
        cell.btnCell.on(.touchUpInside) { control, event in
        self.navigateToSubCatgories()
        }
        return cell
        
    }
    
}

//MARK:- base configuration ( on load View)
extension CategoriesVC {
    fileprivate func configCollectionCellLayout() {
        let width = (self.view.frame.size.width - 40) / 2
        let layout = self.myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: width, height: 150)
    }
    fileprivate func navigateToSubCatgories() {
        let storyboard = UIStoryboard(name: "Core", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SubCategoriesVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK:- helpers ( include form Validation and other Methods )

