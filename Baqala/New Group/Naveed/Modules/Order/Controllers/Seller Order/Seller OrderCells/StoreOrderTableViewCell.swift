//
//  OrderTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/4/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit


class StoreOrderTableViewCell: UITableViewCell {
    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myQty: UILabel!
    @IBOutlet weak var myDate: UILabel!
    @IBOutlet weak var myStatus: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    @IBOutlet weak var myBtnView: UIButton!
    
    //MARK:- Properties
    var myVC: UIViewController!
    var indexpath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myContentView.setCornerRadius(radius: 4)
        self.myContentView.setBorderColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- actions
    
    @IBAction func btnVIew_Pressed(_ sender: Any) {
       // nvMessage.showError(body: "Fix Me - Navigate to Order Detail Page")
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StoreOrderDetailVC")
        myVC.navigationController?.pushViewController(vc, animated: true)
    }
    
}
