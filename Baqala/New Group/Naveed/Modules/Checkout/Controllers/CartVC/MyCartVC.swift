//
//  MyCartVC.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class MyCartVC: UIViewController {

    //MARK:- outlets
    
    @IBOutlet weak var tableView: UITableView!
 
    
    //MARK:- properties and Structures
    
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.setNavigationBar()
        self.tableView.registerCustomCell(withCellId: "MyCartTableViewCell")
        self.tableView.registerCustomCell(withCellId: "myCartTotalTableViewCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "My Cart"
        self.addBackButton()
    }
    
    
    //MARK:- actions
    func NavigateToBilling() {
    
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BillingAddressVC") as! BillingAddressVC
        self.title = "Check Out"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
extension MyCartVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 1
        default:
            return 3
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCartTotalTableViewCell") as! myCartTotalTableViewCell
            cell.checkOutBtn.on(.touchUpInside) { control, event in
                            self.NavigateToBilling()
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartTableViewCell") as! MyCartTableViewCell
            return cell
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        
    }
    
}
//MARK:- helpers ( include form Validation and other Methods )
