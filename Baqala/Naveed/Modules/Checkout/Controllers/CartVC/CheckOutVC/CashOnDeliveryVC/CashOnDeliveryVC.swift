//
//  CashOnDeliveryVC.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class CashOnDeliveryVC: UIViewController {

    //MARK:- outlets
    
    @IBOutlet weak var tableView: UITableView!

    
    //MARK:- properties and Structures
    var myRootBillingAddressModel : RootBillingAddressModel!
   
    
    //MARK:- lifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.setCustomNavigationBar()
        self.tableView.registerCustomCell(withCellId: "cashOnDeliveryTableViewCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Cash On Delivery"
        self.setBackButton()
    }
    
    
    
}

//MARK:- actions
//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
extension CashOnDeliveryVC: UITableViewDelegate, UITableViewDataSource {
   
 
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cashOnDeliveryTableViewCell") as! cashOnDeliveryTableViewCell
        cell.myRootBillingModel = myRootBillingAddressModel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//MARK:- helpers ( include form Validation and other Methods )
