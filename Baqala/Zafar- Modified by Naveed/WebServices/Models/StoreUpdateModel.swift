//
//  StoreUpdateModel.swift
//  Baqala
//
//  Created by Apple on 12/21/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
public class StoreUpdate {
    public var success : Bool?
    public var message : StoreUpdateMessage?
    public var data : StoreUpdateData?
    public var errors : StoreUpdateErrors?
    
   
    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreUpdate]
    {
        var models:[StoreUpdate] = []
        for item in array
        {
            models.append(StoreUpdate(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = StoreUpdateMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = StoreUpdateData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = StoreUpdateErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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
public class StoreUpdateMessage {
    public var ar : String?
    public var en : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreUpdateMessage]
    {
        var models:[StoreUpdateMessage] = []
        for item in array
        {
            models.append(StoreUpdateMessage(dictionary: item as! NSDictionary)!)
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
public class StoreUpdateErrors {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreUpdateErrors]
    {
        var models:[StoreUpdateErrors] = []
        for item in array
        {
            models.append(StoreUpdateErrors(dictionary: item as! NSDictionary)!)
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
public class StoreUpdateData {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreUpdateData]
    {
        var models:[StoreUpdateData] = []
        for item in array
        {
            models.append(StoreUpdateData(dictionary: item as! NSDictionary)!)
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
