//
//  ContactUsModel.swift
//  Baqala
//
//  Created by Apple on 12/18/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation


public class ContactUs {
    public var success : Bool?
    public var message : ContactUsMessage?
    public var data : ContactUsData?
    public var errors : ContactUsErrors?
    public class func modelsFromDictionaryArray(array:NSArray) -> [ContactUs]
    {
        var models:[ContactUs] = []
        for item in array
        {
            models.append(ContactUs(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = ContactUsMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = ContactUsData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = ContactUsErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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

public class ContactUsMessage {
    public var ar : String?
    public var en : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ContactUsMessage]
    {
        var models:[ContactUsMessage] = []
        for item in array
        {
            models.append(ContactUsMessage(dictionary: item as! NSDictionary)!)
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
public class ContactUsErrors {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ContactUsErrors]
    {
        var models:[ContactUsErrors] = []
        for item in array
        {
            models.append(ContactUsErrors(dictionary: item as! NSDictionary)!)
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
public class ContactUsData {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ContactUsData]
    {
        var models:[ContactUsData] = []
        for item in array
        {
            models.append(ContactUsData(dictionary: item as! NSDictionary)!)
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
