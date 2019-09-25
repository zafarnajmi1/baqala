//
//  StoreListCollectionViewCell.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import Cosmos

class StoreListCollectionViewCell: UICollectionViewCell {
 
    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var imageContenView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myRatingView: CosmosView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var myDistance: UILabel!
    @IBOutlet weak var myDetail: UILabel!

    //MARK:- properties and Structures
   
    //MARK:- lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myContentView.setLightShadow()
       
    }
    //MARK:- actions
   
    //MARK:- base configuration ( on load View)
    func setData(model: StoreModel)  {
        
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: model.imageURL, placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
       
        let rating = setRating(body: model.averageRating ?? 0)
        self.myRatingView.rating = Double(model.averageRating ?? 0)
        let reviews = "Reviews".localized
        self.myRatingView.text = "\(rating) (\(model.reviewsCount ?? 0) \(reviews))"
        
        
        let distance = setDistancInKm(body: model.distance ?? 0)
        self.myDistance.text = "\(distance)"
        
        let myAddress = "\(model.address ?? "")"
        self.address.text = myAddress
        
        self.myTitle.text = setDefaultLanguage(body: model.storeName!)
        self.myDetail.text = setDefaultLanguage(body: model.descriptionField!)
        
      
     
    }
    
    //MARK:- helpers ( include form Validation and other Methods )

   

}
