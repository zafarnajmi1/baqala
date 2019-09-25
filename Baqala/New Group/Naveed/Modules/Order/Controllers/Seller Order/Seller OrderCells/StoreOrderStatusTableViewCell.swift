//
//  StoreOrderStatusTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/5/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
//MARK:- protocols

class StoreOrderStatusTableViewCell: UITableViewCell {
    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myTitle: UILabel!
    //MARK:- properties and Structures
    //MARK:- lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myContentView.setCornerRadius(radius: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


//MARK:- actions
//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
//MARK:- collectionView Extension
//MARK:- base configuration ( on load View)
//MARK:- helpers ( include form Validation and other Methods )

