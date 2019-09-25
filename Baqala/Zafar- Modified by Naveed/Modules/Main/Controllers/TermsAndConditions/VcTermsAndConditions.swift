//
//  VcTermsAndConditions.swift
//  Baqala
//
//  Created by Macbook on 06/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class VcTermsAndConditions: UIViewController {

    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myDetail: UILabel!
    
  var termdata = [AboutUsTermsConditionPrivacyPolicyPages] ()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppear(false)
        self.setViewDirectionByLanguage()
        self.myDetail.text = ""
        self.myTitle.text = ""
        self.getTermsAndConditions()
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButton()
        self.title = "Terms & Conditions".localized
    }

    func getTermsAndConditions(){
       self.showNvLoader()
        Userhandler.aboutUsTerms(Success: {(successResponse)in
            self.hideNvloader()
            switch(successResponse.success!){
            case true:
            
                 self.termdata = (successResponse.data?.pages)!
//                
//                 let titleObj = self.termdata[0].title
//                 let title = myDefaultLanguage == .en ? titleObj?.en?.html2String: titleObj?.ar?.html2String
//         
//                 self.myTitle.text = title ?? ""
                
                 let detailObj = self.termdata[0].detail
                 let detail = myDefaultLanguage == .en ? detailObj?.en?.html2String: detailObj?.ar?.html2String
                 self.myDetail.text = detail ?? ""
          
                
            case false:
               
                let resp = successResponse.message
                let msg = myDefaultLanguage == .en ? resp?.en : resp?.ar
                nvMessage.showError(title: self.title!.localized, body: msg ?? "Unkown error".localized)
                break
            }
            
        }, falioure: {(error)in
              nvMessage.showError(title: "Error".localized, body: error.Message)
    
        })
        
    }
}
