//
//  CellConversation.swift
//  Baqala
//
//  Created by Macbook on 06/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class CellConversation: UITableViewCell {

    @IBOutlet weak var msgDetail: UILabel!
    @IBOutlet var timeAgo: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        self.myImage.setCircle()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setData(model: ConversationModelP)  {
        
        let fullName = "\(model.user?.firstName ?? "Unkown") \(model.user?.lastName ?? "name")"
        self.name.text = fullName
        
        
        
        switch myDefaultAccountType {
        case .seller:
            let fullName = "\(model.user?.firstName ?? "Unkown") \(model.user?.lastName ?? "name")"
            self.name.text = fullName
        case .buyer:
            let store = model.store?.storeName
            self.name.text = setDefaultLanguage(body: store!)
        default:
            print("No Account Selected")
        }

        let product = model.product?.productName
        self.productName.text = setDefaultLanguage(body: product!)//
        
        
        let imageUrl = URL(string: model.product?.image ?? "")
        
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: imageUrl, placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
        
        
        
        let price = myDefaultCurrency == .usd ? model.product?.price?.usd: model.product?.price?.aed
        self.price.text =  setDefaultCurrency(price: Float(price ?? 0))
        
        
        if let date  = model.lastMessage?.createdAt {
            self.timeAgo.text = setTimeAgoFormatBy(dateString: date)
        }
        
        
        switch myDefaultLanguage {
        case .en:
            self.price.textAlignment = .right
            self.timeAgo.textAlignment = .right
        default:
             self.price.textAlignment = .left
             self.timeAgo.textAlignment = .left
        }
        
        
       
        
       
       
        if(model.lastMessage?.mimeType == "text"){
            self.msgDetail.text = model.lastMessage?.content
        }
        else{
            self.msgDetail.text = model.lastMessage?.mimeType
        }
        
    }

}
