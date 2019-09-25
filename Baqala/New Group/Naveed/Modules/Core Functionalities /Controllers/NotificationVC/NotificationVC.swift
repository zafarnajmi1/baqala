//
//  NotificationVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    //MARK:- outlets
 
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- properties and Structures
    
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notifications"
        self.addBackButton()
        self.setNavigationBar()
        self.setNavigationBtns()
        self.tableView.registerCustomCell(withCellId: "NotificationTableViewCell")
       
    }
    
   
    
}

//MARK:- actions
//MARK:- Base Configuration
extension NotificationVC {
   
    func setNavigationBtns()
    {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "clear"), for: .normal)
        btn1.setTitle("Clear All", for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(btnClearTapped(_:)), for: .touchUpInside)
        let btnCart = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([btnCart], animated: true)
        
    }
    @objc func btnClearTapped (_ sender: Any){
        nvMessage.showError(body: "Later Implementation")
        
    }
    
}
//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        if indexPath.row / 2 == 0 {
        cell.myDetail.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu"
        }
        return cell
    }
    
    
}
//MARK:- helpers ( include form Validation and other Methods )

