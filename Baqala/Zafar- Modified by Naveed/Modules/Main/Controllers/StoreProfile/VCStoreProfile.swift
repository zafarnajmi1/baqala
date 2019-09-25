//
//  VCStoreProfile.swift
//  Baqala
//
//  Created by Macbook on 06/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import  NVActivityIndicatorView


protocol VCStoreProfileDelegate {
    func refreshProfile(user: userProfile)
}


class VCStoreProfile: UIViewController, storeProfileUrl {
    
    
   // outlets for dynamic values
    @IBOutlet weak var storeNameEn: UILabel!
    @IBOutlet weak var storeNameAr: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var detailEn: UILabel!
    @IBOutlet weak var detailAr: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
   //outlets for Labels localizations
    @IBOutlet weak var storeNameEnLabel: UILabel!
    @IBOutlet weak var storeNameArLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailEnLabel: UILabel!
    @IBOutlet weak var detailArLabel: UILabel!
   
    
    @IBOutlet weak var myContentView: UIView!
    
    
   var delegate:VCStoreProfileDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Store Profile".localized
        self.loadLocalization()
        self.setBackButton()
        self.setEditBarBtn()
        
        
        self.myContentView.isHidden = true
        self.getstoreProfiler()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.loadLocalization()
        self.title = "Store Profile".localized
        self.setBackButton()
        self.setEditBarBtn()
    }
    
   
    
    //MARK: - Base Config
    func loadLocalization()  {
        
      
        self.storeNameEnLabel.text = "Store Name (English):".localized
        self.storeNameArLabel.text = "Store Name (Arabic):".localized
        self.phoneLabel.text = "Phone No:".localized
        self.userEmailLabel.text = "Email:".localized
        self.detailEnLabel.text = "Description (English):".localized
        self.detailArLabel.text = "Description (Arabic):".localized
        self.addressLabel.text = "Address:".localized
        
        self.setViewDirectionByLanguage()
    }
    
    
    func setEditBarBtn(){
      
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "Edit"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(btnEditProfile(_:)), for: .touchUpInside)
        let btnCart = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([btnCart], animated: true)
        
    }
    
    @objc func btnEditProfile (_ sender: Any){
        
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCStoreEditProfile") as! VCStoreEditProfile
         vc.storeDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func storeImgUrlString(string: String) {
        self.getstoreProfiler()
    }
    
    
    fileprivate func reloadData(_ response: (userProfile)) {
        
    
        
        let profile = response
        self.storeNameEn.text = profile.data?.storeName?.en?.capitalized
        self.storeNameAr.text = profile.data?.storeName?.ar
        self.userEmail.text = profile.data?.email
        self.address.text = profile.data?.address
        self.phone.text = profile.data?.phone
        self.detailEn.text = profile.data?.description?.en
        self.detailAr.text = profile.data?.description?.ar
       
        
        let ImgURL = URL(string: profile.data?.image ?? "")
       
        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: ImgURL , placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
    
        //save user data
        
        Sharedata.shareInfo.storeNameEn = response.data?.storeName?.en ?? ""
        Sharedata.shareInfo.storeNameAr = response.data?.storeName?.ar ?? ""
        Sharedata.shareInfo.userImage = profile.data?.image
        
        //update side menu profile
        self.delegate?.refreshProfile(user: response)
        
        
        
        self.myContentView.isHidden = false
    }
    
    func getstoreProfiler(){
      
        self.showNvLoader()
        Userhandler.StoreProfile(Success: {(response)in
            
            self.hideNvloader()
            
            switch(response.success!){
                
            case true:
                
                self.reloadData(response)
                
            case false:
                
                
                let msg = myDefaultLanguage == .en ? response.message?.en: response.message?.ar
                nvMessage.showError(title: self.title!.localized, body: msg ?? "Uknown Error")
                
            }
            
        }, fail: {(error)in
           
            self.hideNvloader()
            
            let msg = error.Message
            nvMessage.showError(body: msg )
        })
        
    }
    
    
    
}



