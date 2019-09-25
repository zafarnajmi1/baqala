//
//  VCForgotPassword.swift
//  Baqala
//
//  Created by Macbook on 04/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class VCForgotPassword: UIViewController {

    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var btnRecover: UIButton!
    @IBOutlet var emailView: UIView!
    @IBOutlet var forgotPassInfo: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButton()
        setCustomNavigationBar()
        self.emailView.setLightGrayBorder()
        self.title = "Forgot Password".localized
      
        self.loadLocalization()
    }
    
    func loadLocalization() {
        
        let detail = "Please enter your email address to recover your password"
        self.forgotPassInfo.text = detail.localized
        
     
        btnRecover.setTitle("Recover".localized, for: .normal)
        
        self.emailAddress.placeholder = "Email Address".localized
        
        let textFields = [self.emailAddress] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: textFields)
        self.setViewDirectionByLanguage()
        
    }
    
    
    
    
   
    @IBAction func BtnRecoverAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if formIsValid() {
            requestToForgotPassword()
        }
    }
    
    func formIsValid()-> Bool{
        let title = self.title!.localized
        
        if isValid(email: self.emailAddress.text!) == false {
        let msg = "Please enter valid email".localized
            nvMessage.showError(title: title, body: msg)
        return false
        }
       return true
    }
    
    func requestToForgotPassword(){
       
        print(self.emailAddress.text!)
       
        let forgotdic: [String: Any] = ["email":self.emailAddress.text!]
        self.showNvLoader()
      
        Userhandler.ForGotPasswordUser(param: forgotdic as NSDictionary, Success: {(response)in
       
            switch(response.success!) {
           
            case true:
               
                self.hideNvloader()
               
                let resp = response.message
                let msg = myDefaultLanguage == .en ? resp?.en : resp?.ar
                nvMessage.showSuccess(title: (self.title?.localized)! ,body: msg ?? "Success".localized)
                
                self.moveToResetPassword()
                
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
    
    func moveToResetPassword(){
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCResetPassword") as! VCResetPassword
          vc.useremail = self.emailAddress.text!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
