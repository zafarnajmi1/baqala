//
//  ProductListSellerTableViewCell.swift
//  Baqala
//
//  Created by apple on 1/8/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import UIKit

class ProductListSellerTableViewCell: UITableViewCell {

    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var soldBy: UILabel!
    @IBOutlet weak var soldByLabel : UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    @IBOutlet weak var inStock: UILabel!

    //MARK:- properties and Structures
    var myController: UIViewController!
    var productId = ""
    var isFromSellerMenu = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         self.myContentView.setBorderColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK:- base configuration ( on load View)
    func setData(body: ProductModel)  {
      
        let imageUrl = body.images?.first?.imageUrl
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: imageUrl, placeholder: appConstant.productPh , options: nil, progressBlock: nil, completionHandler: nil)
        
        self.myTitle.text = setDefaultLanguage(body: body.productName!)
        self.myPrice.text = setDefaultCurrency(body: body.price!)
       
        self.soldBy.text = setDefaultLanguage(body: (body.user?.storeName)!)
       
        self.address.text = body.address
        
        self.inStock.text  = setInStock(available: body.available ?? 0 )
        
        self.distance.text = setDistancInKm(body: body.distance ?? 0)
        
        let storename = Sharedata.shareInfo.storeNameEn
        let soldby = body.user?.storeName?.en ?? ""
        if myDefaultAccountType == .seller &&  storename == soldby && isFromSellerMenu == true {
            self.soldByLabel.text = "Price Criteria:".localized
            let title = body.priceType?.title
            self.soldBy.text = setDefaultLanguage(body: title!)
        }
        else {
            self.soldBy.text = setDefaultLanguage(body: (body.user?.storeName)!)
            self.soldByLabel.text = "Sold by:".localized
        }
        
        self.productId = body.id!
    }
    
}
