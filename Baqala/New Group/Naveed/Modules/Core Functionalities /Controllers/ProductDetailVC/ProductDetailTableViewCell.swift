//
//  ProductDetailTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/7/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {
    //MARK:- protocols
    //MARK:- outlets
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var subTitleValue: UILabel!
    @IBOutlet weak var stepperView: UIView!
    
    @IBOutlet weak var totalCounts: UILabel!
    
    @IBOutlet weak var offeredBy: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var productDetail: UILabel!
     //MARK:- properties and Structures
      var count = 1
      let ImageList = ["Category-1","Category-2", "Category-3","Category-4"]
    //MARK:- lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.stepperView.setBorderColor()
        self.totalCounts.setBorderColor()
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        self.myCollectionView.registerCustomCell(withCellId: "ImageCollectionViewCell")
        self.configCollectionCellLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
 
    //MARK:- base configuration ( on load View)
    //MARK:- actions
  
    @IBAction func btnDecrement(_ sender: Any) {
        if self.count > 1 {
            count = count - 1
            self.totalCounts.text = "\(count)"
        }
    }
    @IBAction func btnIncrement(_ sender: Any) {
        if self.count > 0 {
            count = count + 1
            self.totalCounts.text = "\(count)"
        }
    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
       
    }
}
//MARK:- ws: Web Services Requests

//MARK:- collectionView Extension
extension ProductDetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.myImage.image = UIImage(named:  ImageList[indexPath.row])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         self.myImage.image = UIImage(named: ImageList[indexPath.row])
    }
}

//MARK:- base configuration ( on load View)
extension ProductDetailTableViewCell {
    fileprivate func configCollectionCellLayout() {
       
        let layout = self.myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: 120, height: self.myCollectionView.bounds.size.height)
    }
   
}
//MARK:- helpers ( include form Validation and other Methods )


//MARK:- helpers ( include form Validation and other Methods )
