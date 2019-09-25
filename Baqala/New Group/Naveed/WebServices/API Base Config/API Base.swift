//
//  API Base.swift
//  Baqala
//
//  Created by apple on 12/13/18.
//  Copyright © 2018 My Technology. All rights reserved.
//


import UIKit
import Alamofire
internal struct API {
    
    //used in BaseManager
    internal struct baseURL {
        
        static let dev =  "https://hello-stream.com/projects/baqala/api/"
        static let staging = ""
        static let production = ""
    }
    

    //used in baseManager
    internal struct Header {
        static let contentType: HTTPHeaders = ["Content-Type": "application/json"]
        static let authorization: HTTPHeaders = ["Authorization": appConstant.authorizedToken]
    }
}
