//
//  BillingAddressVC.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import MIBadgeButton_Swift

class BillingAddressVC: UIViewController {
    
    
    
    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- properties and Structures
    var myCartRootModel : RootMyCardModel?
   // let cartBadgeBtn = MIBadgeButton(type: .custom)
    
    
    
    //MARK:- Paypal
    let paypalname = Notification.Name("paypal")
    var environment:String = PayPalEnvironmentSandbox {
        willSet(newEnvironment) {
            if (newEnvironment != environment){
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    //MARK:- lifeCycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWillAppear(false)
        
        self.setViewDirectionByLanguage()
     
     
     

        
        self.tableView.registerCustomCell(withCellId: "BillingAddressTableViewCell")
       
        //MARK:- PaypalEnvirment Set
        PayPalMobile.preconnect(withEnvironment: environment)
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        self.setCustomNavigationBar()
        self.setBackButton()
        self.title = "Checkout".localized
        
       // self.setBarBtnsByAccountType(cartBadgeBtn: cartBadgeBtn)
        setSellerBarBtn()
    }
    
   

    
}

//MARK:- actions
//MARK:- ws: Web Services Requests


//MARK:- tableView Extension

extension BillingAddressVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillingAddressTableViewCell") as! BillingAddressTableViewCell
        cell.myController = self
        cell.myCartRootModel = myCartRootModel!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}


