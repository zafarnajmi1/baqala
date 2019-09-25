//
//  PaymentModel.swift
//  Baqala
//
//  Created by Apple on 1/11/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation
public class payment {
    public var success : Bool?
    public var message : paymentMessage?
    public var data : paymentData?
    public var errors : paymentErrors?
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [payment]
    {
        var models:[payment] = []
        for item in array
        {
            models.append(payment(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = paymentMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) {
            data = paymentData(dictionary: dictionary["data"] as! NSDictionary)
            
        }
        if (dictionary["errors"] != nil) { errors = paymentErrors(dictionary: dictionary["errors"] as! NSDictionary) }
    }
    

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.success, forKey: "success")
        dictionary.setValue(self.message?.dictionaryRepresentation(), forKey: "message")
        dictionary.setValue(self.data?.dictionaryRepresentation(), forKey: "data")
        dictionary.setValue(self.errors?.dictionaryRepresentation(), forKey: "errors")
        
        return dictionary
    }
    
}
public class paymentMessage {
    public var ar : String?
    public var en : String?
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [paymentMessage]
    {
        var models:[paymentMessage] = []
        for item in array
        {
            models.append(paymentMessage(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        ar = dictionary["ar"] as? String
        en = dictionary["en"] as? String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.ar, forKey: "ar")
        dictionary.setValue(self.en, forKey: "en")
        
        return dictionary
    }
    
}
public class paymentErrors {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [paymentErrors]
    {
        var models:[paymentErrors] = []
        for item in array
        {
            models.append(paymentErrors(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        
        return dictionary
    }
    
}
public class paymentData {
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [paymentData]
    {
        var models:[paymentData] = []
        for item in array
        {
            models.append(paymentData(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        
        return dictionary
    }
    
}
