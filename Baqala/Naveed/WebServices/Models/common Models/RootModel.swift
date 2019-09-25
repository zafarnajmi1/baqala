//
//  RootModel.swift
//  Baqala
//
//  Created by apple on 1/9/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation
import ObjectMapper


class RootModel : NSObject, NSCoding, Mappable{
    

    var errors : Error?
    var message : Message?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RootModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
       
        errors <- map["errors"]
        message <- map["message"]
        success <- map["success"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
       
        errors = aDecoder.decodeObject(forKey: "errors") as? Error
        message = aDecoder.decodeObject(forKey: "message") as? Message
        success = aDecoder.decodeObject(forKey: "success") as? Bool
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
    
        if errors != nil{
            aCoder.encode(errors, forKey: "errors")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }
        
    }
    
}
