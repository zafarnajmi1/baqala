//
//  VCChangePasword.swift
//  Baqala
//
//  Created by Macbook on 06/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class VCChangePasword: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var oldPasswordLabel: UILabel!
    @IBOutlet var NewPAsswordUiview: UIView!
    @IBOutlet var ConfirmPassswordUiview: UIView!
    @IBOutlet var CurrentPasswordUIview: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewWillAppear(false)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.loadLocalization()
        self.setBackButton()
        self.title = "Change Password".localized
        
        self.ConfirmPassswordUiview.setLightGrayBorder()
        self.NewPAsswordUiview.setLightGrayBorder()
        self.CurrentPasswordUIview.setLightGrayBorder()
    }
    
    //MARK: - Base config
    
    fileprivate func loadLocalization() {
        //buttons
        self.cancelBtn.setTitle("Cancel".localized, for: .normal)
        self.updateBtn.setTitle("Update".localized, for: .normal)
        
        //labels
     
        self.oldPasswordLabel.text = "Old Password".localized
        self.newPasswordLabel.text = "Set New Password".localized
        //textfields
        self.currentPassword.placeholder = "Current Password".localized
        self.newPassword.placeholder = "New Password".localized
        self.passwordConfirm.placeholder = "Confirm New Password".localized
        
        
        let txtFields = [newPassword, passwordConfirm, currentPassword ] as [UITextField]
        //View directions
        self.setTextFieldDirectionByLanguage(textFields: txtFields)
        self.setViewDirectionByLanguage()
        
    }
    
    
    
    
    
    @IBAction func btnActionCancel(_ sender: UIButton) {
        
         self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func updateBtnTapped(_ sender: UIButton) {
       
        self.view.endEditing(true)
        
        if formIsValid(){
            ChangePasswordSettingUser()
        }
    }
    
    
    func formIsValid()-> Bool {
      
        let title = (self.title?.localized)!
        
        if(self.currentPassword.text! == "") {
            
            let msg = "Please enter current password".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        if (newPassword.text?.count)! < 4 {
            let msg = "Please enter valid new password".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        if (passwordConfirm.text?.count)! < 4 {
            let msg = "Please enter valid confirm new password".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if newPassword.text != passwordConfirm.text {
            let msg = "Confirm new password does not match, please add same new password to confirm".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        
        return true
    }
    
    func ChangePasswordSettingUser() {
        
        let changeDic : [String: Any] = ["oldPassword": self.currentPassword.text!, "password":self.newPassword.text!,"passwordConfirmation":self.passwordConfirm.text! ]
       
        self.showNvLoader()
       
        Userhandler.changePasswordUser(param: changeDic as NSDictionary, Success: {(response)in
          
            self.hideNvloader()
            
            switch(response.success!){
           
            case true:
             
                let msg =  myDefaultLanguage == .en ? response.message?.en : response.message?.ar
                let title = self.title!.localized
                nvMessage.showSuccess(title: title, body: msg ?? "Unkown" )
                
                self.navigationController?.popViewController(animated: true)
               
                break
           
            case false:
                
                let msg =  myDefaultLanguage == .en ? response.message?.en : response.message?.ar
                let title = self.title!.localized
                nvMessage.showError(title: title , body: msg ?? "Unkown".localized )
                break
            }
            
            
        }, falioure: {(error)in
          
            self.hideNvloader()
             nvMessage.showError(body: error.Message)
            
        })
    }
    
}
