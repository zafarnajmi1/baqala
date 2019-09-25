//
//  MyCartTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import GradientLoadingBar


//MARK:- protocols
protocol MyCartTableViewCellDelegate: class {
    func totalAmountByEachProduct(amount: Double)
    func productUpdated()
    
    
}

class MyCartTableViewCell: UITableViewCell {
  
    //MARK:- outlets
    
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var stepperView: UIView!
    @IBOutlet weak var counterlbl: UILabel!
   
    //MARK:- properties and Structures
    
    var myController: UIViewController!
    var delegate: MyCartTableViewCellDelegate?
    var myRootCartModel = RootMyCardModel()
    
    private var count = 1
    private var productId = ""
    private var  myRootAddProductToCartModel = RootAddProductToCartModel()
    private var gradientLoadingBar: BottomGradientLoadingBar?
   
    
    
    //MARK:- lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.totalPriceLabel.text = "Total:".localized
        // Initialization code
        self.myContentView.setLightShadow()
        self.stepperView.setBorderColor()
        self.counterlbl.setBorderColor()
        
        //  gradientLoadingBar = BottomGradientLoadingBar(onView: self.myContentView)
        gradientLoadingBar = BottomGradientLoadingBar(height: 4, durations: Durations.default, gradientColorList: [#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.3559298515, green: 0.7603117824, blue: 0.4029178023, alpha: 1), #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)], isRelativeToSafeArea: true, onView: self.myContentView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK:- base configuration ( on load View)
    
    func setData(model: MyCartDataModel)  {
        
     
        self.myImage.kf.indicatorType = .activity
        var imageUrl = model.product?.images?.first?.imageUrl
      
        for image in (model.product?.images)! {
            if image.isDefault == true {
                imageUrl = image.imageUrl
            }
        }
        
        self.myImage.kf.setImage(with: imageUrl, placeholder: appConstant.productPh, options: nil, progressBlock: nil, completionHandler: nil)
        
        self.myTitle.text = setDefaultLanguage(body: (model.product?.productName!)!)
        self.storeName.text = setDefaultLanguage(body: (model.product?.user?.storeName!)!)
        self.address.text = model.product?.user?.address
        
        self.counterlbl.text = "\(model.quantity!)"
        self.count = model.quantity!
        self.ItemPrice.text = setDefaultCurrency(body: model.price!)
        self.totalPrice.text = setDefaultCurrency(body: model.total!)
        
        self.productId = model.product?.id ?? ""
        
        //add total amount by each product in VC
        let price = myDefaultCurrency == .aed ? model.total?.aed: model.total?.usd
        self.delegate?.totalAmountByEachProduct(amount: price!)
    }
    
    
    //MARK:- actions
    
    @IBAction func decrementBtnTapped(_ sender: Any) {
        if self.count > 1 {
            count = count - 1
            self.counterlbl.text = "\(count)"
            
             self.requestToUpdateProductId()
        }
    }
    
    @IBAction func incrementBtnTapped(_ sender: Any) {
        if self.count > 0 {
            self.count = self.count + 1
         
            self.requestToUpdateProductId()
        }
    }
    
    @IBAction func trashBtnTapped(_ sender: Any) {
        
        self.myController.confirmationAlert(message: "Do you want to remove this Product from Cart?".localized) { (option) in
            if option == 1 {
                self.requestToDeleteByProductId()
            }
        }
        
       
    }

    
    //MARK:- ws: Web Services Requests
    
    func requestToUpdateProductId() {
        
        //show loader
        self.gradientLoadingBar?.show()
        self.myController.view.isUserInteractionEnabled = false
        
        //service call
        CartManager.shared.updateProductByIdToCart(productId: self.productId, qty: count) { (error, rootModel) in
           
            //Hide Loader
            self.gradientLoadingBar?.hide()
            self.myController.view.isUserInteractionEnabled = true
           //success block
            if error == nil {
               
                //update cell values
                self.myRootAddProductToCartModel = rootModel!
                let model = self.myRootAddProductToCartModel.data
                self.counterlbl.text = "\(model!.quantity!)"
                self.ItemPrice.text = setDefaultCurrency(body: model!.price!)
                self.totalPrice.text = setDefaultCurrency(body: model!.total!)
                
                self.counterlbl.text = "\(self.count)"
               
                //refresh tableView
                self.delegate?.productUpdated()
             
            }
            else {
              
                self.count = self.count - 1
                self.counterlbl.text = "\(self.count)"
                nvMessage.showError(body: error!)
                
            }
        }
    }
    
    func requestToDeleteByProductId() {
        
        self.gradientLoadingBar?.show()
        self.myController.view.isUserInteractionEnabled = false
        
        CartManager.shared.removeProductByIdToCart(productId: self.productId) { (error, rootModel) in
            //Hide Loader
            self.gradientLoadingBar?.hide()
            self.myController.view.isUserInteractionEnabled = true
            
            if error == nil { //sucess block
                self.myRootAddProductToCartModel = rootModel!
                
               // let message = rootModel?.message?.en
               // nvMessage.showError(body: message!)
                
                //refresh tableView
                self.delegate?.productUpdated()
                
            }
            else { // error block
                nvMessage.showError(body: error!)
                
            }
            
        }
    }
    
    
    
    
    
    //MARK:- tableView Extension
    //MARK:- collectionView Extension
    //MARK:- helpers ( include form Validation and other Methods )

    
  
}
