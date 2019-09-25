//
//  OrderDetailVC.swift
//  Baqala
//
//  Created by apple on 12/5/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
//MARK:- protocols

class StoreOrderDetailVC: UIViewController {
//MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    
//MARK:- properties and Structures
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.tableView.registerCustomCell(withCellId: "StoreOrderTableViewCell")
        self.tableView.registerCustomCell(withCellId: "StoreOrderSellerInfoTableViewCell")
        self.tableView.registerCustomCell(withCellId: "StoreOrderStatusTableViewCell")
       
    }

    override func viewWillAppear(_ animated: Bool) {
        self.addBackButton()
        self.title = "Orders Detail"
    }
    
    //MARK:- actions
}


//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
extension StoreOrderDetailVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // 1: OrderSellerInfoTableViewCell 2: StoreOrderTableViewCell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return 265 // OrderSellerInfoTableViewCell
//        case 1:
//            return 156 // OrderTableViewCell
//        default:
//            return 65
//        }
//
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreOrderSellerInfoTableViewCell") as! StoreOrderSellerInfoTableViewCell
        
        switch indexPath.row {
        case 0:
           return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoreOrderTableViewCell") as! StoreOrderTableViewCell
            cell.myBtnView.isHidden = true
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoreOrderStatusTableViewCell") as! StoreOrderStatusTableViewCell
            return cell
        }
      
    }
    
}
//MARK:- collectionView Extension
//MARK:- base configuration ( on load View)
//MARK:- helpers ( include form Validation and other Methods )

