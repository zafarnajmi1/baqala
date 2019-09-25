//
//  File.swift
//  Baqala
//
//  Created by apple on 12/13/18.
//  Copyright © 2018 My Technology. All rights reserved.
//



import Foundation
import Alamofire


class BaseManager: NSObject {
    
    var sessionManager: SessionManager
    var basePath: String
    var rawHeader: HTTPHeaders
  
    
    override init() {
        
        sessionManager = Alamofire.SessionManager.default
        basePath = API.baseURL.dev
        rawHeader = ["Content-Type": "application/json"]

    }
}
