//
//  myCartTotalTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class myCartTotalTableViewCell: UITableViewCell {
    //MARK:- protocols
    //MARK:- outlets
    
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var vatAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var checkOutBtn: UIButton!
    //MARK:- properties and Structures
    //MARK:- lifeCycle
    //MARK:- base configuration ( on load View)
    //MARK:- actions
    //MARK:- ws: Web Services Requests
    //MARK:- tableView Extension
    //MARK:- collectionView Extension
    //MARK:- helpers ( include form Validation and other Methods )

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
