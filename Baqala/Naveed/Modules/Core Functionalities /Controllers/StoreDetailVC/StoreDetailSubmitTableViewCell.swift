//
//  StoreDetailSubmitTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/7/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

import  Cosmos
protocol StoreDetailSubmitTableViewCellDelegate {
    func refreshController()
    
 
    
}

class StoreDetailSubmitTableViewCell: UITableViewCell {
    //MARK:- outlets
    @IBOutlet weak var against: UILabel!
    @IBOutlet weak var againstLabel: UILabel!
    @IBOutlet weak var selecteProductView: UIView!
    @IBOutlet weak var btnselectProduct: UIButton!
    @IBOutlet weak var myContentView: UIView!
    
    @IBOutlet weak var productRatingGiven: CosmosView!
   
    @IBOutlet weak var reviewRating: UILabel!
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var submitReviewBtn: UIButton!
    @IBOutlet weak var submitReviewLabel: UILabel!
    @IBOutlet weak var writeReviewLabel: UILabel!
  
    //MARK:- properties and Structures
    var myVC: UIViewController?
    var storeId: String?
    var productId: String?
    var delegate:StoreDetailSubmitTableViewCellDelegate?
    
    //MARK:- lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.loadLocalization()
        self.reviewView.setBorderColor()
        productRatingGiven.settings.fillMode = .half
    }
    
    
    @IBAction func BtnSelectProductDropDown(_ sender: UIButton) {
        
      //  self.delegate?.tabpedSelectProduct(cell: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadLocalization()  {
        
        self.submitReviewBtn.setTitle("Submit Review".localized, for: .normal)
        self.againstLabel.text = "Against:".localized
        self.submitReviewLabel.text = "Submit Your Review".localized
        self.writeReviewLabel.text = "Write Your Review".localized
        
        let tvs = [myTextView] as [UITextView]
        self.setTextViewDirectionByLanguage(textViews: tvs)
    }
    
    //MARK:- base configuration ( on load View)
    func setData(root: RootStoreDetailModel )  {
        
        let canReviews = root.data?.canReviewUsers
    
        for review in canReviews! {
            self.productId = review.product?.id
            self.against.text = setDefaultLanguage(body: (review.product?.productName)!)
        }
    }
  
}


//MARK:- actions

extension StoreDetailSubmitTableViewCell {
   
    @IBAction func btnSubmitTapped(_ sender: Any) {
        
        if self.myTextView.text.count < 4 {
            nvMessage.showError(body: "Please Write review".localized)
        }
        else {
           self.requestToSubmitReview()
      
        }
       
    }
    
    

    
    //MARK:- ws: Web Services Requests
    func  requestToSubmitReview() {
        
        let dic = ["product":self.productId!,
                   "store":self.storeId!,
                   "rating":self.productRatingGiven.rating,
                   "comment":self.myTextView.text!] as [String: Any]
        
        
        self.myVC?.showNvLoader()
        
        StoreManager.shared.submitStoreReview(params: dic) { (error, root) in
        self.myVC?.hideNvloader()
            
            if error == nil {
                let msg = setDefaultLanguage(body: (root?.message)!)
                nvMessage.showSuccess(title: self.against.text!, body: msg)
                
                self.delegate?.refreshController()
                
                self.myTextView.text = ""
                self.productRatingGiven.rating = 0.0
                
            }
            else {
                nvMessage.showError(body: error!)
            }
        }
        
        
    }
}






//MARK:- tableView Extension
//MARK:- collectionView Extension

//MARK:- helpers ( include form Validation and other Methods )

