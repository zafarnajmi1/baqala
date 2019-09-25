//
//  VCEmailVerification.swift
//  Baqala
//
//  Created by Macbook on 04/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class VCEmailVerification: UIViewController {

    @IBOutlet var lblVerficationInfo: UILabel!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var btnResend: UIButton!
    @IBOutlet var enterCode: UITextField!
    @IBOutlet var emailView: UIView!
    
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.hidesBackButton = true
        //self.setBackButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.emailView.setLightGrayBorder()
        self.setCustomNavigationBar()
        self.title = "Email Verification".localized
        self.loadLocalization()
    }
    
    
    func loadLocalization() {
        
        let detail = "A verification code is sent to your email, please check your email and enter the verification code  below."
        self.lblVerficationInfo.text = detail.localized
        
        btnSubmit.setTitle("Submit".localized, for: .normal)
        btnResend.setTitle("Resend".localized, for: .normal)
        
        self.enterCode.placeholder = "Enter Verification Code".localized
        
        let textFields = [self.enterCode] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: textFields)
        self.setViewDirectionByLanguage()
        
    }


    @IBAction func BtnResendAction(_ sender: UIButton) {
        
        self.RsendVerification()
    }

    @IBAction func btnSubmitAction(_ sender: UIButton) {
        
        if formIsValid() {
            submitVerficationCode()
        }
    }
    
    //MARK: - CheckCode
    func formIsValid()-> Bool {
       
        if self.enterCode.text == ""  {
            let msg = "Please enter valid code"
            nvMessage.showError(title: (self.title?.localized)!, body: msg)
            return false
        }
        
        
     return true
    }
    
    //MARK: - EnterCodeApi
    func submitVerficationCode() {
     
        let codeDic : [String: Any] = ["verificationCode": self.enterCode.text!]
        
        self.showNvLoader()
        
        Userhandler.emailverification_seller_buyer(param: codeDic as NSDictionary, Success: {(response)in
            switch(response.success!) {
            case true:
                
                self.hideNvloader()
                
                let token = response.data?.authorization
                UserDefaults.standard.set(token, forKey: "userAuthToken")
                let resp = response.message
                let msg = myDefaultLanguage == .en ? resp?.en : resp?.ar
                nvMessage.showSuccess(title: (self.title?.localized)! ,body: msg ?? "Success".localized)
                self.moveonLogin()
                
                break
                
            case false:
                
                self.hideNvloader()
                let resp = response.message
                let msg = myDefaultLanguage == .en ? resp?.en : resp?.ar
                nvMessage.showError(title: (self.title?.localized)! ,body: msg ?? "Unkown error".localized)
                break
            }
            
        }, falioure: {(error)in
            
            self.hideNvloader()
            nvMessage.showError(title: (self.title?.localized)! ,body: error.Message)
        })
    }
    
    
    //MARK: - ResendCodeApi
    func RsendVerification() {
        print(self.email!)
       
        let  ResenDCodeDic : [String:Any] = ["email": self.email!]
        
        self.showNvLoader()
        
        Userhandler.ResendVerificationUserCode(param: ResenDCodeDic as NSDictionary, Success: {(response)in
           
            self.hideNvloader()
            
            switch(response.success!) {
            
            case true:
             
                let token = response.data?.authorization
                UserDefaults.standard.set(token, forKey: "userAuthToken")
                let resp = response.message
                let msg = myDefaultLanguage == .en ? resp?.en : resp?.ar
                nvMessage.showSuccess(title: (self.title?.localized)! ,body: msg ?? "Success".localized)
                break
           
            case false:
               
                let resp = response.message
                let msg = myDefaultLanguage == .en ? resp?.en : resp?.ar
                nvMessage.showError(title: (self.title?.localized)! ,body: msg ?? "Unkown error".localized)
                break
            }
            
        }, falioure: {(error)in
            
          self.hideNvloader()
          nvMessage.showError(title: (self.title?.localized)! ,body: error.Message)
            
        })
        
    }
    
    func moveonLogin(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
