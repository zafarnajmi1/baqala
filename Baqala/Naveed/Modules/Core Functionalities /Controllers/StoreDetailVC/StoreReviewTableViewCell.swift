//
//  StoreReviewTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/7/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import  Cosmos
class StoreReviewTableViewCell: UITableViewCell {
    @IBOutlet weak var myContentView: UIView!
    
    @IBOutlet weak var comosViewRating: CosmosView!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var mydetail: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var reviewAgainst: UILabel!
    @IBOutlet weak var reviewAgainstLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        self.reviewAgainstLabel.text = "Reviewed Against:".localized
        
       //self.myContentView.setLightShadow()
        myContentView.layer.shadowColor = UIColor.black.cgColor
        myContentView.layer.shadowOpacity = 0.2
        myContentView.layer.shadowOffset = CGSize.zero
        myContentView.layer.shadowRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    //from store detail page
    func setDataBy(model: StoreReviewModel)  {
       
        let firstName = model.user?.firstName
        let lastName = model.user?.lastName
        self.myTitle.text = "\(firstName ?? "Unkown") \(lastName ?? "Name")"
        
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: URL(string: model.user?.image ?? ""), placeholder: appConstant.placeHolderUser, options: nil, progressBlock: nil, completionHandler: nil)
        
        
        
        
        let product = model.product?.productName
        let productName = setDefaultLanguage(body: product!)
        
        self.reviewAgainst.text = productName
        self.mydetail.text = model.comment
        self.comosViewRating.settings.fillMode = .precise
        self.comosViewRating.rating = Double(model.rating ?? 0)
        self.comosViewRating.settings.updateOnTouch = false
        self.rating.text = setRating(body: model.rating ?? 0)
        
        let date = model.createdAt
        self.timeAgo.text = setTimeAgoFormatBy(dateString: date ?? "")
    }

    
}
