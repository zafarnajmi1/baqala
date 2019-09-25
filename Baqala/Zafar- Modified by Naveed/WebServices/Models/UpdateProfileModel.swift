//
//  UpdateProfileModel.swift
//  Baqala
//
//  Created by Apple on 12/18/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
public class UpdateProfile {
    public var success : Bool?
    public var message : UpdateProfileMessage?
    public var data : UpdateProfileData?
    public var errors : UpdateProfileErrors?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [UpdateProfile]
    {
        var models:[UpdateProfile] = []
        for item in array
        {
            models.append(UpdateProfile(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = UpdateProfileMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = UpdateProfileData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = UpdateProfileErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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

public class UpdateProfileMessage {
    public var ar : String?
    public var en : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [UpdateProfileMessage]
    {
        var models:[UpdateProfileMessage] = []
        for item in array
        {
            models.append(UpdateProfileMessage(dictionary: item as! NSDictionary)!)
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
public class UpdateProfileErrors {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [UpdateProfileErrors]
    {
        var models:[UpdateProfileErrors] = []
        for item in array
        {
            models.append(UpdateProfileErrors(dictionary: item as! NSDictionary)!)
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
public class UpdateProfileData {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [UpdateProfileData]
    {
        var models:[UpdateProfileData] = []
        for item in array
        {
            models.append(UpdateProfileData(dictionary: item as! NSDictionary)!)
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
