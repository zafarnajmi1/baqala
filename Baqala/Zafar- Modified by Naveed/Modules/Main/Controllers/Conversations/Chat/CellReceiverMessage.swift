//
//  CellReceiverMessage.swift
//  Baqala
//
//  Created by Macbook on 06/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class CellReceiverMessage: UITableViewCell {

    @IBOutlet weak var lblchatdetail: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var userimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        self.userimage.setCircle()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
