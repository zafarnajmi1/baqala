//
//  ContinueWithCreditCardTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class ContinueWithCreditCardTableViewCell: UITableViewCell {
    //MARK:- protocols
    //MARK:- outlets
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var nameOnCardView: UIView!
    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var cardNumberView: UIView!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var ExpiryDateView: UIView!
    @IBOutlet weak var expiryDate: UITextField!
   
    @IBOutlet weak var ccvView: UIView!
    @IBOutlet weak var ccvCode: UITextField!
    @IBOutlet weak var eyeBtn: UIButton!
    
    //MARK:- properties and Structures
    //MARK:- lifeCycle

    //MARK:- base configuration ( on load View)
    //MARK:- actions
    //MARK:- ws: Web Services Requests
    //MARK:- tableView Extension
    //MARK:- collectionView Extension
    //MARK:- helpers ( include form Validation and other Methods )

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameOnCardView.setLightGrayBorder()
        self.cardNumberView.setLightGrayBorder()
        self.ExpiryDateView.setLightGrayBorder()
        self.ccvView.setLightGrayBorder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func eyeBtnTapped(_ sender: Any) {
        let isSelected = eyeBtn.isSelected
        print(isSelected)
        if isSelected {
         self.ccvCode.isSecureTextEntry = true
            eyeBtn.isSelected = false
        }
        else{
            self.ccvCode.isSecureTextEntry = false
            eyeBtn.isSelected = true
        }
        
    }
    @IBAction func payBtnTapped(_ sender: Any) {
    }
}
