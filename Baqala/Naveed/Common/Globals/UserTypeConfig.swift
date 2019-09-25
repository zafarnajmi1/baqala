//
//  UserTypeConfig.swift
//  Baqala
//
//  Created by apple on 1/8/19.
//  Copyright © 2019 My Technology. All rights reserved.
//
import Foundation


enum userType {
    case buyer
    case seller
    case guest
    case notExist
}

var myDefaultAccountType = userType.notExist
