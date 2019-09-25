//
//  VCMenu.swift
//  Baqala
//
//  Created by Macbook on 04/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import SDWebImage
import MIBadgeButton_Swift


class VCMenu: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- outlets
    @IBOutlet var lbluserEamil: UILabel!
    @IBOutlet var lblusername: UILabel!
    @IBOutlet var imguserProfile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var userMenuProfileView: UIView!
    
  
    //MARK:- properties and Structures
     let appdelgate = UIApplication.shared.delegate as? AppDelegate
     let cartBadgeButton = MIBadgeButton(type: .custom)
   
    struct  userMenuModel {
        var title: String
        var image: String
    }
    
    var sellerMenuList: [userMenuModel] = []
    var buyerMenuList: [userMenuModel] = []
    var guestMenuList: [userMenuModel] = []
    var myRootSettingModel = RootSettingModel()
    
    //MARK:- lifeCycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isEmptyRowsHidden = true
      
       
        viewWillAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.configMenuByUserType()
        setCustomNavigationBar()
        // set tab title
        self.title = "Menu".localized
        // optionally, set different title for navigation controller
        self.navigationItem.title = "Baqala".localized
        
        self.imguserProfile.setCircle()
        self.tabBarController?.tabBar.isHidden = false
        
        self.setBarBtnsByAccountType(cartBadgeBtn: cartBadgeButton)
        self.refresh(cartBadgeBtn: cartBadgeButton)
        
        self.loadUserData()
    }
    
   
    //MARK:- UserImage
    func loadUserData() {
        let imgrul = URL( string:  Sharedata.shareInfo.userImage ?? "")
        self.imguserProfile.kf.indicatorType = .activity
        
        switch myDefaultAccountType {
        case .seller:
            self.imguserProfile.kf.setImage(with: imgrul, placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
            
            let data = Sharedata.shareInfo
            var storeName = myDefaultLanguage == .en ? data.storeNameEn: data.storeNameAr
            storeName = storeName == "" ? data.storeNameEn : storeName
            self.lblusername.text =  storeName?.capitalized
            self.lbluserEamil.text = Sharedata.shareInfo.email

           
        case .buyer:
            self.imguserProfile.kf.setImage(with: imgrul, placeholder: appConstant.placeHolderUser, options: nil, progressBlock: nil, completionHandler: nil)
            self.lblusername.text = Sharedata.shareInfo.name?.capitalized
            self.lbluserEamil.text = Sharedata.shareInfo.email
            
        default:
            self.lblusername.text = ""
            self.lbluserEamil.text = ""
        }
      
        
    }
    
    //MARK:- base configuration ( on load View)
    fileprivate func configMenuByUserType() {
        
        if(Sharedata.shareInfo.accountType == "buyer"){
            myDefaultAccountType = userType.buyer
            
            tableView.tableHeaderView = userMenuProfileView;
            userMenuProfileView.isHidden  =  false
             self.configBuyerMenuList()
             self.tableView.reloadData()
        }
        else if(Sharedata.shareInfo.accountType == "seller"){
            myDefaultAccountType = userType.seller
            
            tableView.tableHeaderView = userMenuProfileView
            userMenuProfileView.isHidden  =  false
            
            self.configSellerMenuList()
            self.tableView.reloadData()
        }
        else{
            myDefaultAccountType = userType.guest
            tableView.tableHeaderView = nil
            self.configGuestMenuList()
            self.tableView.reloadData()
        }

        
    }
    
    fileprivate func configSellerMenuList() {
        sellerMenuList.removeAll()
        sellerMenuList.append(userMenuModel(title: "Store Profile".localized, image: "Profile"))
        sellerMenuList.append(userMenuModel(title: "Products".localized, image: "Product"))
        sellerMenuList.append(userMenuModel(title: "Conversations".localized, image: "Conversation"))
        sellerMenuList.append(userMenuModel(title: "Orders".localized, image: "Order"))
        sellerMenuList.append(userMenuModel(title: "Payment Profile".localized, image: "Profile"))
        sellerMenuList.append(userMenuModel(title: "Rating and Reviews".localized, image: "Profile"))
        sellerMenuList.append(userMenuModel(title: "Terms & Conditions".localized, image: "Terms"))
        sellerMenuList.append(userMenuModel(title: "Privacy Policy".localized, image: "Privacy"))
        sellerMenuList.append(userMenuModel(title: "About Us".localized, image: "About"))
        sellerMenuList.append(userMenuModel(title: "Contact Us".localized, image: "Calls"))
        
        sellerMenuList.append(userMenuModel(title: "Setting".localized, image: "Setting"))
        sellerMenuList.append(userMenuModel(title: "Logout".localized, image: "logout"))
        self.tableView.reloadData()
    }
    
    fileprivate func configBuyerMenuList() {
        buyerMenuList.removeAll()
        self.buyerMenuList.append(userMenuModel(title: "Profile".localized, image: "Profile"))
        self.buyerMenuList.append(userMenuModel(title: "Conversations".localized, image: "Conversation"))
        self.buyerMenuList.append(userMenuModel(title: "My Orders".localized, image: "Order"))
        self.buyerMenuList.append(userMenuModel(title: "Terms & Conditions".localized, image: "Terms"))
        self.buyerMenuList.append(userMenuModel(title: "Privacy Policy".localized, image: "Privacy"))
        self.buyerMenuList.append(userMenuModel(title: "About Us".localized, image: "About"))
        self.buyerMenuList.append(userMenuModel(title: "Contact Us".localized, image: "Calls"))
        self.buyerMenuList.append(userMenuModel(title: "Setting".localized, image: "Setting"))
        self.buyerMenuList.append(userMenuModel(title: "Logout".localized, image: "logout"))
        self.tableView.reloadData()
    }
    
    fileprivate func configGuestMenuList() {
        guestMenuList.removeAll()
        guestMenuList.append(userMenuModel(title: "Terms & conditions".localized, image: "Terms"))
        guestMenuList.append(userMenuModel(title: "Privacy Policy".localized, image: "Privacy"))
        guestMenuList.append(userMenuModel(title: "About Us".localized, image: "About"))
        guestMenuList.append(userMenuModel(title: "Contact Us".localized, image: "Calls"))
        guestMenuList.append(userMenuModel(title: "Setting".localized, image: "Setting"))
       
        self.tableView.reloadData()
    }
    //MARK:- actions
    //MARK:- ws: Web Services Requests
    //MARK:- tableView Extension
    //MARK:- collectionView Extension
    //MARK:- helpers ( include form Validation and other Methods )
    fileprivate func buyerSelectedAtRow(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // profile
            MoveOnProfile()
            break
        case 1 :
            MoveOnConversation()
            break
        case 2:
            MoveOnMyOrders()
            break
        case 3:
            moveOnTermsAndConditions()
            break
        case 4:
            moveOnPrivacyPolicy()
            break
        case 5:
            moveOnAboutUs()
            break
        case 6:
            moveOnContact()
            break
        case 7:
            MoveOnSetting()
            break
       case 8:
            self.LogOut()
            break
        default:
            break
        }
    }
    fileprivate func sellerSelectedAtRow(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // store Profile
            self.moveOnStorProfile()
            break
        case 1 : // Products
            self.MoveOnProducts()
            break
        case 2: //converstaion
            self.MoveOnConversation()
            break
        case 3: // orders
             self.moveOnStoreOrderList()
            break
        case 4: // payment profiler
             self.moveOnPaymentProfile()
            break
        case 5: // rating reviews
            // nvMessage.showError(body: "Later Implentation")
            self.moveOnRatingReviewVC()
            break
        case 6: // terms and conditions
            self.moveOnTermsAndConditions()
        case 7: // privacy policy
            self.moveOnPrivacyPolicy()
        case 8: // about us
            self.moveOnAboutUs()
            break
        case 9: // contact us
            self.moveOnContact()
            break
        case 10: // setting
            self.MoveOnSetting()
            break
        case 11: // logout
            self.LogOut()
            break
            
        default:
            break
        }
    }
    //MARK:- GuestMenu
    fileprivate func GuestSelectedAtRow(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // terms and conditions
            self.moveOnTermsAndConditions()
        case 1: // privacy policy
            self.moveOnPrivacyPolicy()
        case 2: // about us
            self.moveOnAboutUs()
            break
        case 3: // contact us
            self.moveOnContact()
            break
        case 4: // setting
            self.MoveOnSetting()
            break
    
            
        default:
            break
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch myDefaultAccountType {
        case .seller:
             return self.sellerMenuList.count
            
        case .buyer: // Buyer
            return  self.buyerMenuList.count //self.menuArr.count
         
        case .guest:
             return  self.guestMenuList.count //Guest
        case .notExist:
            nvMessage.showError(body: "User Account type not selected")
            return 0
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu") as! cellMenu
        cell.selectionStyle = .none
        
        switch myDefaultAccountType {
        
        case .seller:
          
            let seller =  self.sellerMenuList[indexPath.row]
            cell.lblMenu.text = seller.title
            cell.imgeMenu.image = UIImage(named: seller.image)
        
        case .buyer: // Buyer
         
            let buyer =  self.buyerMenuList[indexPath.row]
            cell.lblMenu.text = buyer.title
            cell.imgeMenu.image = UIImage(named: buyer.image)
          
        case .guest:
        
            let guest =  self.guestMenuList[indexPath.row]
            cell.lblMenu.text = guest.title
            cell.imgeMenu.image = UIImage(named: guest.image)
      
        case .notExist:
            nvMessage.showError(body: "User Account type not selected")
        }
        
        
        
        
        return cell
    }
  
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        switch  myDefaultAccountType {
        
        case .seller:
            self.sellerSelectedAtRow(indexPath)
        case .buyer: // Buyer
            self.buyerSelectedAtRow(indexPath)
        case .guest:
            self.GuestSelectedAtRow(indexPath)
        case .notExist:
            nvMessage.showError(body: "User Account type not selected")
        }
    }
    
    func moveOnContact()
    {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCContactUs") as! VCContactUs
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func MoveOnProfile() {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCProfile") as! VCProfile
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveOnPaymentProfile()
    {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCPaymentProfile") as! VCPaymentProfile
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
    func MoveOnMyOrders()
    {
        let storyBoard = UIStoryboard.init(name: "Order", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "MyOrderListVC") as! MyOrderListVC
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    func MoveOnConversation()
    {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCConversation") as! VCConversation
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func MoveOnProducts()
    {
        let storyBoard = UIStoryboard.init(name: "Core", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
        vc1.isFromSellerMenu = true
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    
    
    func MoveOnSetting()
    {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCSetting") as! VCSetting
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func moveOnStorProfile()
    {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCStoreProfile") as! VCStoreProfile
        vc.delegate  = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveOnPrivacyPolicy()
    {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCPrivacyPolicy") as! VCPrivacyPolicy
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveOnRatingReviewVC()
    {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "RatingReviewVC") as! RatingReviewVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func moveOnTermsAndConditions()
    {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VcTermsAndConditions") as! VcTermsAndConditions
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveOnAboutUs()
    {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCAboutUs") as! VCAboutUs
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func moveOnStoreOrderList() {
        let storyBoard = UIStoryboard.init(name: "Order", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "StoreOrderListVC") as! StoreOrderListVC
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    
    func LogOut() {
        
        self.confirmationAlert(title: "Baqala".localized, message: "Do you want to logout?".localized) { (index) in
            switch index {
            case 1:
                self.navigateToLogout()
            default:
                print("cancel")
            }
        }
       
        
        
    }
    
    
    func navigateToLogout() {
        Sharedata.shareInfo.id = nil
        Sharedata.shareInfo.emailIsVerfied = false
        Sharedata.shareInfo.email = nil
        Sharedata.shareInfo.password = nil
        Sharedata.shareInfo.SocialId = nil
        Sharedata.shareInfo.socialToken = nil
        
        Sharedata.shareInfo.autoLogin = false
        Sharedata.shareInfo.accountType = nil
        Sharedata.shareInfo.authToken = nil
        Sharedata.shareInfo.LoginType = nil
        Sharedata.shareInfo.Gender = nil
        Sharedata.shareInfo.address = nil
        Sharedata.shareInfo.Fname = nil
        Sharedata.shareInfo.Lname = nil
        Sharedata.shareInfo.userImage = nil
        Sharedata.shareInfo.storeImage = nil
        Sharedata.shareInfo.cartItemsTotal = nil
        Sharedata.shareInfo.emailIsVerfied = false
        Sharedata.shareInfo.isFromSettingVC = false
        Sharedata.shareInfo.isLanguageSaved = false
        Sharedata.shareInfo.storeNameEn = nil
        Sharedata.shareInfo.storeNameAr = nil
      
        // move to startup screen
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.moveToSelectlanguage()

        
        
    }
    
    func moveonPaymentPRofile() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "VCPaymentProfile") as! VCPaymentProfile
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    
    
    func moveToSelectlanguage(){
      
      
    }
    
    
    func moveToSocialLogin()  {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "ContinueAsGuestandSocialLogin") as! ContinueAsGuestandSocialLogin
        self.navigationController?.pushViewController(vc1, animated: true)
    }
}


extension VCMenu: VCProfileDelegate {
   
    func refreshUserData(user: ProfileDataModel) {
        let firstName = user.firstName ?? "Unkown"
        let lastName = user.lastName ?? "Name"
        let fullName = "\(firstName) \(lastName)"
        
        self.lblusername.text = fullName
        self.lbluserEamil.text = user.email ?? "Uknown"
        
        
        self.imguserProfile.kf.indicatorType = .activity
        self.imguserProfile.kf.setImage(with: URL(string:  user.image!), placeholder: appConstant.placeHolderUser, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
    
}

extension VCMenu: VCStoreProfileDelegate {
   
    func refreshProfile(user: userProfile) {
        
        self.imguserProfile.kf.indicatorType = .activity
        self.imguserProfile.kf.setImage(with: URL(string:  user.data!.image!), placeholder: appConstant.placeHolderUser, options: nil, progressBlock: nil, completionHandler: nil)
        
        let storeName = user.data?.storeName
       
        self.lblusername.text = setDefaultLanguage(body: storeName!)
        self.lbluserEamil.text = Sharedata.shareInfo.email
        
    }
   
}

extension VCMenu   {
   
    func requestTofetchSettings() {
        
        self.showNvLoader()
        
        SettingManager.shared.fetchSettingList { (error, rootModel) in
         
            self.hideNvloader()
            
            if error == nil {
                
                self.myRootSettingModel = rootModel!
                
            }
            else {
                nvMessage.showError(body: error!)
                
            }
        }
    }
}
