//
//  OrderTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/4/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit


class StoreOrderTableViewCell: UITableViewCell {
    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myQty: UILabel!
    @IBOutlet weak var myDate: UILabel!
    @IBOutlet weak var myStatus: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    @IBOutlet weak var myBtnView: UIButton!
    
    @IBOutlet weak var myQtyLabel: UILabel!
    @IBOutlet weak var myDateLabel: UILabel!
    @IBOutlet weak var myStatusLabel: UILabel!
    @IBOutlet weak var myOrderId: UILabel!
    
    
    
    //MARK:- Properties
    var myVC: UIViewController!
    var indexpath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        loadLocalization()
        // Initialization code
        self.myContentView.setCornerRadius(radius: 4)
        self.myContentView.setBorderColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK:- Base config
    
    func loadLocalization()  {
        self.myStatusLabel.text = "Status:".localized
        self.myDateLabel.text = "Date:".localized
        self.myQtyLabel.text = "Quantity:".localized
        self.setViewDirectionByLanguage()
    }
    
    
    
    func setData(model: SellerOrderDataModel )  {
     
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: model.product?.imageUrl, placeholder: appConstant.orderPh, options: nil, progressBlock: nil, completionHandler: nil)
        
        self.myQty.text = "\(model.quantity ?? 0)"
        if let name = model.product?.productName {
               self.myTitle.text = setDefaultLanguage(body: name)
            self.myOrderId.text = "Order #\(model.order?.orderNumber ?? "not found")"
        }
     
        
        self.myDate.text = setDateFormatBy(dateString: model.createdAt!)
        self.myStatus.text = model.status?.capitalized.localized

        if let price = model.total {
             self.myPrice.text = setDefaultCurrency(body: price)
        }

        
    }
    
    
    
}
