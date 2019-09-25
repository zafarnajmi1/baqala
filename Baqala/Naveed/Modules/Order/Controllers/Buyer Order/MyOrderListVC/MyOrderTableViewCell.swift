//
//  MyOrderTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/5/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell {
 
    //MARK:- outlets
   
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var orderListIcon: UIImageView!
    @IBOutlet weak var orderImgeShadow: UIImageView!
    @IBOutlet weak var myOrderNumber: UILabel!
    @IBOutlet weak var myTotalProducts: UILabel!
    @IBOutlet weak var myDate: UILabel!
    @IBOutlet weak var myStatus: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    @IBOutlet weak var myBtnView: UIButton!
    
    @IBOutlet weak var myDateLabel: UILabel!
    @IBOutlet weak var myPriceLabel: UILabel!
    @IBOutlet weak var myTotalProductsLabel: UILabel!
    @IBOutlet weak var myStatusLabel: UILabel!
    
    //MARK:- Properties
    
    var myVC: UIViewController!
    private var myRootModel = RootOrderListModel()
    private var rowIndex: Int!
    private var myOrderModel: MyOrderModel!
    //MARK:- Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.loadLocalization()
        // Initialization code
        self.myContentView.setLightShadow()
        self.orderImgeShadow.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
     //MARK:- localization
    func loadLocalization()  {
        self.myStatusLabel.text = "Status:".localized
        self.myDateLabel.text = "Date:".localized
        self.myTotalProductsLabel.text = "Total Products:".localized
        self.myPriceLabel.text = "Total Amount:".localized
        self.setViewDirectionByLanguage()
        
        if myDefaultLanguage == .ar {
            orderListIcon.image = #imageLiteral(resourceName: "Order-ListingArabic")
        }
    }
    
    
    
    
     //MARK:-  actions
    
    
    @IBAction func viewBtnTapped(_ sender: Any) {
        // nvMessage.showError(body: "Fix Me - Navigate to Order Detail Page")
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyOrderDetailVC") as! MyOrderDetailVC
        vc.myOrderDetailModel = self.myRootModel.data![rowIndex].orderDetails!
        vc.myOrderModel = self.myOrderModel
        myVC.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
   //MARK:- Base config
    
    func setData(model: RootOrderListModel, index: Int)  {
        
        self.myRootModel = model
         self.rowIndex = index
        
        let model = model.data?[index]
        guard  let dataModel  = model else {
            return
        }
        
        //set Image
        self.myImage.kf.indicatorType = .activity
        let imgURL = URL(string: dataModel.orderDetails?[0].product?.image ?? "")
        self.myImage.kf.setImage(with: imgURL, placeholder: appConstant.orderPh, options: nil, progressBlock: nil, completionHandler: nil)
        
 
        let price =  dataModel.charges
        let mytotalPrice = myDefaultCurrency == .usd ? price?.usd:price?.aed
      
        if let totalPrice = mytotalPrice {

            self.myPrice.text = setDefaultCurrency(price: totalPrice)
            if myDefaultLanguage == .ar {
                self.myPrice.textAlignment = .right
            }
        }
        
        var sum = 0
        for model in dataModel.orderDetails! {
            sum = sum + model.quantity!
        }
        self.myTotalProducts.text = "\(sum)"
    
        let totaProducts = dataModel.orderDetails?.count ?? 0
        if totaProducts > 1 {
            self.orderImgeShadow.isHidden = false
        }
        else{
            self.orderImgeShadow.isHidden = true
        }
        
        let orderLabel = "Order".localized
        let orderNumber = dataModel.orderNumber ?? ""
        self.myOrderNumber.text = "\(orderLabel) #\(orderNumber)"
        
        
        self.myDate.text = setDateFormatBy( dateString: dataModel.createdAt!)
        
      
        // format
        let totalShippd = dataModel.orderDetails!.filter { $0.status == "shipped" }
        var shipped = "Shipped".localized
        let shippedtotal = "(\(shipped) \(totalShippd.count)) "
        shipped = totalShippd.count == 0 ? "": shippedtotal
        
        let totalconfirmed = dataModel.orderDetails!.filter { $0.status == "confirmed" }
        var confirmed = "Confirmed".localized
        confirmed = totalconfirmed.count == 0 ? "": "(\(confirmed) \(totalconfirmed.count)) "
       
        let totalcompleted = dataModel.orderDetails!.filter { $0.status == "completed" }
        var completed = "Completed".localized
        completed = totalcompleted.count == 0 ? "": "(\(completed) \(totalcompleted.count)) "
        
        self.myStatus.text = shipped + confirmed + completed
 
        self.myOrderModel = MyOrderModel(id: self.myOrderNumber.text!,
                                         status: self.myStatus.text!,
                                         date: self.myDate.text!,
                                         totalProducts: self.myTotalProducts.text!,
                                         totalAmount: self.myPrice.text!)
        
    
    }
    
   
    
   
}


class MyOrderModel {
    var orderNumber: String
    var orderStatus: String
    var orderDate: String
    var totalProducts: String
    var totalAmount: String
    init(id: String, status: String,date: String,totalProducts: String,totalAmount: String) {
        self.orderNumber = id
        self.orderStatus = status
        self.orderDate = date
        self.totalAmount = totalAmount
        self.totalProducts = totalProducts
        
    }
}

