//
//  ProductDetailTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/7/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import Cosmos
import GradientLoadingBar


//MARK:- protocols
protocol ProductDetailTableViewCellDelegate : class {
    func addToCartBtnDidTap(BadgNumber: Int )
    
}

class ProductDetailTableViewCell: UITableViewCell {
  
    //MARK:- outlets
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myPrice: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var subTitleValue: UILabel!
    @IBOutlet weak var stepperView: UIView!
    
    @IBOutlet weak var totalCounts: UILabel!
    
    @IBOutlet weak var offeredBy: UILabel!
    @IBOutlet weak var offeredByLabel: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var inStock: UILabel!
    @IBOutlet weak var rating: CosmosView!
     @IBOutlet weak var aboutProductLabel: UILabel!
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    @IBOutlet weak var cartBtnHeight: NSLayoutConstraint!
    
    
    
     //MARK:- properties and Structures
    private var count = 1
    private var qtyInStock : Int?
    private var productId = ""
    private var myRootAddProductToCartModel = RootAddProductToCartModel()
    private var ImageList = [ImageModel]()
    //Shared
    var myController: UIViewController!
    var delegate: ProductDetailTableViewCellDelegate?
    
    private var gradientLoadingBar: BottomGradientLoadingBar?
    
    
    //MARK:- lifeCycle
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.loadLocalization()
        // Initialization code
        self.stepperView.setBorderColor()
        self.totalCounts.setBorderColor()
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        self.myCollectionView.registerCustomCell(withCellId:
            "ImageCollectionViewCell")
        
        self.configCollectionCellLayout()
        
        self.configOnLoad()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadLocalization()  {
        self.aboutProductLabel.text = "About Product".localized
        self.offeredByLabel.text = "Offered By:".localized
        self.addToCartBtn.setTitle("Add To Cart".localized, for: .normal)
    }
    
    fileprivate func configOnLoad() {
       
        if myDefaultAccountType == .seller || myDefaultAccountType == .guest {
            self.cartBtnHeight.constant = -12
            self.stepperView.isHidden = true
        }
        
        gradientLoadingBar = BottomGradientLoadingBar(height: 4, durations: Durations.default, gradientColorList: [#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.3559298515, green: 0.7603117824, blue: 0.4029178023, alpha: 1), #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)], isRelativeToSafeArea: true, onView: self.addToCartBtn)
    }
    
    

    //MARK:- actions
  
    @IBAction func btnDecrement(_ sender: Any) {
       
        if self.count > 1 {
            count = count - 1
            self.totalCounts.text = "\(count)"
        }
    }
    @IBAction func btnIncrement(_ sender: Any) {
       
        if self.count >= self.qtyInStock! {
            nvMessage.showStatusWarning(body: "Stock Limit Exceed".localized)
            return
        }
        
        if self.count > 0 {
            count = count + 1
            self.totalCounts.text = "\(count)"
        }
    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
         self.requestToAddProductToCart()
    }
    
}

//MARK:- base configuration ( on load View)
extension ProductDetailTableViewCell {
    
    func setData(model: ProductDetailModel)  {
        
        self.productId = model.id ?? ""
        
        let imageUrl = model.images?.first?.imageUrl
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: imageUrl, placeholder: appConstant.storeCatePh , options: nil, progressBlock: nil, completionHandler: nil)
        
        //Format address
        let distance = setDistancInKm(body: model.user?.distance ?? 0)
        let address = "\(model.address ?? "Unkown Location") \(distance)"
        self.address.attributedText = address.stringToColor(strValue: distance, color: #colorLiteral(red: 0.1924730539, green: 0.8226674199, blue: 0.2724086046, alpha: 1))
        
        self.myPrice.text = setDefaultCurrency(body: model.price!)
        self.myTitle.text = setDefaultLanguage(body: model.productName!)
        //self.distance.text =
        self.offeredBy.text = setDefaultLanguage(body: (model.user?.storeName)!)
        self.inStock.text = setInStock(available: model.available ?? 0)
     
        self.productDetail.text = setDefaultLanguage(body: model.descriptionField!)
        
        self.rating.rating = Double(model.user?.averageRating ?? 0)
        let rating = setRating(body: model.user?.averageRating ?? 0)
        let reviwes = "Reviews".localized
        self.rating.text = " \(rating) (\(model.user?.reviewsCount ?? 0) \(reviwes))"
        
        let subLabel = setDefaultLanguage(body: model.categories![0].title!)
        self.subtitleLabel?.text = "\(subLabel):"
        self.subTitleValue.text = setDefaultLanguage(body: model.categories![1].title!)
        self.qtyInStock = model.available
        //refresh collection
        self.ImageList = model.images!
        self.myCollectionView.reloadData()
    }
    
    
    
    
    
    fileprivate func configCollectionCellLayout() {
        
        let layout = self.myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: 120, height: self.myCollectionView.bounds.size.height)
    }
    
}


//MARK:- collectionView Extension
extension ProductDetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        let  image = self.ImageList[indexPath.row]
        
        cell.myImage.kf.indicatorType = .activity
        cell.myImage.kf.setImage(with: image.imageUrl, placeholder: appConstant.productPh , options: nil, progressBlock: nil, completionHandler: nil)
       
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let  imageUrl = self.ImageList[indexPath.row].imageUrl
         self.myImage.kf.indicatorType = .activity
         self.myImage.kf.setImage(with: imageUrl, placeholder: appConstant.storeCatePh , options: nil, progressBlock: nil, completionHandler: nil)
    }
}


//MARK:- ws: Web Services Requests
extension ProductDetailTableViewCell {
    
    
    func requestToAddProductToCart() {
        //show loader
        gradientLoadingBar?.show()
        self.myController.view.isUserInteractionEnabled = true
       
        //service call
        CartManager.shared.addProductToCart(productId: self.productId , qty: self.count) { (error, rootModel) in
           
            //Hide Loader
            self.gradientLoadingBar?.hide()
            self.myController.view.isUserInteractionEnabled = true
          
            //success
            if error == nil {
                
                self.myRootAddProductToCartModel = rootModel!
                nvMessage.showStatusSuccess(body: "Cart Updated".localized)
                //reset stepper
                self.count = 1
                self.totalCounts.text = "\(self.count)"
                
                //service call to calculate total items in cart
                self.updateCartBadgeNumber()
    
            }
            else { nvMessage.showError(body: error!) }
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

