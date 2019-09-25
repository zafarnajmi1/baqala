//
//  BillingAddressTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import DLRadioButton
class BillingAddressTableViewCell: UITableViewCell {
    //MARK:- protocols
    //MARK:- outlets

    @IBOutlet weak var paymentOptionBtn: DLRadioButton!
    
    @IBOutlet weak var firstNameBilling: UITextField!
    @IBOutlet weak var lastNameBilling: UITextField!
    @IBOutlet weak var address1Billing: UITextField!
    @IBOutlet weak var address2Billing: UITextField!
    @IBOutlet weak var postalCodeBilling: UITextField!
    
    @IBOutlet weak var firstNameShipping: UITextField!
    @IBOutlet weak var lastNameShipping: UITextField!
    @IBOutlet weak var address1Shipping: UITextField!
    @IBOutlet weak var address2Shipping: UITextField!
    @IBOutlet weak var postalCodeShipping: UITextField!
    
    @IBOutlet weak var orderNotesTextView: KMPlaceholderTextView!
    //MARK:- properties and Structures
     var selectedOption = 1 // selected paypal  by defualt
     var myController : UIViewController!
    //MARK:- lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.paymentOptionBtn.isMultipleSelectionEnabled = false
        self.paymentOptionBtn.isSelected = true;
        // Configure the view for the selected state
    }
    
    //MARK:- base configuration ( on load View)
    //MARK:- actions
    
    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
            radioButton.deselectOtherButtons()
        for(_, button)  in radioButton.selectedButtons().enumerated() {
                print(button.tag)
                self.selectedOption = button.tag
            }
        
        
    }
    
    @IBAction func placeOrderBtnTapped(_ sender: Any) {
      
        switch selectedOption {
        case 2:
            self.navigateToCreditCard()
        case 3:
            self.navigateToCashOnDelivery()
        default:
              nvMessage.showError(body: "Screen Not Found")
        }
        
    }
    
    
    //MARK:- ws: Web Services Requests
    //MARK:- tableView Extension
    //MARK:- collectionView Extension
    //MARK:- helpers ( include form Validation and other Methods )
    func navigateToCreditCard() {
     let storyBoarad = UIStoryboard(name: "CheckOut", bundle: nil)
     let vc = storyBoarad.instantiateViewController(withIdentifier: "ContinueWithCreditCardVC") as! ContinueWithCreditCardVC
        self.myController.title = "Continue With Credit Card"
        self.myController.navigationController?.pushViewController(vc, animated: true)
    }
    func navigateToCashOnDelivery() {
        let storyBoarad = UIStoryboard(name: "CheckOut", bundle: nil)
        let vc = storyBoarad.instantiateViewController(withIdentifier: "CashOnDeliveryVC") as! CashOnDeliveryVC
        self.myController.title = "Cash On Delivery"
        self.myController.navigationController?.pushViewController(vc, animated: true)
    }

}
