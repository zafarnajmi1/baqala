//
//  MyOrderDetailVC.swift
//  Baqala
//
//  Created by apple on 12/5/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit



enum MyOrderStatus {
    case confirmed
    case shipped
    case completed
}

var myOrderSelectedStatus = MyOrderStatus.confirmed

class MyOrderDetailVC: UIViewController {

    //MARK:- outlets
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myOrderNumber: UILabel!
    @IBOutlet weak var myTotalProducts: UILabel!
    @IBOutlet weak var myDate: UILabel!
    @IBOutlet weak var myStatus: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    
    @IBOutlet weak var myDateLabel: UILabel!
    @IBOutlet weak var myPriceLabel: UILabel!
    @IBOutlet weak var myTotalProductsLabel: UILabel!
    @IBOutlet weak var myStatusLabel: UILabel!
    
    //MARK:- properties and Structures
    var myOrderDetailModel = [OrderDetailModel]()
    var myRootOrderDetail = RootOrderDetailModel()
    var myOrderModel: MyOrderModel!
   
    var orderId: String?
    
    //MARK:- lifeCycle
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppear(true)
        self.loadLocalization()
        
        self.tableView.registerCustomCell(withCellId: "MyOrderdetailTableViewCell")
        
        orderDetailRequest()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButton()
        self.title = "My Order Detail".localized
    }
    
    //MARK:- Localiztion
    func loadLocalization()  {
        self.myStatusLabel.text = "Status:".localized
        self.myDateLabel.text = "Date:".localized
        self.myTotalProductsLabel.text = "Total Products:".localized
        self.myPriceLabel.text = "Total Amount:".localized
        self.setViewDirectionByLanguage()
    }
    
     //MARK:- base config
    
    fileprivate func reloadOrderModel() {
        self.myOrderNumber.text = myOrderModel.orderNumber
        self.myDate.text = myOrderModel.orderDate
        self.myPrice.text = myOrderModel.totalAmount
        self.myTotalProducts.text = myOrderModel.totalProducts
        self.myStatus.text = myOrderModel.orderStatus
    }
    
    fileprivate func orderDetailRequest() {
        if orderId != nil {
            self.requestToGetOrderDetail()
        }
        else {
            self.reloadOrderModel()
        }
    }
    
    
    
    //MARK:- WS webservice
    func requestToGetOrderDetail()  {
        self.showNvLoader()
        OrderManager.shared.getMyOrderDetailBy(orderId: self.orderId!) { (error, rootModel) in
            self.hideNvloader()
            
            if error == nil {
                self.myOrderDetailModel = (rootModel?.data?.orderDetails)!
                self.myRootOrderDetail = rootModel!
              
                
                self.refreshOrderDetailHeader()
                
                
                self.tableView.reloadData()
            }
            else {
                let msg = setDefaultLanguage(body: (rootModel?.message)!)
                nvMessage.showError(title: self.title!, body: msg )
            }
        }
    }
    
    
    func  refreshOrderDetailHeader()  {
        
        let dataModel = self.myRootOrderDetail.data!
       
        self.myDate.text = setDateFormatBy(dateString: (dataModel.createdAt!))
      
     
        
//        var totalPrice: Double = 0.0
//        for item in (dataModel.orderDetails!) {
//            let ItemTotalPrice = myDefaultCurrency == .aed ? item.total?.aed : item.total?.usd
//            totalPrice = totalPrice + ItemTotalPrice!
//        }
//        //add vat tex
//        let percentage: Double = 5/100
//        let percentageAmount = totalPrice * percentage
//        let finalPrice  = percentageAmount + totalPrice
        
        self.myPrice.text = setDefaultCurrency(body: dataModel.charges!)
        self.myTotalProducts.text = "\(dataModel.orderDetails?.count ?? 0)"
        
 
       
        let order = "Order".localized
        self.myOrderNumber.text = "\(order) #" + dataModel.orderNumber!
        
        
        
        
        // format
        let totalShippd = dataModel.orderDetails!.filter { $0.status == "shipped" }
        let shippedStr = "Shipped".localized
        let shipped = totalShippd.count == 0 ? "": "(\(shippedStr) \(totalShippd.count)) "
        let totalconfirmed = dataModel.orderDetails!.filter { $0.status == "confirmed" }
        let confirmStr = "Confirmed".localized
        let confirmed = totalconfirmed.count == 0 ? "": "(\(confirmStr) \(totalconfirmed.count)) "
        let totalCompleted = dataModel.orderDetails!.filter {$0.status == "completed"}
        let completStr = "Completed".localized
        let completed = totalCompleted.count == 0 ? "": "(\(completStr) \(totalCompleted.count)) "
        
        self.myStatus.text = shipped + confirmed + completed
    }
    
}


//MARK:- tableView Extension


extension MyOrderDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrderDetailModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderdetailTableViewCell") as! MyOrderdetailTableViewCell
        cell.myVC = self
        cell.setData(model: myOrderDetailModel[indexPath.row])
        return cell
    }
    
    
}


