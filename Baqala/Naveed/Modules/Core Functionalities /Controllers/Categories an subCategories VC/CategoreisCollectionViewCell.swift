//
//  CategoreisCollectionViewCell.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class CategoreisCollectionViewCell: UICollectionViewCell {

    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var mytitle: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var btnCell: UIButton!
    
    //MARK:- properties and Structures
    
    
    
    //MARK:- lifeCycle
    var controller: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myContentView.setLightShadow()
    }

  
   
    //MARK:- base configuration ( on load View)
    func setData(body: CategoryModel)  {
        self.mytitle.text = setDefaultLanguage(body: body.title!)
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: body.imageUrl!, placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
        
    
    }
    //MARK:- helpers ( include form Validation and other Methods )

    
    
  
}
