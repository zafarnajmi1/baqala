//
//  ResetPasswordModel.swift
//  Baqala
//
//  Created by Apple on 12/17/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation


public class ResetPassword {
    public var success : Bool?
    public var message : ResetPasswordMessage?
    public var data : ResetPasswordData?
    public var errors : ResetPasswordErrors?

    public class func modelsFromDictionaryArray(array:NSArray) -> [ResetPassword]
    {
        var models:[ResetPassword] = []
        for item in array
        {
            models.append(ResetPassword(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = ResetPasswordMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = ResetPasswordData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = ResetPasswordErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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
public class ResetPasswordMessage {
    public var en : String?
    public var ar : String?
    public var helpUrl : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [ResetPasswordMessage]
    {
        var models:[ResetPasswordMessage] = []
        for item in array
        {
            models.append(ResetPasswordMessage(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        en = dictionary["en"] as? String
        ar = dictionary["ar"] as? String
        helpUrl = dictionary["helpUrl"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.en, forKey: "en")
        dictionary.setValue(self.ar, forKey: "ar")
        dictionary.setValue(self.helpUrl, forKey: "helpUrl")
        
        return dictionary
    }
    
}
public class ResetPasswordErrors {

    public class func modelsFromDictionaryArray(array:NSArray) -> [ResetPasswordErrors]
    {
        var models:[ResetPasswordErrors] = []
        for item in array
        {
            models.append(ResetPasswordErrors(dictionary: item as! NSDictionary)!)
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
public class ResetPasswordData {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ResetPasswordData]
    {
        var models:[ResetPasswordData] = []
        for item in array
        {
            models.append(ResetPasswordData(dictionary: item as! NSDictionary)!)
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
