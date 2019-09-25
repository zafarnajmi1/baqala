//
//  PaymentProfileModel.swift
//  Baqala
//
//  Created by Apple on 12/27/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
public class paymentProfile {
    public var success : Bool?
    public var message : paymentProfileMessage?
    public var data : paymentProfileData?
    public var errors : paymentProfileErrors?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [paymentProfile]
    {
        var models:[paymentProfile] = []
        for item in array
        {
            models.append(paymentProfile(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = paymentProfileMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = paymentProfileData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = paymentProfileErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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
public class paymentProfileMessage {
    public var ar : String?
    public var en : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [paymentProfileMessage]
    {
        var models:[paymentProfileMessage] = []
        for item in array
        {
            models.append(paymentProfileMessage(dictionary: item as! NSDictionary)!)
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
public class paymentProfileErrors {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [paymentProfileErrors]
    {
        var models:[paymentProfileErrors] = []
        for item in array
        {
            models.append(paymentProfileErrors(dictionary: item as! NSDictionary)!)
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
public class paymentProfileData {
    public class func modelsFromDictionaryArray(array:NSArray) -> [paymentProfileData]
    {
        var models:[paymentProfileData] = []
        for item in array
        {
            models.append(paymentProfileData(dictionary: item as! NSDictionary)!)
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
