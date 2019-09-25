//
//  ViewController.swift
//  Baqala
//
//  Created by Macbook on 30/11/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class VCSplash: UIViewController {
let Appdelegate = UIApplication.shared.delegate as! AppDelegate
    let lang = UserDefaults.standard.string(forKey: "myDefaultLanguage")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //splashDelay()
        
        //setNavigationBar()
        
       self.LoginData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    //MARK:- LodingMessage
    func ShowProccess()
    {
        self.startAnimating(Constant.NVActivitySize.size, message: Constant.LoadingMessage.MessageFeedback.rawValue, messageFont: UIFont.systemFont(ofSize: 20), type: NVActivityIndicatorType.ballClipRotate, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    
    func splashDelay()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            UIView.animate(withDuration: 0.1)
            {
                    self.performSegue(withIdentifier: "SelectLanguage", sender: self)
            
            }
        })
    }
    
    
    func LoginData()
    {
        
        if(lang == nil)
        {
            self.Appdelegate.moveToSelectlanguage()

        }else
        if(Sharedata.shareInfo.email == nil && Sharedata.shareInfo.password == nil)
        {
            self.Appdelegate.moveToLogin()
        }else
        {
        if(Sharedata.shareInfo.autoLogin!)
          {
            if(Sharedata.shareInfo.LoginType == "local")
            {
                LoginWithEmail()
                
            }else if(Sharedata.shareInfo.LoginType == "google")
            {
                if(Sharedata.shareInfo.accountType == "buyer")
                {
                   self.BuyerRegisterWithSocialMedia()
                }else{
                    
                    self.sellerRegisterWithSocialMedia()
                }
                
            }else if(Sharedata.shareInfo.LoginType == "facebook")
            {
                
                if(Sharedata.shareInfo.accountType == "buyer")
                {
                    self.BuyerRegisterWithSocialMedia()
                }else{
                    
                    self.sellerRegisterWithSocialMedia()
                }
            }
        }else{
            self.Appdelegate.moveToSocialLogin()
            
        }
            
            
      }
        
        
    }
    
    
    func LoginWithEmail()
    {
        let dicLogin = ["email":Sharedata.shareInfo.email!,"password":Sharedata.shareInfo.password!]
        self.ShowProccess()
        Userhandler.LoginUser(param: dicLogin as NSDictionary, Success: {(successResponse)in
            switch(successResponse.success!)
            {
            case true:
                self.stopAnimating()
                if(successResponse.data?.accountType == "seller")
                {
                    if((successResponse.data?.isEmailVerified)!)
                    {
                        let fullname = (successResponse.data?.firstName)! + (successResponse.data?.lastName)!
                        Sharedata.shareInfo.name = fullname
                        Sharedata.shareInfo.email = successResponse.data?.email
                        Sharedata.shareInfo.accountType = successResponse.data?.accountType
                        Sharedata.shareInfo.id = successResponse.data?._id
                        Sharedata.shareInfo.usertype = successResponse.data?.userType
                        Sharedata.shareInfo.authToken = successResponse.data?.authorization
                        //will language Check
                        Sharedata.shareInfo.StoreName = successResponse.data?.storeName?.en
                        Sharedata.shareInfo.LoginType = "local"
                         Sharedata.shareInfo.autoLogin = true
                        let token = successResponse.data?.authorization
                        UserDefaults.standard.set(token, forKey: "userAuthToken")
                        self.Appdelegate.moveToHome()
                    }else{
                        self.Appdelegate.moveToEmailVerification()
                    }
                }else{
                    if((successResponse.data?.isEmailVerified)!)
                    {
                        let fullname = (successResponse.data?.firstName)! + (successResponse.data?.lastName)!
                        Sharedata.shareInfo.name = fullname
                        Sharedata.shareInfo.email = successResponse.data?.email
                        Sharedata.shareInfo.accountType = successResponse.data?.accountType
                        Sharedata.shareInfo.id = successResponse.data?._id
                        Sharedata.shareInfo.usertype = successResponse.data?.userType
                        Sharedata.shareInfo.authToken = successResponse.data?.authorization
                        Sharedata.shareInfo.userImage = successResponse.data?.image
                         Sharedata.shareInfo.autoLogin = true
                        let token = successResponse.data?.authorization
                        UserDefaults.standard.set(token, forKey: "userAuthToken")
                         self.Appdelegate.moveToHome()
                    }else{
                        
                        self.Appdelegate.moveToEmailVerification()
                    }}
                break
            case false:
                self.stopAnimating()
                let alertView  = AlertView.NotificationAlert(title: "Error".localized, message: (successResponse.message?.en)!, okAction:{
                    self.LoginWithEmail()
                })
                self.present(alertView, animated: true, completion: nil)
                
                break
            }
        }, falioure: {(error)in
            
            self.stopAnimating()
            let alertView  = AlertView.NotificationAlert(title: "Error".localized, message: error.Message, okAction:{
                self.LoginWithEmail()
            })
            self.present(alertView, animated: true, completion: nil)
        })
        
        
    }
    
    
    
    func BuyerRegisterWithSocialMedia()
    {
        let SocialDic :[String:Any] = ["email":Sharedata.shareInfo.email!,
                                       "accessToken":Sharedata.shareInfo.socialToken!,
                                       "authMethod":Sharedata.shareInfo.authMethod!,
                                       "socialId":Sharedata.shareInfo.SocialId!,
                                       "phone":Sharedata.shareInfo.Phonenumber!,
                                       "accountType":Sharedata.shareInfo.accountType!,
                                       "address":Sharedata.shareInfo.address!,
                                       "latitude":Sharedata.shareInfo.userLatitude!,
                                       "longitude":Sharedata.shareInfo.userLongitude!,
                                       "gender":Sharedata.shareInfo.Gender!]
        self.ShowProccess()
        Userhandler.SocialLoginUser(param: SocialDic as NSDictionary, Success: {(successResponse)in
            switch(successResponse.success!)
            {
            case true:
                self.stopAnimating()
                if(successResponse.data?.isEmailVerified == true)
                {
                    let token = successResponse.data?.authorization
                    UserDefaults.standard.set(token, forKey: "userAuthToken")
                    
                    Sharedata.shareInfo.accountType = successResponse.data?.accountType
                     Sharedata.shareInfo.autoLogin = true
                    self.Appdelegate.moveToHome()
                    
                }else{
                    
                    self.Appdelegate.moveToEmailVerification()
                }
                
                break
            case false:
                
                self.stopAnimating()
                let alertView  = AlertView.NotificationAlert(title: "Error".localized, message: (successResponse.message?.en)!, okAction:{ self.BuyerRegisterWithSocialMedia()
                    })
                self.present(alertView, animated: true, completion: nil)
                break
            }
            
        }, falioure:{(error)in
            self.stopAnimating()
            let alertView  = AlertView.NotificationAlert(title: "Error".localized, message: error.Message, okAction:{
                
                self.BuyerRegisterWithSocialMedia()
            })
            self.present(alertView, animated: true, completion: nil)
            
        })
        
    }
    
    
    
    
    func sellerRegisterWithSocialMedia(){
        
        let SocialDic :[String:Any] = ["email":Sharedata.shareInfo.email!,
                                       "accessToken":Sharedata.shareInfo.socialToken!,
                                       "authMethod":Sharedata.shareInfo.authMethod!,
                                       "socialId":Sharedata.shareInfo.SocialId!,
                                       "phone":Sharedata.shareInfo.Phonenumber!,
                                       "accountType":Sharedata.shareInfo.accountType!,
                                       "address":Sharedata.shareInfo.address!,
                                       "latitude":Sharedata.shareInfo.userLatitude!,
                                       "longitude":Sharedata.shareInfo.userLongitude!,
                                       "storeName":Sharedata.shareInfo.StoreName!]
        self.ShowProccess()
        Userhandler.SocialLoginUser(param: SocialDic as NSDictionary, Success: {(successResponse)in
            switch(successResponse.success!)
            {
            case true:
                self.stopAnimating()
                if(successResponse.data?.isEmailVerified == true)
                {
                    let token = successResponse.data?.authorization
                    UserDefaults.standard.set(token, forKey: "userAuthToken")
                     Sharedata.shareInfo.accountType = successResponse.data?.accountType
                     Sharedata.shareInfo.autoLogin = true
                    self.Appdelegate.moveToHome()
                }else{
                    
                    self.Appdelegate.moveToEmailVerification()
                }
                
                break
            case false:
                
                self.stopAnimating()
                let alertView  = AlertView.NotificationAlert(title: "Error".localized, message: (successResponse.message?.en)!, okAction:{
                    self.sellerRegisterWithSocialMedia()
                })
                self.present(alertView, animated: true, completion: nil)
                break
            }
            
        }, falioure:{(error)in
            self.stopAnimating()
            let alertView  = AlertView.NotificationAlert(title: "Error".localized, message: error.Message, okAction:{
                self.sellerRegisterWithSocialMedia()
            })
            self.present(alertView, animated: true, completion: nil)
            
        })
        
    }
}

