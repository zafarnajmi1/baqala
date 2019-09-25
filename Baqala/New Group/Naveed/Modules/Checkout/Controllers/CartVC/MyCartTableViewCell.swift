//
//  MyCartTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class MyCartTableViewCell: UITableViewCell {
    //MARK:- protocols
    //MARK:- outlets
    
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var itemTotalPrice: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var stepperView: UIView!
    @IBOutlet weak var counterlbl: UILabel!
    //MARK:- properties and Structures
    var count = 1
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
        self.myContentView.setLightShadow()
        self.stepperView.setBorderColor()
        self.counterlbl.setBorderColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func decrementBtnTapped(_ sender: Any) {
        if self.count > 1 {
            count = count - 1
            self.counterlbl.text = "\(count)"
        }
    }
    
    @IBAction func incrementBtnTapped(_ sender: Any) {
        if self.count > 0 {
            count = count + 1
            self.counterlbl.text = "\(count)"
        }
    }
}
