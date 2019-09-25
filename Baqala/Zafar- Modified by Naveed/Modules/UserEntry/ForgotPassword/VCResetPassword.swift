//
//  VCResetPassword.swift
//  Baqala
//
//  Created by Apple on 12/14/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import  NVActivityIndicatorView
class VCResetPassword: UIViewController {

    @IBOutlet weak var lblResetPassInfo: UILabel!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var txtcode: UITextField!
   
    var useremail = ""
 
   //MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.loadLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title  = "Reset Password".localized
        self.setBackButton()
    }
    
    //MARK: - Base config
    
    fileprivate func loadLocalization() {
        //buttons
        self.btnCancel.setTitle("Cancel".localized, for: .normal)
        self.btnUpdate.setTitle("Update".localized, for: .normal)
      
        //labels
        let info = "Enter  your new password and then confirm it to change your account password"
        self.lblResetPassInfo.text = info.localized
        //textfields
        self.passwordConfirm.placeholder = "Confirm Password".localized
        self.newPassword.placeholder = "New Password".localized
        self.txtcode.placeholder = "Code".localized
        
        let txtFields = [newPassword, passwordConfirm, txtcode] as [UITextField]
        //View directions
        self.setTextFieldDirectionByLanguage(textFields: txtFields)
        self.setViewDirectionByLanguage()
        
    }
  
     //MARK: - actions
    
    @IBAction func btnUpdateAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if formIsValid(){
            requestToResetPassword() //API Call
        }
    }
    
     //MARK: - Form Valditaion
    
    func formIsValid() -> Bool {
       
        let title = (self.title?.localized)!
        
        if(self.txtcode.text! == "") {
           
            let msg = "Please Enter Code".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        if (newPassword.text?.count)! < 4 {
            let msg = "Please enter valid password".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        if (passwordConfirm.text?.count)! < 4 {
            let msg = "Please enter valid confirm password".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if newPassword.text != passwordConfirm.text {
            let msg = "Confirm Password does not match, please add same password to confirm".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
    
        return true
        
    }
    
     //MARK: - API Request
    func requestToResetPassword() {
        
        print(newPassword.text!)
        let params = ["email":self.useremail,
                      "verificationCode":self.txtcode.text!,
                      "password":self.newPassword.text!,
                      "passwordConfirmation": self.passwordConfirm.text!] as [String:Any]
       
        self.showNvLoader()
        Userhandler.ResetPasswordUser(param: params as NSDictionary, Success: {(response)in
           
            self.hideNvloader()
            
            switch(response.success!) {
                
            case true:
               
                let resp = response.message
                let msg = myDefaultLanguage == .en ? resp?.en : resp?.ar
                nvMessage.showSuccess(title: (self.title?.localized)! ,body: msg ?? "Success".localized)
               
                self.moveonLogin()
                
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
    
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        moveonLogin()
        
    }
    
    
    func moveonLogin() {
        
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
