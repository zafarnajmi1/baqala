//
//  MyOrderdetailTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/5/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class MyOrderdetailTableViewCell: UITableViewCell {
    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myPrice: UILabel!
    @IBOutlet weak var myQty: UILabel!
    @IBOutlet weak var myStoreName: UILabel!
    @IBOutlet weak var myStatus: UILabel!
    @IBOutlet weak var myStatusHighlighted: UILabel!
    
    //MARK:- Properties
    var myVC: UIViewController!
    var indexpath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myContentView.setBorderColor()
        self.myContentView.setCornerRadius(radius: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
