//
//  SubCategoriesVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class SubCategoriesVC: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    //MARK:- properties and Structures
    //MARK:- lifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.title = "Subcategory Name"
        self.searchView.setLightShadow()
        self.setNavigationBar()
        self.myCollectionView.registerCustomCell(withCellId: "CategoreisCollectionViewCell")
        self.configCollectionCellLayout()
    }
    //MARK:- actions
    
}


//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
//MARK:- collectionView Extension
extension SubCategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoreisCollectionViewCell", for: indexPath) as! CategoreisCollectionViewCell
        return cell
    }
    
    
}

//MARK:- base configuration ( on load View)
extension SubCategoriesVC {
    
    fileprivate func configCollectionCellLayout() {
        let width = (self.view.frame.size.width - 40) / 2
        let layout = self.myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: width, height: 150)
    }
}
//MARK:- helpers ( include form Validation and other Methods )
