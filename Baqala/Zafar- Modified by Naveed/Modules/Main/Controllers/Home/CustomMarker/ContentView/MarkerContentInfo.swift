//
//  MarkerContentInfo.swift
//  Baqala
//
//  Created by Apple on 12/26/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
import  UIKit
class MarkerContentInfo: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var myImage: UIImageView!

    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MarkerContentInfo", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    
    
    func setData(Model: StoreModel)  {
        
        
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: Model.imageURL, placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
        
        let title = setDefaultLanguage(body: (Model.storeName)!)
        self.title.text = title
        let distance = Double(exactly: Model.distance ?? 0)
        self.address.text = "\(setDistancInKm(body: distance ?? 0)) away"
        self.detail.text = Model.address
        
    }

}
