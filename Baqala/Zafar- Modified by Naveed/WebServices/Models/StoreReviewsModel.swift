//
//  StoreReviewsModel.swift
//  Baqala
//
//  Created by Apple on 1/4/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

//import Foundation
//public class StoreReviews {
//    
//    
//    public var success : Bool?
//    public var message : StoreReviewsMessage?
//    public var data : StoreReviewsData?
//    public var errors : StoreReviewsErrors?
//    
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreReviews]
//    {
//        var models:[StoreReviews] = []
//        for item in array
//        {
//            models.append(StoreReviews(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    
//    required public init?(dictionary: NSDictionary) {
//        
//        success = dictionary["success"] as? Bool
//        if (dictionary["message"] != nil) { message = StoreReviewsMessage(dictionary: dictionary["message"] as! NSDictionary) }
//        if (dictionary["data"] != nil) { data = StoreReviewsData(dictionary: dictionary["data"] as! NSDictionary) }
//        if (dictionary["errors"] != nil) { errors = StoreReviewsErrors(dictionary: dictionary["errors"] as! NSDictionary) }
//    }
//    
//    public func dictionaryRepresentation() -> NSDictionary {
//        
//        let dictionary = NSMutableDictionary()
//        
//        dictionary.setValue(self.success, forKey: "success")
//        dictionary.setValue(self.message?.dictionaryRepresentation(), forKey: "message")
//        dictionary.setValue(self.data?.dictionaryRepresentation(), forKey: "data")
//        dictionary.setValue(self.errors?.dictionaryRepresentation(), forKey: "errors")
//        
//        return dictionary
//    }
//    
//}
//public class StoreReviewsMessage {
//    public var ar : String?
//    public var en : String?
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreReviewsMessage]
//    {
//        var models:[StoreReviewsMessage] = []
//        for item in array
//        {
//            models.append(StoreReviewsMessage(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//
//    required public init?(dictionary: NSDictionary) {
//        
//        ar = dictionary["ar"] as? String
//        en = dictionary["en"] as? String
//    }
//    public func dictionaryRepresentation() -> NSDictionary {
//        
//        let dictionary = NSMutableDictionary()
//        
//        dictionary.setValue(self.ar, forKey: "ar")
//        dictionary.setValue(self.en, forKey: "en")
//        
//        return dictionary
//    }
//    
//}
//public class StoreReviewsPagination {
//    public var total : Int?
//    public var pages : Int?
//    public var per_page : Int?
//    public var page : Int?
//    public var previous : Int?
//    public var next : Int?
//    
//    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreReviewsPagination]
//    {
//        var models:[StoreReviewsPagination] = []
//        for item in array
//        {
//            models.append(StoreReviewsPagination(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    
//    required public init?(dictionary: NSDictionary) {
//        
//        total = dictionary["total"] as? Int
//        pages = dictionary["pages"] as? Int
//        per_page = dictionary["per_page"] as? Int
//        page = dictionary["page"] as? Int
//        previous = dictionary["previous"] as? Int
//        next = dictionary["next"] as? Int
//    }
//
//    public func dictionaryRepresentation() -> NSDictionary {
//        
//        let dictionary = NSMutableDictionary()
//        
//        dictionary.setValue(self.total, forKey: "total")
//        dictionary.setValue(self.pages, forKey: "pages")
//        dictionary.setValue(self.per_page, forKey: "per_page")
//        dictionary.setValue(self.page, forKey: "page")
//        dictionary.setValue(self.previous, forKey: "previous")
//        dictionary.setValue(self.next, forKey: "next")
//        
//        return dictionary
//    }
//    
//}
//public class StoreReviewsProduct {
//    public var _id : String?
//    public var productName : StoreReviewsProductName?
//    
//    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreReviewsProduct]
//    {
//        var models:[StoreReviewsProduct] = []
//        for item in array
//        {
//            models.append(StoreReviewsProduct(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    
//    required public init?(dictionary: NSDictionary) {
//        
//        _id = dictionary["_id"] as? String
//        if (dictionary["productName"] != nil) { productName = StoreReviewsProductName(dictionary: dictionary["productName"] as! NSDictionary) }
//    }
//
//    public func dictionaryRepresentation() -> NSDictionary {
//        
//        let dictionary = NSMutableDictionary()
//        
//        dictionary.setValue(self._id, forKey: "_id")
//        dictionary.setValue(self.productName?.dictionaryRepresentation(), forKey: "productName")
//        
//        return dictionary
//    }
//    
//}
//public class StoreReviewsProductName {
//    public var en : String?
//    public var ar : String?
//    
//    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreReviewsProductName]
//    {
//        var models:[StoreReviewsProductName] = []
//        for item in array
//        {
//            models.append(StoreReviewsProductName(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//
//    required public init?(dictionary: NSDictionary) {
//        
//        en = dictionary["en"] as? String
//        ar = dictionary["ar"] as? String
//    }
//
//    public func dictionaryRepresentation() -> NSDictionary {
//        
//        let dictionary = NSMutableDictionary()
//        
//        dictionary.setValue(self.en, forKey: "en")
//        dictionary.setValue(self.ar, forKey: "ar")
//        
//        return dictionary
//    }
//    
//}
//public class StoreReviewsStore {
//    public var _id : String?
//    public var storeName : StoreReviewsStoreName?
//    public var averageRating : Double?
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreReviewsStore]
//    {
//        var models:[StoreReviewsStore] = []
//        for item in array
//        {
//            models.append(StoreReviewsStore(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    
//    required public init?(dictionary: NSDictionary) {
//        
//        _id = dictionary["_id"] as? String
//        if (dictionary["storeName"] != nil) { storeName = StoreReviewsStoreName(dictionary: dictionary["storeName"] as! NSDictionary) }
//        averageRating = dictionary["averageRating"] as? Double
//    }
//
//    public func dictionaryRepresentation() -> NSDictionary {
//        
//        let dictionary = NSMutableDictionary()
//        
//        dictionary.setValue(self._id, forKey: "_id")
//        dictionary.setValue(self.storeName?.dictionaryRepresentation(), forKey: "storeName")
//        dictionary.setValue(self.averageRating, forKey: "averageRating")
//        
//        return dictionary
//    }
//    
//}
//public class StoreReviewsStoreName {
//    public var ar : String?
//    public var en : String?
//    
//    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreReviewsStoreName]
//    {
//        var models:[StoreReviewsStoreName] = []
//        for item in array
//        {
//            models.append(StoreReviewsStoreName(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    
//    required public init?(dictionary: NSDictionary) {
//        
//        ar = dictionary["ar"] as? String
//        en = dictionary["en"] as? String
//    }
//
//    public func dictionaryRepresentation() -> NSDictionary {
//        
//        let dictionary = NSMutableDictionary()
//        
//        dictionary.setValue(self.ar, forKey: "ar")
//        dictionary.setValue(self.en, forKey: "en")
//        
//        return dictionary
//    }
//    
//}
//public class StoreReviewsStoreReviews {
//    public var _id : String?
//    public var rating : Int?
//    public var comment : String?
//    public var product : StoreReviewsProduct?
//    public var store : StoreReviewsStore?
//    public var user : StoreReviewsUser?
//    public var createdAt : String?
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreReviewsStoreReviews]
//    {
//        var models:[StoreReviewsStoreReviews] = []
//        for item in array
//        {
//            models.append(StoreReviewsStoreReviews(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    
//    required public init?(dictionary: NSDictionary) {
//        
//        _id = dictionary["_id"] as? String
//        rating = dictionary["rating"] as? Int
//        comment = dictionary["comment"] as? String
//        if (dictionary["product"] != nil) { product = StoreReviewsProduct(dictionary: dictionary["product"] as! NSDictionary) }
//        if (dictionary["store"] != nil) { store = StoreReviewsStore(dictionary: dictionary["store"] as! NSDictionary) }
//        if (dictionary["user"] != nil) { user = StoreReviewsUser(dictionary: dictionary["user"] as! NSDictionary) }
//        createdAt = dictionary["createdAt"] as? String
//    }
//    
//    
//    
//
//    public func dictionaryRepresentation() -> NSDictionary {
//        
//        let dictionary = NSMutableDictionary()
//        
//        dictionary.setValue(self._id, forKey: "_id")
//        dictionary.setValue(self.rating, forKey: "rating")
//        dictionary.setValue(self.comment, forKey: "comment")
//        dictionary.setValue(self.product?.dictionaryRepresentation(), forKey: "product")
//        dictionary.setValue(self.store?.dictionaryRepresentation(), forKey: "store")
//        dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
//        dictionary.setValue(self.createdAt, forKey: "createdAt")
//        
//        return dictionary
//    }
//    
//}
//public class StoreReviewsUser {
//    public var _id : String?
//    public var image : String?
//    public var firstName : String?
//    public var lastName : String?
//    
//    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreReviewsUser]
//    {
//        var models:[StoreReviewsUser] = []
//        for item in array
//        {
//            models.append(StoreReviewsUser(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//
//    required public init?(dictionary: NSDictionary) {
//        
//        _id = dictionary["_id"] as? String
//        image = dictionary["image"] as? String
//        firstName = dictionary["firstName"] as? String
//        lastName = dictionary["lastName"] as? String
//    }
//
//    public func dictionaryRepresentation() -> NSDictionary {
//        
//        let dictionary = NSMutableDictionary()
//        
//        dictionary.setValue(self._id, forKey: "_id")
//        dictionary.setValue(self.image, forKey: "image")
//        dictionary.setValue(self.firstName, forKey: "firstName")
//        dictionary.setValue(self.lastName, forKey: "lastName")
//        
//        return dictionary
//    }
//    
//}
//public class StoreReviewsErrors {
//    
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreReviewsErrors]
//    {
//        var models:[StoreReviewsErrors] = []
//        for item in array
//        {
//            models.append(StoreReviewsErrors(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    
//
//    required public init?(dictionary: NSDictionary) {
//        
//    }
//
//    public func dictionaryRepresentation() -> NSDictionary {
//        
//        let dictionary = NSMutableDictionary()
//        
//        
//        return dictionary
//    }
//    
//}
//public class StoreReviewsData {
//    public var storeReviews : Array<StoreReviewsStoreReviews>?
//    public var pagination : StoreReviewsPagination?
//    
//    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreReviewsData]
//    {
//        var models:[StoreReviewsData] = []
//        for item in array
//        {
//            models.append(StoreReviewsData(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//
//    required public init?(dictionary: NSDictionary) {
//        
//        if (dictionary["storeReviews"] != nil) { storeReviews = StoreReviewsStoreReviews.modelsFromDictionaryArray(array: dictionary["storeReviews"] as! NSArray) }
//        if (dictionary["pagination"] != nil) { pagination = StoreReviewsPagination(dictionary: dictionary["pagination"] as! NSDictionary) }
//    }
//    public func dictionaryRepresentation() -> NSDictionary {
//        
//        let dictionary = NSMutableDictionary()
//        
//        dictionary.setValue(self.pagination?.dictionaryRepresentation(), forKey: "pagination")
//        
//        return dictionary
//    }
//    
//}
