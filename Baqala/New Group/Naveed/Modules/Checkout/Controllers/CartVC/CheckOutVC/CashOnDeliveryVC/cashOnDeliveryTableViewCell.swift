//
//  cashOnDeliveryTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var AddressTextView: KMPlaceholderTextView!
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
        // Initialization code\
        self.firstNameView.setLightGrayBorder()
        self.lastNameView.setLightGrayBorder()
        self.emaiView.setLightGrayBorder()
        self.phoneView.setLightGrayBorder()
        self.streetView.setLightGrayBorder()
        self.viewforTextView.setLightGrayBorder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func confirmOrderBtnTapped(_ sender: Any) {
    }
}
