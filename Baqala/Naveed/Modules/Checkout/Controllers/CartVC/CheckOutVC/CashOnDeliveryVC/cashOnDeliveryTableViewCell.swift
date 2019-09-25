//
//  cashOnDeliveryTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import GradientLoadingBar

class cashOnDeliveryTableViewCell: UITableViewCell {
    //MARK:- protocols
    
    
    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var emaiView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var streetView: UIView!
    @IBOutlet weak var viewforTextView: UIView!
    
    @IBOutlet weak var firstNametf: UITextField!
    @IBOutlet weak var lastNametf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var phonetf: UITextField!
    @IBOutlet weak var streettf: UITextField!
    
    @IBOutlet weak var confirmOrderBtn: UIButton!
    @IBOutlet weak var AddressTextView: KMPlaceholderTextView!
    
   
    //MARK:- properties and Structures
    var myController: UIViewController!
    var paymentMethod = "onDelivery"
    var myRootBillingModel = RootBillingAddressModel()
    
    private var gradientLoadingBar: GradientLoadingBar!
    
    
    
    
    //MARK:- lifeCycle
   
    override func awakeFromNib() {
        super.awakeFromNib()
        configFormBorders()
        
         gradientLoadingBar = BottomGradientLoadingBar(height: 4, durations: Durations.default, gradientColorList: [#colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1), #colorLiteral(red: 0.5229000449, green: 0.6485285163, blue: 0.1439691782, alpha: 1), #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)], isRelativeToSafeArea: true, onView: self.confirmOrderBtn )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK:- base configuration ( on load View)
    
    fileprivate func configFormBorders() {
        // Initialization code\
        self.firstNameView.setLightGrayBorder()
        self.lastNameView.setLightGrayBorder()
        self.emaiView.setLightGrayBorder()
        self.phoneView.setLightGrayBorder()
        self.streetView.setLightGrayBorder()
        self.viewforTextView.setLightGrayBorder()
    }
    
    
    //MARK:- actions
    
    @IBAction func confirmOrderBtnTapped(_ sender: Any) {
        
        if !isValidDeliveryForm() {
            return
        }
        
       
        
    }
    
    
    //MARK:- ws: Web Services Requests
    
    
    
    //MARK:- tableView Extension
    
    
    
    //MARK:- collectionView Extension
    
    
    //MARK:- helpers ( include form Validation and other Methods )

    
    
    
    
    

}


extension cashOnDeliveryTableViewCell {
    
    func isValidDeliveryForm() -> Bool {
        
        let title = "Cash On Delivery Form"
        
        if  (firstNametf.text?.count)! < 2 {
            let error = "First name field must be valid input"
            nvMessage.showError(title: title, body: error)
            return false
        }
        if (lastNametf.text?.count)! < 2  {
            let error = "Last name field must be valid input"
            nvMessage.showError(title: title, body: error)
            return false
        }
        
        if (phonetf.text?.count)! < 2 {
            let error = "Phone field must be valid "
            nvMessage.showError(title: title, body: error)
            return false
        }
        
        
//        if !(emailtf.text?.isValidInputEmail())! {
//            let error = "PostCode/Zip field must be valid "
//            nvMessage.showError(title: title, body: error)
//            return false
//        }
        
       
        
        
        return true
    }
    
}
