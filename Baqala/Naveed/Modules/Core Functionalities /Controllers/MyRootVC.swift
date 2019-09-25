//
//  MyRootVC.swift
//  Baqala
//
//  Created by apple on 12/11/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class MyRootVC: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- properties and Structures

    let myControllerList = ["Advance Search",
                            "Notifcations ",
                            "Categories",
                            "Products",
                            "Stores",
                            "Store Pager",
                            "My Cart",
                            "Buyer Orders",
                            "Seller Orders"]
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    //MARK:- base configuration ( on load View)
  
    
}

//MARK:- actions
//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
extension MyRootVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myControllerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = self.myControllerList[indexPath.row]
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Core", bundle: nil)
        switch indexPath.row {
        case 0:
            let storyBoard = UIStoryboard.init(name: "Core", bundle: nil)
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "AdvanceSearchVC") as! AdvanceSearchVC
            self.navigationController?.pushViewController(vc1, animated: true)
        case 1:
            let storyBoard = UIStoryboard.init(name: "Core", bundle: nil)
            let vc2 = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
            self.navigationController?.pushViewController(vc2, animated: true)
        case 2:
            let vc3 = storyBoard.instantiateViewController(withIdentifier: "CategoriesVC") as! CategoriesVC
            self.navigationController?.pushViewController(vc3, animated: true)
        case 3:
            let storyBoard = UIStoryboard.init(name: "Core", bundle: nil)
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
            self.navigationController?.pushViewController(vc1, animated: true)
        case 4:
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "StoreListVC") as! StoreListVC
            self.navigationController?.pushViewController(vc1, animated: true)
        case 5:
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "StorePagerVC") as! StorePagerVC
            self.navigationController?.pushViewController(vc1, animated: true)
        case 6:
            let storyBoard = UIStoryboard.init(name: "CheckOut", bundle: nil)
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "MyCartVC") as! MyCartVC
            self.navigationController?.pushViewController(vc1, animated: true)
        case 7:
            let storyBoard = UIStoryboard.init(name: "Order", bundle: nil)
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "MyOrderListVC") as! MyOrderListVC
            self.navigationController?.pushViewController(vc1, animated: true)
            
        case 8:
            let storyBoard = UIStoryboard.init(name: "Order", bundle: nil)
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "StoreOrderListVC") as! StoreOrderListVC
            self.navigationController?.pushViewController(vc1, animated: true)
            
        default:
            nvMessage.showError(body: "Error")
        }
       
       
     
       
    }
    
}
//MARK:- helpers ( include form Validation and other Methods )

