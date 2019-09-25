//
//  NotificationTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myTime: UILabel!
    @IBOutlet weak var myDetail: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var myClearBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myContentView.setLightShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model: NotificationModel2)  {
        
        myTitle.text = setDefaultLanguage(body: model.title!)
        myDetail.text = setDefaultLanguage(body: model.descriptionField!)
        
        
        let url = URL(string:  model.sender?.image ?? "")
        myImage.kf.indicatorType = .activity
        myImage.kf.setImage(with: url, placeholder: appConstant.notificationPh, options: nil, progressBlock: nil, completionHandler: nil)
        
        self.myTime.text  = setTimeAgoFormatBy(dateString: model.createdAt!)
        
        
        if model.seen == true {
            self.colorView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        else {
            self.colorView.backgroundColor = #colorLiteral(red: 0.1924730539, green: 0.8226674199, blue: 0.2724086046, alpha: 0.2468428938)
        }

    }
    
   
}
