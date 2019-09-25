//
//  StoreOrderSellerInfoTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/4/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class StoreOrderSellerInfoTableViewCell: UITableViewCell {

    //MARK:- protocols
    
    
    //MARK:- outlets
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var shippingAddress: UILabel!
    @IBOutlet weak var billingAddress: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var shippingAddressLabel: UILabel!
    @IBOutlet weak var billingAddressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadLocalization()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadLocalization()  {
        self.emailLabel.text = "Email".localized
        self.phoneLabel.text = "Phone #".localized
        self.billingAddressLabel.text = "Billing Address".localized
        self.shippingAddressLabel.text = "Shipping Address".localized
    }
    
    
    //MARK:- base configuration ( on load View)
    
    func setData(model: SellerOrderDataModel)  {
        
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: model.order?.user?.imageUrl, placeholder: appConstant.orderPh, options: nil, progressBlock: nil, completionHandler: nil)
        
        let firstName = model.order?.user?.firstName ?? "unkown"
        let lastName = model.order?.user?.lastName ?? "Name"
        
        self.userName.text = "\(firstName) \(lastName)"
        self.email.text = model.order?.user?.email ?? "not found"
        self.phone.text = model.order?.user?.phone ?? "not found"
        self.billingAddress.text = model.order?.addresses?[0].address1 ?? "not found"
        self.shippingAddress.text = model.order?.addresses?[1].address1 ?? "not found"
        
    }
    
}
