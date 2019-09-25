//
//  ProductListTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import GradientLoadingBar

//MARK:- protocols
protocol ProductListTableViewCellDelegate : class {
    func addToCartBtnDidTap(BadgNumber: Int )
   
}

class ProductListTableViewCell: UITableViewCell {
    
    //MARK:- outlets
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var soldBy: UILabel!
    @IBOutlet weak var soldByLabel : UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var inStock: UILabel!
    @IBOutlet weak var inStockLabel: UILabel!
    //MARK:- properties and Structures
   
    var myController: UIViewController!
    var delegate: ProductListTableViewCellDelegate?
    
    private var myRootAddProductToCartModel = RootAddProductToCartModel()
    
    var count = 1
    var qtyInStock: Int?
    private var productId = ""
    private var gradientLoadingBar: BottomGradientLoadingBar?
   
    
    //MARK:- lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
       self.loadlocalization()
        
        // Initialization code
        self.myContentView.setLightShadow()
        self.counterView.setBorderColor()
        self.counter.setBorderColor()
        
        
      //  gradientLoadingBar = BottomGradientLoadingBar(onView: self.myContentView)
        gradientLoadingBar = BottomGradientLoadingBar(height: 4, durations: Durations.default, gradientColorList: [#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.3559298515, green: 0.7603117824, blue: 0.4029178023, alpha: 1), #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)], isRelativeToSafeArea: true, onView: self.myContentView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    func loadlocalization() {
       self.soldByLabel.text = "Sold by:".localized
       self.setViewDirectionByLanguage()
    }
  
    
    //MARK:- base configuration ( on load View)
    func setData(body: ProductModel)  {
        
        
        
        var imageUrl = body.images?.first?.imageUrl
    
        for image in (body.images)! {
            if image.isDefault == true {
                imageUrl = image.imageUrl
            }
        }
        
        
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: imageUrl, placeholder: appConstant.productPh , options: nil, progressBlock: nil, completionHandler: nil)
        
        self.myTitle.text = setDefaultLanguage(body: body.productName!)
        self.myPrice.text = setDefaultCurrency(body: body.price!)
        self.address.text = body.address
        self.inStock.text  = setInStock(available: body.available ?? 0 )
       
        self.distance.text = setDistancInKm(body: body.distance ?? 0)

        self.soldBy.text = setDefaultLanguage(body: (body.user?.storeName)!)
        
        self.productId = body.id!
        self.qtyInStock = body.available
    }
    
    //MARK:- actions
    @IBAction func incrementBtn(_ sender: Any) {
     
        if self.count >= self.qtyInStock! {
            nvMessage.showStatusWarning(body: "Stock Limit Exceed".localized)
            return
        }
        
        if self.count > 0 {
            count = count + 1
            self.counter.text = "\(count)"
        }
      
    }
    @IBAction func decrementBtn(_ sender: Any) {
        
        if self.count > 1 {
            count = count - 1
            self.counter.text = "\(count)"
        }
      
    }
    
    @IBAction func cartBtnTapped(_ sender: Any) {
        
        self.myController.confirmationAlert(message: "Do you want to add this Item in cart?".localized) { (option) in
            switch(option) {
            case 1:
                self.requestToAddProductToCart()
            default:
                break
            }
        }
       
    }
    
    
}


//MARK:- ws: Web Services Requests
extension ProductListTableViewCell {
   
    
    func requestToAddProductToCart() {
      
        gradientLoadingBar?.show()
        self.myController.view.isUserInteractionEnabled = false
       
        CartManager.shared.addProductToCart(productId: self.productId , qty: self.count) { (error, rootModel) in
            //Hide Loader
            self.gradientLoadingBar?.hide()
            self.myController.view.isUserInteractionEnabled = true
           
            if error == nil {
                self.myRootAddProductToCartModel = rootModel!
                nvMessage.showStatusSuccess(body: "Cart Updated".localized)
                //reset stepper
                self.count = 1
                self.counter.text = "\(self.count)"
               
                //service call to calculate total items in cart
                self.updateCartBadgeNumber()
              
            }
            else {
                nvMessage.showError(body: error!)
            }
        }
    }
    

    
    func updateCartBadgeNumber() {
        
        //loader show
        gradientLoadingBar?.show()
        self.myController.view.isUserInteractionEnabled = false
        
        CartManager.shared.fetchMyCartList { (error, rootModel) in
            
            //Hide Loader
            self.gradientLoadingBar?.hide()
            self.myController.view.isUserInteractionEnabled = true
            
            if error == nil {
                //reset total items on refresh list
                var totalItems = 0
                
                //some of each item quantity
                for model in (rootModel?.data!)!{
                    totalItems = totalItems + model.quantity!
                }
                //save totals in user defaults
                Sharedata.shareInfo.cartItemsTotal = totalItems
                
                //call delegate to update badge number on navigation
                self.delegate!.addToCartBtnDidTap(BadgNumber: totalItems )
            }
            else {nvMessage.showError(body: error!) }
        }
    }

    
}

//MARK:- ws: Helper Methods
extension ProductListTableViewCell {

}
