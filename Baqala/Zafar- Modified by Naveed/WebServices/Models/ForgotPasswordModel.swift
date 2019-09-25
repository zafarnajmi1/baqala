//
//  ForgotPasswordModel.swift
//  Baqala
//
//  Created by Apple on 12/17/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation

public class ForGotPassword {
    public var success : Bool?
    public var message : ForGotPasswordMessage?
    public var data : ForGotPasswordData?
    public var errors : ForGotPasswordErrors?

    public class func modelsFromDictionaryArray(array:NSArray) -> [ForGotPassword]
    {
        var models:[ForGotPassword] = []
        for item in array
        {
            models.append(ForGotPassword(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = ForGotPasswordMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = ForGotPasswordData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = ForGotPasswordErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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
public class ForGotPasswordMessage {
    public var ar : String?
    public var en : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [ForGotPasswordMessage]
    {
        var models:[ForGotPasswordMessage] = []
        for item in array
        {
            models.append(ForGotPasswordMessage(dictionary: item as! NSDictionary)!)
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

public class ForGotPasswordErrors {

    public class func modelsFromDictionaryArray(array:NSArray) -> [ForGotPasswordErrors]
    {
        var models:[ForGotPasswordErrors] = []
        for item in array
        {
            models.append(ForGotPasswordErrors(dictionary: item as! NSDictionary)!)
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

public class ForGotPasswordData {

    public class func modelsFromDictionaryArray(array:NSArray) -> [ForGotPasswordData]
    {
        var models:[ForGotPasswordData] = []
        for item in array
        {
            models.append(ForGotPasswordData(dictionary: item as! NSDictionary)!)
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
