//
//  myCartTotalTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit



class myCartTotalTableViewCell: UITableViewCell {
    
    //MARK:- outlets
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var vatAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var checkOutBtn: UIButton!
    
     //MARK:- labels for localization
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var vatAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    
    //MARK:- properties and Structures
    var subTotalAmount: Float = 0.0
   
    var myController: UIViewController!
    //MARK:- lifeCycle
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.loadLocalization()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
     //MARK:- localization
    func loadLocalization()  {
       
        self.subTotalLabel.text = "Sub Total: (Exclusive VAT)".localized
        self.vatAmountLabel.text = "VAT Amount".localized
        self.totalAmountLabel.text =  "Total (inclusive of VAT)".localized
        self.checkOutBtn.setTitle("Continue to Checkout".localized, for: .normal)
        self.setViewDirectionByLanguage()
    }

    
    //MARK:- base configuration ( on load View)
    func setData(subTotal: Double)  {
        let percentage: Double = 5/100
        let percentageAmount = subTotal * percentage
    
        self.subTotal.text = setDefaultCurrency(price: Float(subTotal))
        let totalFinal = subTotal + percentageAmount
        self.totalAmount.text = setDefaultCurrency(price: Float(totalFinal))
      
    }
 
 
    //MARK:- helpers ( include form Validation and other Methods )

  
    
}

