//
//  StoreDetailTableViewCell.swift
//  Baqala
//
//  Created by apple on 2/1/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import UIKit
import Cosmos

class StoreDetailTableViewCell: UITableViewCell {

    //MARK:- protocols
    
    //MARK:- outlets
    
    @IBOutlet weak var mydistance: UILabel!
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var address: UILabel!
  
    @IBOutlet weak var storeDetail: UILabel!
    @IBOutlet weak var storeDetailLabel: UILabel!
    @IBOutlet weak var storeRating: UILabel!
    @IBOutlet weak var storeRatingCosmos : CosmosView!
   
    //MARK:- properties and Structures
    
    //MARK:- lifeCycle
   

    override func awakeFromNib() {
        super.awakeFromNib()
        storeDetailLabel.text = "Description".localized
        // Initialization code
        self.myContentView.setBorderColor()
        self.myContentView.setCornerRadius(radius: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- base configuration ( on load View)
    
    func setData(root: RootStoreDetailModel)  {
      
        let dataModel = root.data!
        
        self.myTitle.text = setDefaultLanguage(body: dataModel.storeName!)
        
        let imgURL = URL(string: dataModel.image ?? "")
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: imgURL, placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
        
        self.address.text = dataModel.address
        self.mydistance.text = setDistancInKm(body: dataModel.distance ?? 0)
        self.storeDetail.text = setDefaultLanguage(body: dataModel.descriptionField!)
        self.storeRatingCosmos.rating = Double(dataModel.averageRating ?? 0)
        
        let rating = setRating(body: dataModel.averageRating ?? 0)
        let totalReviews = root.data?.reviews?.count ?? 0
        let reviews = "Reviews".localized
        self.storeRating.text = "\(rating) (\(totalReviews) \(reviews))"
    }
    
    
    
    
}
