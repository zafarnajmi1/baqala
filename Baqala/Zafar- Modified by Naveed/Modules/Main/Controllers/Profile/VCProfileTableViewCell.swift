//
//  VCProfileTableViewCell.swift
//  Baqala
//
//  Created by apple on 1/23/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import UIKit

class VCProfileTableViewCell: UITableViewCell {

    //MARK:- protocols
    
    //MARK:- outlets
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myEmail: UILabel!
    @IBOutlet weak var myPhone: UILabel!
    @IBOutlet weak var myAddress: UILabel!
    @IBOutlet weak var myGender: UILabel!
    
    //Labels
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myEmailLabel: UILabel!
    @IBOutlet weak var myPhoneLabel: UILabel!
    @IBOutlet weak var myAddressLabel: UILabel!
    @IBOutlet weak var myGenderLabel: UILabel!
    
    //MARK:- properties and Structures
   
    
     //MARK:- lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.loadLocalization()
        self.myImage.setCircle()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
      //MARK:- base configuration ( on load View)
    func loadLocalization()  {
     
       self.myNameLabel.text = "Name:".localized
       self.myEmailLabel.text = "Email:".localized
       self.myPhoneLabel.text = "Phone no:".localized
       self.myAddressLabel.text = "Address:".localized
       self.myGenderLabel.text = "Gender:".localized
       self.setViewDirectionByLanguage()
    }
    
    
    
    
    func setData(model: ProfileDataModel) {
        
        
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: URL(string: model.image ?? ""), placeholder: appConstant.placeHolderUser, options: nil, progressBlock: nil, completionHandler: nil)
        let firstName = model.firstName ?? "unkown"
        let lastName = model.lastName ?? ""
        self.myName.text = "\(firstName) \(lastName)"
        self.myEmail.text = model.email ?? "unkown"
        self.myPhone.text = model.phone ?? "unkown"
        self.myGender.text = model.gender ?? "unkown"
        self.myAddress.text = model.address ?? "unkown"

        
        //save values in globals
        Sharedata.shareInfo.userImage = model.image ?? ""
        Sharedata.shareInfo.name = self.myName.text!
        Sharedata.shareInfo.email = self.myEmail.text!
        Sharedata.shareInfo.Phonenumber = self.myPhone.text!
        Sharedata.shareInfo.address = self.myAddress.text!
    
    }

}
