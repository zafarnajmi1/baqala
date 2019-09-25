//
//  Userhandler.swift
//  Baqala
//
//  Created by Apple on 12/12/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Userhandler {
    
    //MARK:- RegisterUserSellerOrBuyer
    class func Register(param: [String: Any], Success: @escaping (RegisterSellerBuyer)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
     let url = Constant.MainUrl + Constant.Urls.RegisterUrl
        
        Networkhandler.PostRequest(url: url, parameters: param, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = RegisterSellerBuyer.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
      
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))

        })
    }
    
    //MARK:- EmailVerification
    class func emailverification_seller_buyer(param: NSDictionary, Success: @escaping (Emailverification)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.EmailverificationUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = Emailverification.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    
    //MARK:- Login
    class func LoginUser(param: NSDictionary, Success: @escaping (Login)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.LoginUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = Login.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    //MARK:- ResendVerificationCode
    class func ResendVerificationUserCode(param: NSDictionary, Success: @escaping (ResendVerificationCode)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.resendVerificationCodeUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = ResendVerificationCode.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    
    //MARK:- ForGOtPassword
    class func ForGotPasswordUser(param: NSDictionary, Success: @escaping (ForGotPassword)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.ForgorPasswordUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = ForGotPassword.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    //MARK:- ResetPassword
    class func ResetPasswordUser(param: NSDictionary, Success: @escaping (ResetPassword)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.resetPasswordUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = ResetPassword.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    
    
    //MARK:- UserProfile
    class func userprofileUser( Success: @escaping (userProfile)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.userProfileUrl
        
        Networkhandler.GetRequest(url: url, parameters: nil, Success:{(Successresponse)in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = userProfile.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Faloiur: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    
    
    //MARK:- ContactUs
    class func ContactUsUser(param: NSDictionary, Success: @escaping (ContactUs)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.ContactUsUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = ContactUs.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    
    
    //MARK:- ChangePassword
    class func changePasswordUser(param: NSDictionary, Success: @escaping (changePassword)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.changePasswordUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = changePassword.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    //MARK:- AboutUSTermsConditionsPrivacyPolicy
    class func aboutUsTerms( Success: @escaping (AboutUsTermsConditionPrivacyPolicy)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.SetingsUrl
        
        Networkhandler.GetRequest(url: url, parameters: nil, Success:{(Successresponse)in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = AboutUsTermsConditionPrivacyPolicy.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Faloiur: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    
    //MARK:- StoreProfile
    class func StoreProfile( Success: @escaping (userProfile)-> Void , fail: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.userProfileUrl
        
        Networkhandler.GetRequest(url: url, parameters: nil, Success:{(Successresponse)in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = userProfile.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Faloiur: {(error) in
            
            fail(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    
    //MARK:- StoreUpdate
    class func StoreUpdateProfile(param: NSDictionary, Success: @escaping (StoreUpdate)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.StoreUpdateUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = StoreUpdate.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    //MARK:- SocialLogin
    class func SocialLoginUser(param: NSDictionary, Success: @escaping (SocialLogin)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.SocialLoginUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = SocialLogin.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    
    //MARK:- PaymentProfile
    class func PaymentProfileSeller(param: NSDictionary, Success: @escaping (paymentProfile)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.PaymentProfileUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = paymentProfile.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    //MARK: StoreDetail
    
    class func storeDetailUser(param: NSDictionary, Success: @escaping (storeDetail)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.StoreDetailUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = storeDetail.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    
    //MARK: StoreReviews
    
//    class func storeReviewsUser(param: NSDictionary, Success: @escaping (StoreReviews)-> Void , falioure: @escaping (NetWorkError)->Void )
//    {
//        let url = Constant.MainUrl + Constant.Urls.StoreReviewsUrl
//        
//        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
//            let registerResponse = Successresponse as! [String: Any]
//            let RegisterModelResoponse = StoreReviews.init(dictionary: registerResponse as NSDictionary)
//            
//            Success(RegisterModelResoponse!)
//            print(RegisterModelResoponse!)
//        }, Falioure: {(error) in
//            
//            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
//            
//        })
//    }
//    
    
    //MARK: SubmitStoreReviews
    
    class func SubmitstoreReviewsUser(param: NSDictionary, Success: @escaping (SubmitstoreReview)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.SubmitStoreReviewsUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = SubmitstoreReview.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    //MARK: UpdateUserProfile
    
    class func updateUserProfile(param: [String: Any], Success: @escaping (UpdateProfile)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.userProfileUpdateUrl
        
        Networkhandler.PostRequest(url: url, parameters: param, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = UpdateProfile.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    
    //MARK:- PaymentPaypal
    
    class func paypalPayment(param: NSDictionary, Success: @escaping (payment)-> Void , falioure: @escaping (NetWorkError)->Void )
    {
        let url = Constant.MainUrl + Constant.Urls.PamentpaypalUrl
        
        Networkhandler.PostRequest(url: url, parameters: param as? Parameters, Success:{ (Successresponse)  in
            let registerResponse = Successresponse as! [String: Any]
            let RegisterModelResoponse = payment.init(dictionary: registerResponse as NSDictionary)
            
            Success(RegisterModelResoponse!)
            print(RegisterModelResoponse!)
        }, Falioure: {(error) in
            
            falioure(NetWorkError(Status: Constant.NetworkErrorType.generic, Message: error.Message))
            
        })
    }
    //MARK:- endhandler
}
