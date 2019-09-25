//
//  UserConfig.swift
//  Baqala
//
//  Created by apple on 12/17/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation

struct userLocation {
    static var latitude = "25.276987"
    static var longitude = "55.296249"
}


struct userGlobal {
    static var BadgNumber = UserDefaults.standard.value(forKey: "CartBadgeNumber" )    
    static let userId = "5c179f1bf070b44b791a7cb9"
    static let authorizedToken  = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7Il9pZCI6IjVjMTc5ZjFiZjA3MGI0NGI3OTFhN2NiOSJ9LCJpYXQiOjE1NDUxMTEyNTksImV4cCI6MTU0NjQwNzI1OX0.kmh2-sHPjnfRT3lRLEl8Y80K5spoP8SbzOZHAjcpm3A"
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
