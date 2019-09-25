//
//  UserConfig.swift
//  Baqala
//
//  Created by apple on 12/17/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation

struct userLocation {
    static var latitude = Sharedata.shareInfo.userLatitude
    static var longitude = Sharedata.shareInfo.userLongitude
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
