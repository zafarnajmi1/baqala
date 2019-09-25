//
//  VCAboutUs.swift
//  Baqala
//
//  Created by Macbook on 06/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class VCAboutUs: UIViewController {

    @IBOutlet weak var lblFollowUs: UILabel!
    @IBOutlet weak var lblPhonenumber: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblAboutus: UILabel!
    var fbLink = ""
    var twitterLink = ""
    var gmailLink = ""
    var aboutData = [AboutUsTermsConditionPrivacyPolicySettings]()
    
    
    //MARK:- LodingMessage
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWillAppear(false)
        
        self.setViewDirectionByLanguage()
        self.lblFollowUs.text = ""
        self.lblAboutus.text = ""
        self.lblPhonenumber.text = ""
        self.lblemail.text = ""
        AboutUsdata()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setCustomNavigationBar()
        self.setBackButton()
        
        self.navigationItem.hidesBackButton = false
        self.title = "About Us".localized
    }
    
    func AboutUsdata(){
     
        self.showNvLoader()
        Userhandler.aboutUsTerms(Success: {(response)in
           self.hideNvloader()
            
            switch(response.success!) {
            case true:
              
                print(response.data?.pages?[2].detail?.en ?? "")
                self.lblAboutus.text = response.data?.pages?[2].detail?.en?.html2String
                self.fbLink = (response.data?.settings?.facebook)!
                self.twitterLink = (response.data?.settings?.twitter)!
                self.gmailLink = (response.data?.settings?.contactEmail)!
                self.lblemail.text = (response.data?.settings?.contactEmail)!
                self.lblPhonenumber.text = response.data?.settings?.contactNumber

                break
            case false:
               let resp = response.message
               let msg = myDefaultLanguage == .en ? resp?.en: resp?.ar
               nvMessage.showInfo(title: self.title!.localized, body: msg ?? "Unkown Error")
        
                break
            }
            
        }, falioure: {(error)in
           
            let alertView  = AlertView.NotificationAlert(title: "Error".localized, message: error.Message, okAction:{})
            self.present(alertView, animated: true, completion: nil)
            
        })
        
        
    }
    
    @IBAction func TwiterAction(_ sender: UIButton) {
        
        let url = URL(string: "\(self.twitterLink)")
        UIApplication.shared.open(url!)
    }
    
    @IBAction func FacebookAction(_ sender: UIButton) {
        let url = URL(string: "\(self.fbLink)")
        UIApplication.shared.open(url!)
    }
    @IBAction func GmailAction(_ sender: UIButton) {
        let url = URL(string: "\(self.gmailLink)")
        UIApplication.shared.open(url!)
        
    }
    
    
    
}
