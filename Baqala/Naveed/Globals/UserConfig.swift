//
//  UserConfig.swift
//  Baqala
//
//  Created by apple on 12/17/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation

struct userLocation {
    static var latitude = Sharedata.shareInfo.Pick_lati //"31.508907499999985  "
    
    static var longitude = Sharedata.shareInfo.Pick_longi  //"74.37569140625003"
}


struct userGlobal {
    static var BadgNumber = UserDefaults.standard.value(forKey: "CartBadgeNumber" )    
    //static let userId = "5c10a55e80be357c1db3a896"
    static let authorizedToken  = Sharedata.shareInfo.AuthToken //"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7Il9pZCI6IjVjMTc5ZjFiZjA3MGI0NGI3OTFhN2NiOSJ9LCJpYXQiOjE1NDUxMTEyNTksImV4cCI6MTU0NjQwNzI1OX0.kmh2-sHPjnfRT3lRLEl8Y80K5spoP8SbzOZHAjcpm3A"
}


//struct defination
struct CartBadge {
    let productId: String
    var quantity: Int
}
// key to search in custom array
var productId = "gama"

//empty custom list
var cartBadge = [CartBadge]()
