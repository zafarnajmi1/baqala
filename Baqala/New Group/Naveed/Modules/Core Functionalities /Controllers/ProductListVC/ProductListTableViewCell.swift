//
//  ProductListTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    //MARK:- protocols
    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var soldBy: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var counter: UILabel!

    //MARK:- properties and Structures
      private var count = 1
    //MARK:- lifeCycle
    //MARK:- actions
    //MARK:- ws: Web Services Requests
    //MARK:- tableView Extension
    //MARK:- collectionView Extension
    //MARK:- base configuration ( on load View)
    //MARK:- helpers ( include form Validation and other Methods )


    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myContentView.setLightShadow()
        self.counterView.setBorderColor()
        self.counter.setBorderColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func incrementBtn(_ sender: Any) {
     
        if self.count > 0 {
            count = count + 1
            self.counter.text = "\(count)"
        }
      
    }
    @IBAction func decrementBtn(_ sender: Any) {
        
        if self.count > 1 {
            count = count - 1
            self.counter.text = "\(count)"
        }
      
    }
}
