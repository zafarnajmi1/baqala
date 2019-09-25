//
//  Constants.swift
//  Baqala
//
//  Created by Apple on 12/12/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    
    //MARK:- MainURL
    static var   MainUrl : String { return  "https://hello-stream.com/projects/baqala/api/" }
    

        //MARK:- URLs
        struct Urls {
            static let RegisterUrl = "register"
            static let EmailverificationUrl = "auth/email-verification"
            static let LoginUrl = "login"
            static let resendVerificationCodeUrl = "auth/resend-verification-code"
            static let ForgorPasswordUrl = "forgot/password"
            static let  resetPasswordUrl = "reset/password"
            static let userProfileUrl = "auth/user-profile"
            static let ContactUsUrl = "contact-us"
            static let changePasswordUrl = "auth/change-password"
            static let SetingsUrl = "settings"
            static let StoreUpdateUrl = "auth/update-store"
            static let SocialLoginUrl = "social-login"
            static let PaymentProfileUrl = "auth/update-store/paypal-credentials"
            static let  userProfileUpdateUrl = "auth/update-profile"
            ////
            
            static let StoreDetailUrl = "auth/store/detail"
            static let StoreReviewsUrl = "store/reviews"
            static let SubmitStoreReviewsUrl = "auth/submit/store-review"
            static let PamentpaypalUrl = "auth/payment"
    }
    
    
    
    //MARK:- NetworkType
    struct NetworkErrorType {
        static let timeOutInterval: TimeInterval = 20
        
        static let error = "Error"
        static let internetNotAvailable = "Internet Not Available"
        static let pleaseTryAgain = "Please Try Again"
        
        static let generic = 4000
        static let genericError = "Please Try Again."
        
        static let serverErrorCode = 5000
        static let serverNotAvailable = "Server Not Available"
        static let serverError = "Server Not Availabe, Please Try Later."
        
        static let timout = 4001
        static let timoutError = "Network Time Out, Please Try Again."
        
        static let login = 4003
        static let loginMessage = "Unable To Login"
        static let loginError = "Please Try Again."
        
        static let internet = 4004
        static let internetError = "Internet Not Available"
    }
    
    
    //MARK:- NetworkSuccessCode
    struct NetworkSuccess {
        static let statusOK = 200
    }
    
     //MARK:- NVActivityMessage
    enum  LoadingMessage : String {
        case  MessageFeedback = "Loading..."
    }
    
    //MARK:- NVActivitysize
    struct NVActivitySize {
        static var size = CGSize(width: 40, height: 40)
    }
}
