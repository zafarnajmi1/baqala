//
//  AdvanceSearchVC.swift
//  Baqala
//
//  Created by apple on 12/11/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class AdvanceSearchVC: UIViewController {

    //MARK:- outlets
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- properties and Structures
    
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Advance Search"
        self.addBackButton()
        self.setNavigationBar()
        self.searchView.setLightShadow()
        self.tableView.registerCustomCell(withCellId: "AdvanceSearcTableViewCell")
        
    }
    
    
    
}

//MARK:- actions
//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
extension AdvanceSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdvanceSearcTableViewCell") as! AdvanceSearcTableViewCell
      
        return cell
    }
    
    
}
//MARK:- helpers ( include form Validation and other Methods )
