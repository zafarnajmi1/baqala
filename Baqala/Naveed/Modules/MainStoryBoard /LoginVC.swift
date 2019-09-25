//
//  LoginVC.swift
//  Baqala
//
//  Created by apple on 2/4/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgetPassBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var lblNoAccount: UILabel!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
   
    //MARK: - Properties
    var myUserRootModel = RootUserLoginModel()
    var isFromContinueAsGuest = false

    override func viewDidLoad() {
        super.viewDidLoad()

     
        if isFromContinueAsGuest {
            self.setBackButton()
        }
        else {
              self.navigationItem.hidesBackButton = true
        }
        
      
        self.setCustomNavigationBar()

        self.title = "Login".localized
        self.loadLocalization()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    //
    fileprivate func loadLocalization() {
        //buttons
        self.registerBtn.setTitle("Register".localized, for: .normal)
        self.loginBtn.setTitle("Login".localized, for: .normal)
        self.forgetPassBtn.setTitle("Forgot Password?".localized, for: .normal)
       //labels
        self.lblNoAccount.text = "Don't have an account?".localized
        //textfields
        self.email.placeholder = "Enter Your Email".localized
        self.password.placeholder = "Password".localized
        
        let txtFields = [email, password] as [UITextField]
        //View directions
        self.setTextFieldDirectionByLanguage(textFields: txtFields)
        self.setViewDirectionByLanguage()
        
    }
    
    //MARK: - actions
    
    @IBAction func forgetPasswordBtnTapped(_ sender: UIButton) {
        
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCForgotPassword") as! VCForgotPassword
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if formIsValid(){
           self.requestToUserLogin()
        }
        
    }
    
    //MARK: - WS- WebServices
    func requestToUserLogin() {
       
        let params = ["email": email.text!, "password": password.text!] as [String: Any]
        
        self.showNvLoader()
        UserManager.shared.userlogin(params: params) { (error, rootModel) in
            
            self.hideNvloader()
            
            if error == nil {
                 self.myUserRootModel = rootModel!
                
                //save user data
                self.saveDataByLoginAccountType()
                
              
            }
            else {
                nvMessage.showError(title: "Login".localized , body: error!)
            }
        }
    }
    
    
   
    
    private func  saveDataByLoginAccountType() {
        
        //save authorization token
        
        Sharedata.shareInfo.authToken = myUserRootModel.data?.authorization
        let token = myUserRootModel.data?.authorization
        UserDefaults.standard.set(token, forKey: "userAuthToken")
        
        //handling session login/logout
        Sharedata.shareInfo.autoLogin = true
        
        //save info by  account type
        
        switch self.myUserRootModel.data?.accountType {
       
        case "buyer":
           
            myDefaultAccountType = .buyer
            let firstName = myUserRootModel.data?.firstName ?? "Unkown"
            let lastName = myUserRootModel.data?.lastName ?? "Name"
            Sharedata.shareInfo.name = ("\(firstName) \(lastName)")
            Sharedata.shareInfo.Fname = firstName
            Sharedata.shareInfo.Lname = lastName
        
        case "seller":
            
            myDefaultAccountType = .seller
            Sharedata.shareInfo.storeNameEn = myUserRootModel.data?.storeName?.en
            Sharedata.shareInfo.storeNameAr = myUserRootModel.data?.storeName?.ar
            Sharedata.shareInfo.paypalClientId = myUserRootModel.data?.paypalClientId
            Sharedata.shareInfo.paypalSecretId = myUserRootModel.data?.paypalSecretId
           
        default:
            myDefaultAccountType = .guest
            
        }
        
        //common in account Type
        Sharedata.shareInfo.userLongitude = (myUserRootModel.data?.location![0])!
        Sharedata.shareInfo.userLatitude =  (myUserRootModel.data?.location![1])!
       
        Sharedata.shareInfo.id = myUserRootModel.data?.id
        Sharedata.shareInfo.email = myUserRootModel.data?.email
        Sharedata.shareInfo.password = self.password.text
        
      
        Sharedata.shareInfo.accountType = myUserRootModel.data?.accountType
        Sharedata.shareInfo.usertype = myUserRootModel.data?.userType
     
        Sharedata.shareInfo.userImage = myUserRootModel.data?.image
        Sharedata.shareInfo.address = myUserRootModel.data?.address
        Sharedata.shareInfo.LoginType = "local"
       
    
        // check if user email is -> isEmailVerified
        if (self.myUserRootModel.data?.isEmailVerified)! == true {
             Sharedata.shareInfo.emailIsVerfied = true
            let appdelgate = UIApplication.shared.delegate as? AppDelegate
            appdelgate?.moveToHome()
        }
        else {
            
            Sharedata.shareInfo.emailIsVerfied = false
            self.moveToEmailVerification()
           
        }
        
        
        
    }
    
    //MARK: - navigate to email verification
    
    private func  moveToEmailVerification()
    {
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCEmailVerification") as! VCEmailVerification
        vc.email = self.email.text!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK:- Form validations
    
    func formIsValid() -> Bool {
        let title = "Login".localized
        
        if  isValid(email: email.text!) == false {
            let msg = "Please enter valid email".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        if (password.text?.count)! < 3 {
            let msg = "Please enter valid password".localized
            nvMessage.showError(title: title , body: msg)
            return false
        }
        return true
    }

}
