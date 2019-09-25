//
//  ChangePasswordModel.swift
//  Baqala
//
//  Created by Apple on 12/18/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
public class changePassword {
    public var success : Bool?
    public var message : changePasswordMessage?
    public var data : changePasswordData?
    public var errors : changePasswordErrors?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [changePassword]
    {
        var models:[changePassword] = []
        for item in array
        {
            models.append(changePassword(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = changePasswordMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = changePasswordData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = changePasswordErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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
public class changePasswordMessage {
    public var ar : String?
    public var en : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [changePasswordMessage]
    {
        var models:[changePasswordMessage] = []
        for item in array
        {
            models.append(changePasswordMessage(dictionary: item as! NSDictionary)!)
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
public class changePasswordErrors {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [changePasswordErrors]
    {
        var models:[changePasswordErrors] = []
        for item in array
        {
            models.append(changePasswordErrors(dictionary: item as! NSDictionary)!)
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
public class changePasswordData {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [changePasswordData]
    {
        var models:[changePasswordData] = []
        for item in array
        {
            models.append(changePasswordData(dictionary: item as! NSDictionary)!)
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
