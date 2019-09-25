//
//  StoreDetailSubmitTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/7/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit


class StoreDetailSubmitTableViewCell: UITableViewCell {
    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var mySubContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var storeRating: UILabel!
    @IBOutlet weak var storeDetail: UILabel!
    
    @IBOutlet weak var reviewRating: UILabel!
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var myTextView: UITextView!
    //MARK:- properties and Structures
    //MARK:- lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mySubContentView.setBorderColor()
        self.mySubContentView.setCornerRadius(radius: 4)
        self.reviewView.setBorderColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
}

//MARK:- base configuration ( on load View)
//MARK:- actions
extension StoreDetailSubmitTableViewCell {
    @IBAction func btnSubmitTapped(_ sender: Any) {
    }
}
//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
//MARK:- collectionView Extension

//MARK:- helpers ( include form Validation and other Methods )

