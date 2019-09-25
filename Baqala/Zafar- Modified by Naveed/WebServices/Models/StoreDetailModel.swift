//
//  StoreDetailModel.swift
//  Baqala
//
//  Created by Apple on 1/3/19.
//  Copyright © 2019 My Technology. All rights reserved.
//
//storeDetail
import Foundation

public class storeDetail {
    public var success : Bool?
    public var message : storeDetailMessage?
    public var data : storeDetailData?
    public var errors : storeDetailErrors?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [storeDetail]
    {
        var models:[storeDetail] = []
        for item in array
        {
            models.append(storeDetail(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = storeDetailMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = storeDetailData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = storeDetailErrors(dictionary: dictionary["errors"] as! NSDictionary) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.success, forKey: "success")
        dictionary.setValue(self.message?.dictionaryRepresentation(), forKey: "message")
        dictionary.setValue(self.data?.dictionaryRepresentation(), forKey: "data")
        dictionary.setValue(self.errors?.dictionaryRepresentation(), forKey: "errors")
        
        return dictionary
    }
    
}
public class storeDetailMessage {
    public var ar : String?
    public var en : String?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [storeDetailMessage]
    {
        var models:[storeDetailMessage] = []
        for item in array
        {
            models.append(storeDetailMessage(dictionary: item as! NSDictionary)!)
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
public class storeDetailProduct {
    public var _id : String?
    public var productName : storeDetailProductName?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [storeDetailProduct]
    {
        var models:[storeDetailProduct] = []
        for item in array
        {
            models.append(storeDetailProduct(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    
    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        if (dictionary["productName"] != nil) { productName = storeDetailProductName(dictionary: dictionary["productName"] as! NSDictionary) }
    }
    

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.productName?.dictionaryRepresentation(), forKey: "productName")
        
        return dictionary
    }
    
}
public class storeDetailProductName {
    public var en : String?
    public var ar : String?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [storeDetailProductName]
    {
        var models:[storeDetailProductName] = []
        for item in array
        {
            models.append(storeDetailProductName(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        en = dictionary["en"] as? String
        ar = dictionary["ar"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.en, forKey: "en")
        dictionary.setValue(self.ar, forKey: "ar")
        
        return dictionary
    }
    
}
public class storeDetailReviews {
    public var _id : String?
    public var rating : Int?
    public var comment : String?
    public var product : String?
    public var store : String?
    public var user : storeDetailUser?
    public var createdAt : String?
    public var updatedAt : String?
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [storeDetailReviews]
    {
        var models:[storeDetailReviews] = []
        for item in array
        {
            models.append(storeDetailReviews(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        rating = dictionary["rating"] as? Int
        comment = dictionary["comment"] as? String
        product = dictionary["product"] as? String
        store = dictionary["store"] as? String
        if (dictionary["user"] != nil) { user = storeDetailUser(dictionary: dictionary["user"] as! NSDictionary) }
        createdAt = dictionary["createdAt"] as? String
        updatedAt = dictionary["updatedAt"] as? String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.rating, forKey: "rating")
        dictionary.setValue(self.comment, forKey: "comment")
        dictionary.setValue(self.product, forKey: "product")
        dictionary.setValue(self.store, forKey: "store")
        dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        
        return dictionary
    }
    
}
public class storeDetailStoreName {
    public var ar : String?
    public var en : String?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [storeDetailStoreName]
    {
        var models:[storeDetailStoreName] = []
        for item in array
        {
            models.append(storeDetailStoreName(dictionary: item as! NSDictionary)!)
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
public class storeDetailUser {
    public var _id : String?
    public var image : String?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [storeDetailUser]
    {
        var models:[storeDetailUser] = []
        for item in array
        {
            models.append(storeDetailUser(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        image = dictionary["image"] as? String
    }
    

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.image, forKey: "image")
        
        return dictionary
    }
    
}
public class storeDetailErrors {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [storeDetailErrors]
    {
        var models:[storeDetailErrors] = []
        for item in array
        {
            models.append(storeDetailErrors(dictionary: item as! NSDictionary)!)
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
public class storeDetailDescription {
    public var en : String?
    public var ar : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [storeDetailDescription]
    {
        var models:[storeDetailDescription] = []
        for item in array
        {
            models.append(storeDetailDescription(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        en = dictionary["en"] as? String
        ar = dictionary["ar"] as? String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.en, forKey: "en")
        dictionary.setValue(self.ar, forKey: "ar")
        
        return dictionary
    }
    
}
public class storeDetailData {
    public var _id : String?
    public var storeName : storeDetailStoreName?
    public var description : storeDetailDescription?
    public var reviews : Array<storeDetailReviews>?
    public var address : String?
    public var location : Array<Double>?
    public var averageRating : Double?
    public var image : String?
    public var isActive : Bool?
    public var canReviewUsers : Array<storeDetailCanReviewUsers>?
    public var distance : Double?

    public class func modelsFromDictionaryArray(array:NSArray) -> [storeDetailData]
    {
        var models:[storeDetailData] = []
        for item in array
        {
            models.append(storeDetailData(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        if (dictionary["storeName"] != nil) { storeName = storeDetailStoreName(dictionary: dictionary["storeName"] as! NSDictionary) }
        if (dictionary["description"] != nil) { description = storeDetailDescription(dictionary: dictionary["description"] as! NSDictionary) }
        if (dictionary["reviews"] != nil) { reviews = storeDetailReviews.modelsFromDictionaryArray(array: dictionary["reviews"] as! NSArray) }
        address = dictionary["address"] as? String
        location = dictionary[""] as? Array<Double>
        
       // if (dictionary["location"] != nil) { location = location.modelsFromDictionaryArray(dictionary["location"] as! NSArray) }
        
        averageRating = dictionary["averageRating"] as? Double
        image = dictionary["image"] as? String
        isActive = dictionary["isActive"] as? Bool
        if (dictionary["canReviewUsers"] != nil) { canReviewUsers = storeDetailCanReviewUsers.modelsFromDictionaryArray(array: dictionary["canReviewUsers"] as! NSArray) }
        distance = dictionary["distance"] as? Double
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.storeName?.dictionaryRepresentation(), forKey: "storeName")
        dictionary.setValue(self.description?.dictionaryRepresentation(), forKey: "description")
        dictionary.setValue(self.address, forKey: "address")
        dictionary.setValue(self.averageRating, forKey: "averageRating")
        dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self.isActive, forKey: "isActive")
        dictionary.setValue(self.distance, forKey: "distance")
        
        return dictionary
    }
    
}
public class storeDetailCanReviewUsers {
    public var _id : String?
    public var order : String?
    public var user : String?
    public var product : storeDetailProduct?
    public var store : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [storeDetailCanReviewUsers]
    {
        var models:[storeDetailCanReviewUsers] = []
        for item in array
        {
            models.append(storeDetailCanReviewUsers(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        order = dictionary["order"] as? String
        user = dictionary["user"] as? String
        if (dictionary["product"] != nil) { product = storeDetailProduct(dictionary: dictionary["product"] as! NSDictionary) }
        store = dictionary["store"] as? String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.order, forKey: "order")
        dictionary.setValue(self.user, forKey: "user")
        dictionary.setValue(self.product?.dictionaryRepresentation(), forKey: "product")
        dictionary.setValue(self.store, forKey: "store")
        
        return dictionary
    }
    
}
