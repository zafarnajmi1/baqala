//
//  StoreReviewTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/7/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class StoreReviewTableViewCell: UITableViewCell {
    @IBOutlet weak var myContentView: UIView!
    
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var mydetail: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var reviewAgainst: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
