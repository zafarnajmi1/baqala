//
//  StoreOrderListVC.swift
//  Baqala
//
//  Created by apple on 12/4/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit


//MARK:- protocols

class StoreOrderListVC: UIViewController {
    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    //MARK:- properties and Structures
  
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerCustomCell(withCellId: "StoreOrderTableViewCell")
        self.setNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.addBackButton()
        self.title = "Orders"
    }
    
    

    
}

//MARK:- actions
//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
extension StoreOrderListVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 156
//        
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreOrderTableViewCell") as! StoreOrderTableViewCell
        cell.myVC = self
        cell.indexpath = indexPath
        return cell
    }
    
    
}
//MARK:- collectionView Extension
//MARK:- base configuration ( on load View)
//MARK:- helpers ( include form Validation and other Methods )
