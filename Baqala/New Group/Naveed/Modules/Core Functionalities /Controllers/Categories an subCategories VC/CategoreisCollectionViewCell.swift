//
//  CategoreisCollectionViewCell.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class CategoreisCollectionViewCell: UICollectionViewCell {
    //MARK:- protocols
    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var mytitle: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var btnCell: UIButton!
    
    //MARK:- properties and Structures
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
    }

}
