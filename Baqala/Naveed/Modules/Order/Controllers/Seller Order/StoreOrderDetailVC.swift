//
//  OrderDetailVC.swift
//  Baqala
//
//  Created by apple on 12/5/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import GradientLoadingBar
//MARK:- protocols

class StoreOrderDetailVC: UIViewController {
    
    //MARK:- outlets
    
    @IBOutlet weak var tableView: UITableView!
    

    //MARK:- properties and Structures
    
    var myDataModel: SellerOrderDataModel!
    private var gradientLoadingBar: BottomGradientLoadingBar?
    //MARK:- lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       viewWillAppear(false)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.setBackButton()
        self.setCustomNavigationBar()
        self.title = "Orders Detail".localized
        self.tableView.registerCustomCell(withCellId: "StoreOrderTableViewCell")
        self.tableView.registerCustomCell(withCellId: "StoreOrderSellerInfoTableViewCell")
        self.tableView.registerCustomCell(withCellId: "StoreOrderStatusTableViewCell")
    }
    
    //MARK:- actions
    
    //MARK:- ws: Web Services Requests
    func requestToShipProductBy(id: String)  {
        
        //show loader
        gradientLoadingBar?.show()
        self.view.isUserInteractionEnabled = false
        
        //service call
        OrderManager.shared.shipProductBy(orderDetailId: id, completion: { (error, rootModel) in
            
            //hide loader
            self.gradientLoadingBar?.hide()
            self.view.isUserInteractionEnabled = true
            
            if error == nil {
               
                let message = setDefaultLanguage(body: (rootModel?.message)!)
                nvMessage.showSuccess(body: message)
              
                delay(bySeconds: 0.5, closure: {
                     self.navigationController?.popViewController(animated: true)
                })
              
            }
            else{
                nvMessage.showError(body: error!)
            }
        })
    }

}




//MARK:- tableView Extension
extension StoreOrderDetailVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // 1: OrderSellerInfoTableViewCell 2: StoreOrderTableViewCell
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoreOrderSellerInfoTableViewCell") as! StoreOrderSellerInfoTableViewCell
            cell.setData(model: self.myDataModel)
            
           return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoreOrderTableViewCell") as! StoreOrderTableViewCell
            cell.myBtnView.isHidden = true
            cell.setData(model: self.myDataModel)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoreOrderStatusTableViewCell") as! StoreOrderStatusTableViewCell
          
           
          
            gradientLoadingBar = BottomGradientLoadingBar(height: 4, durations: Durations.default, gradientColorList: [#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.3559298515, green: 0.7603117824, blue: 0.4029178023, alpha: 1), #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)], isRelativeToSafeArea: true, onView: cell.myContentView)
            
            switch sellerOrderSelectedStatus {
                
            case .confirmed:
                
                cell.shipBtn.setTitle("Ship".localized, for: .normal)
               
                cell.shipBtn.on(.touchUpInside) { (control, event) in
                    self.confirmationAlert(message: "Do you want to ship?".localized, completion: { (buttons) in
                        if buttons == 1 {
                              self.requestToShipProductBy(id: self.myDataModel.id!)
                        }
                    })
                  
                }
           
            case .shipped:
                cell.shipBtn.setTitle("Shipped".localized, for: .normal)
                cell.shipBtn.backgroundColor = UIColor.gray
                cell.shipBtn.isEnabled = false
            case .completed:
              cell.shipBtn.setTitle("Completed".localized, for: .normal)
              cell.shipBtn.backgroundColor = UIColor.gray
              cell.shipBtn.isEnabled = false
            }
            
            
            
            
            return cell
        }
      
    }
    
}
//MARK:- collectionView Extension
//MARK:- base configuration ( on load View)
//MARK:- helpers ( include form Validation and other Methods )

