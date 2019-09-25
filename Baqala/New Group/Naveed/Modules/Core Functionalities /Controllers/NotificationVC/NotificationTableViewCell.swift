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
    
}
