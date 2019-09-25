//
//  Globals.swift
//  Baqala
//
//  Created by apple on 12/13/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import  Foundation
import  UIKit
//MARK:- App Globals

internal struct appConstant {
  
    //Place Holder
    static let storeCatePh = UIImage(named: "storeCatePh" )
    static let placeHolderUser = UIImage(named: "userPh" )
    static let notificationPh = UIImage(named: "notificationPh" )
    static let orderPh = UIImage(named: "orderPh" )
    static let productPh = UIImage(named: "productPh" )
    //user info
    static let userId = Sharedata.shareInfo.id
    static let authorizedToken  = Sharedata.shareInfo.authToken
    
    //app constant Localized
    static let noMoreData = "Record not found".localized.localized
}


