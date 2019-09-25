//
//  submitStoreReviewsModel.swift
//  Baqala
//
//  Created by Apple on 1/4/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation
public class SubmitstoreReview {
    public var success : Bool?
    public var message : SubmitstoreReviewMessage?
    public var data : SubmitstoreReviewData?
    public var errors : SubmitstoreReviewErrors?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [SubmitstoreReview]
    {
        var models:[SubmitstoreReview] = []
        for item in array
        {
            models.append(SubmitstoreReview(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = SubmitstoreReviewMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = SubmitstoreReviewData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = SubmitstoreReviewErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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
public class SubmitstoreReviewMessage {
    public var ar : String?
    public var en : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [SubmitstoreReviewMessage]
    {
        var models:[SubmitstoreReviewMessage] = []
        for item in array
        {
            models.append(SubmitstoreReviewMessage(dictionary: item as! NSDictionary)!)
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
public class SubmitstoreReviewErrors {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [SubmitstoreReviewErrors]
    {
        var models:[SubmitstoreReviewErrors] = []
        for item in array
        {
            models.append(SubmitstoreReviewErrors(dictionary: item as! NSDictionary)!)
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
public class SubmitstoreReviewData {
    public var rating : Double?
    public var comment : String?
    public var _id : String?
    public var product : String?
    public var store : String?
    public var user : String?
    public var createdAt : String?
    public var updatedAt : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [SubmitstoreReviewData]
    {
        var models:[SubmitstoreReviewData] = []
        for item in array
        {
            models.append(SubmitstoreReviewData(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        rating = dictionary["rating"] as? Double
        comment = dictionary["comment"] as? String
        _id = dictionary["_id"] as? String
        product = dictionary["product"] as? String
        store = dictionary["store"] as? String
        user = dictionary["user"] as? String
        createdAt = dictionary["createdAt"] as? String
        updatedAt = dictionary["updatedAt"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.rating, forKey: "rating")
        dictionary.setValue(self.comment, forKey: "comment")
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.product, forKey: "product")
        dictionary.setValue(self.store, forKey: "store")
        dictionary.setValue(self.user, forKey: "user")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        
        return dictionary
    }
    
}
