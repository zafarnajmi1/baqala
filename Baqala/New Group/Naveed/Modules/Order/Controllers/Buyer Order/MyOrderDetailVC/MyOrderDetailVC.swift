//
//  MyOrderDetailVC.swift
//  Baqala
//
//  Created by apple on 12/5/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class MyOrderDetailVC: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myOrderNumber: UILabel!
    @IBOutlet weak var myTotalProducts: UILabel!
    @IBOutlet weak var myDate: UILabel!
    @IBOutlet weak var myStatus: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    //MARK:- properties and Structures
    
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCustomCell(withCellId: "MyOrderdetailTableViewCell")
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.addBackButton()
        self.title = "My Order Detail"
    }
    
    
    
}

//MARK:- actions
//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
extension MyOrderDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderdetailTableViewCell") as! MyOrderdetailTableViewCell
        cell.myVC = self
        cell.indexpath = indexPath
        return cell
    }
    
    
}
//MARK:- collectionView Extension
//MARK:- base configuration ( on load View)
//MARK:- helpers ( include form Validation and other Methods )
