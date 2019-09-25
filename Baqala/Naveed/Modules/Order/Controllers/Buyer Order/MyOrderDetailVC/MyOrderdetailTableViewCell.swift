//
//  MyOrderdetailTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/5/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import GradientLoadingBar

class MyOrderdetailTableViewCell: UITableViewCell {
    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    @IBOutlet weak var myQty: UILabel!
    @IBOutlet weak var myStoreName: UILabel!
    @IBOutlet weak var myStatus: UILabel!
   
    @IBOutlet weak var myStatusBtn: UIButton!
    
    @IBOutlet weak var myPriceLabel: UILabel!
    @IBOutlet weak var myQtyLabel: UILabel!
    @IBOutlet weak var myStoreNameLabel: UILabel!
    @IBOutlet weak var myStatusLabel: UILabel!
  
    
    //MARK:- Properties
    var myVC: UIViewController!
    var myProductStatus: String!
    var myProductId: String?
    var myStatusEn: String?
    private var gradientLoadingBar: BottomGradientLoadingBar?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadLocalization()
        // Initialization code
        self.myContentView.setBorderColor()
        self.myContentView.setCornerRadius(radius: 4)
        
        gradientLoadingBar = BottomGradientLoadingBar(height: 4, durations: Durations.default, gradientColorList: [#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.3559298515, green: 0.7603117824, blue: 0.4029178023, alpha: 1), #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)], isRelativeToSafeArea: true, onView: self.myContentView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
    //MARK:- localization
    func loadLocalization()  {
        self.myStatusLabel.text = "Status:".localized
        self.myQtyLabel.text = "Quantity:".localized
        self.myStoreNameLabel.text = "Store Name:".localized
      
        self.setViewDirectionByLanguage()
    }
    
    func setData(model: OrderDetailModel)  {
      
        self.myImage.kf.indicatorType = .activity
        let imgeUrl = URL(string: model.product?.image ?? "")
        self.myImage.kf.setImage(with: imgeUrl , placeholder: appConstant.orderPh, options: nil, progressBlock: nil, completionHandler: nil)
      
        self.myTitle.text = setDefaultLanguage(body: (model.product?.productName)!)
        
        let price = myDefaultCurrency == .aed ? model.price?.aed : model.price?.usd
        let totalPrice = price! * Double(model.quantity!)
        
        
        
        self.myPrice.text = setDefaultCurrency(price: totalPrice)
        self.myQty.text = "\(model.quantity ?? 0)"
        self.myStatus.text = model.status?.capitalized.localized
        self.myProductStatus = model.status
        self.myStoreName.text = setDefaultLanguage(body: (model.product?.user?.storeName)!)
        self.myStatusBtn.setTitle(model.status?.capitalized.localized, for: .normal)
        self.myProductId = model.id
        
        if myOrderSelectedStatus == .shipped || model.status == "shipped"{
            self.myStatusBtn.setTitle("Received".localized, for: .normal)
        }
        
        if  model.status == "completed" || model.status == "confirmed"{
             self.myStatusBtn.isEnabled = false
             self.myStatusBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
        
       self.myStatusEn = model.status
    }
    
    @IBAction func statusBtnTapped(_ sender: Any) {
       
        if myOrderSelectedStatus == .shipped || myStatusEn == "shipped" {
            self.myVC.confirmationAlert(message: "Do you want to confirm this request?".localized) { (btns) in
                if btns == 1 {
                    self.requestToCompleteProductBy(id: self.myProductId ?? "")
                    
                }
            }
        }
        
    }
    
    //MARK:- ws: Web Services Requests
    func requestToCompleteProductBy(id: String)  {
        
        //show loader
        gradientLoadingBar?.show()
        self.myVC.view.isUserInteractionEnabled = false
        
        //service call
        OrderManager.shared.completeProductBy(orderDetailId: id, completion: { (error, rootModel) in
            
            //hide loader
            self.gradientLoadingBar?.hide()
            self.myVC.view.isUserInteractionEnabled = true
            
            if error == nil {
                
                let message = setDefaultLanguage(body: (rootModel?.message)!)
                nvMessage.showSuccess(body: message)
                self.myStatusBtn.isEnabled = false
                self.myStatusBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                delay(bySeconds: 0.5, closure: {
                   // self.myVC.navigationController?.popViewController(animated: true)
                })
                
            }
            else{
                nvMessage.showError(body: error!)
            }
        })
    }

    
}
