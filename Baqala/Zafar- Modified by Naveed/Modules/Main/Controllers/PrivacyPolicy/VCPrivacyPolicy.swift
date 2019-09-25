//
//  VCPrivacyPolicy.swift
//  Baqala
//
//  Created by Macbook on 06/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class VCPrivacyPolicy: UIViewController {

    @IBOutlet weak var lblPrivacy: UILabel!
    @IBOutlet weak var lblPrivacyData: UILabel!
    var privacyModel = [AboutUsTermsConditionPrivacyPolicyPages] ()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWillAppear(false)
        
        self.setViewDirectionByLanguage()
        self.lblPrivacy.text = ""
        self.lblPrivacyData.text = ""
        PrivacyPolicy()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        
        setCustomNavigationBar()
        self.setBackButton()
        self.title = "Privacy Policy".localized
    }

    
    
    
    
    func PrivacyPolicy(){
    
        self.showNvLoader()
        Userhandler.aboutUsTerms(Success: {(response)in
            self.hideNvloader()
            
            switch(response.success!) {
            case true:
              
                self.privacyModel = (response.data?.pages)!

//                let titleObj = self.privacyModel[1].title
//                let title = myDefaultLanguage == .en ? titleObj!.en?.html2String: titleObj?.ar?.html2String
//                
//                self.lblPrivacy.text = title ?? ""
                
                let detailObj = self.privacyModel[1].detail
                let detail = myDefaultLanguage == .en ? detailObj?.en?.html2String: detailObj?.ar?.html2String
                self.lblPrivacyData.text = detail ?? ""
                
            case false:
               
                let resp = response.message
                let msg = myDefaultLanguage == .en ? resp?.en : resp?.ar
                nvMessage.showError(title: self.title!.localized, body: msg ?? "Unkown error".localized)
                break
               
            }
            
        }, falioure: {(error)in
             nvMessage.showError(title: "Error".localized, body: error.Message)
            
        })
        
    }
}
