//
//  CnversationModel.swift
//  Baqala
//
//  Created by Apple on 1/10/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation
//ConversationModel
public class ConversationModel {
    public var success : Bool?
    public var message : String?
    public var data : ConversationData?
    public var errors : ConversationErrors?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ConversationModel]
    {
        var models:[ConversationModel] = []
        for item in array
        {
            models.append(ConversationModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        message = dictionary["message"] as? String
        if (dictionary["data"] != nil) { data = ConversationData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = ConversationErrors(dictionary: dictionary["errors"] as! NSDictionary) }
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.success, forKey: "success")
        dictionary.setValue(self.message, forKey: "message")
        dictionary.setValue(self.data?.dictionaryRepresentation(), forKey: "data")
        dictionary.setValue(self.errors?.dictionaryRepresentation(), forKey: "errors")
        
        return dictionary
    }
    
}

public class LastMessage {
    public var _id : String?
    public var mimeType : String?
    public var conversation : String?
    public var sender : String?
    public var createdAt : String?
    public var updatedAt : String?
    public var content : String?
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [LastMessage]
    {
        var models:[LastMessage] = []
        for item in array
        {
            models.append(LastMessage(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        mimeType = dictionary["mimeType"] as? String
        conversation = dictionary["conversation"] as? String
        sender = dictionary["sender"] as? String
        createdAt = dictionary["createdAt"] as? String
        updatedAt = dictionary["updatedAt"] as? String
        content = dictionary["content"] as? String
    }
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.mimeType, forKey: "mimeType")
        dictionary.setValue(self.conversation, forKey: "conversation")
        dictionary.setValue(self.sender, forKey: "sender")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        dictionary.setValue(self.content, forKey: "content")
        
        return dictionary
    }
    
}
public class ConversationPagination {
    public var total : Int?
    public var pages : Int?
    public var per_page : Int?
    public var page : Int?
    public var previous : Int?
    public var next : Int?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ConversationPagination]
    {
        var models:[ConversationPagination] = []
        for item in array
        {
            models.append(ConversationPagination(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        total = dictionary["total"] as? Int
        pages = dictionary["pages"] as? Int
        per_page = dictionary["per_page"] as? Int
        page = dictionary["page"] as? Int
        previous = dictionary["previous"] as? Int
        next = dictionary["next"] as? Int
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.total, forKey: "total")
        dictionary.setValue(self.pages, forKey: "pages")
        dictionary.setValue(self.per_page, forKey: "per_page")
        dictionary.setValue(self.page, forKey: "page")
        dictionary.setValue(self.previous, forKey: "previous")
        dictionary.setValue(self.next, forKey: "next")
        
        return dictionary
    }
    
}
public class ConversationPrice {
    public var usd : Int?
    public var aed : Int?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ConversationPrice]
    {
        var models:[ConversationPrice] = []
        for item in array
        {
            models.append(ConversationPrice(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        usd = dictionary["usd"] as? Int
        aed = dictionary["aed"] as? Int
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.usd, forKey: "usd")
        dictionary.setValue(self.aed, forKey: "aed")
        
        return dictionary
    }
    
}
public class Product {
    public var _id : String?
    public var productName : ProductName?
    public var price : ConversationPrice?
    public var createdAt : String?
    public var updatedAt : String?
    public var image : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Product]
    {
        var models:[Product] = []
        for item in array
        {
            models.append(Product(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        if (dictionary["productName"] != nil) { productName = ProductName(dictionary: dictionary["productName"] as! NSDictionary) }
        if (dictionary["price"] != nil) { price = ConversationPrice(dictionary: dictionary["price"] as! NSDictionary) }
        createdAt = dictionary["createdAt"] as? String
        updatedAt = dictionary["updatedAt"] as? String
        image = dictionary["image"] as? String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.productName?.dictionaryRepresentation(), forKey: "productName")
        dictionary.setValue(self.price?.dictionaryRepresentation(), forKey: "price")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        dictionary.setValue(self.image, forKey: "image")
        
        return dictionary
    }
    
}
public class ProductName {
    public var en : String?
    public var ar : String?
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [ProductName]
    {
        var models:[ProductName] = []
        for item in array
        {
            models.append(ProductName(dictionary: item as! NSDictionary)!)
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
public class Store {
    public var _id : String?
    public var storeName : StoreName?
    public var image : String?
    public var createdAt : String?
    public var updatedAt : String?
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [Store]
    {
        var models:[Store] = []
        for item in array
        {
            models.append(Store(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        if (dictionary["storeName"] != nil) { storeName = StoreName(dictionary: dictionary["storeName"] as! NSDictionary) }
        image = dictionary["image"] as? String
        createdAt = dictionary["createdAt"] as? String
        updatedAt = dictionary["updatedAt"] as? String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.storeName?.dictionaryRepresentation(), forKey: "storeName")
        dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        
        return dictionary
    }
    
}
public class StoreName {
    public var en : String?
    public var ar : String?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [StoreName]
    {
        var models:[StoreName] = []
        for item in array
        {
            models.append(StoreName(dictionary: item as! NSDictionary)!)
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
public class User {
    public var _id : String?
    public var image : String?
    public var firstName : String?
    public var lastName : String?
    public var createdAt : String?
    public var updatedAt : String?
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [User]
    {
        var models:[User] = []
        for item in array
        {
            models.append(User(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        image = dictionary["image"] as? String
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        createdAt = dictionary["createdAt"] as? String
        updatedAt = dictionary["updatedAt"] as? String
    }
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self.firstName, forKey: "firstName")
        dictionary.setValue(self.lastName, forKey: "lastName")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        
        return dictionary
    }
    
}
public class ConversationErrors {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ConversationErrors]
    {
        var models:[ConversationErrors] = []
        for item in array
        {
            models.append(ConversationErrors(dictionary: item as! NSDictionary)!)
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

public class ConversationData {
    public var conversations : Array<Conversations>?
    public var pagination : ConversationPagination?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ConversationData]
    {
        var models:[ConversationData] = []
        for item in array
        {
            models.append(ConversationData(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["conversations"] != nil) { conversations = Conversations.modelsFromDictionaryArray(array: dictionary["conversations"] as! NSArray) }
        if (dictionary["pagination"] != nil) { pagination = ConversationPagination(dictionary: dictionary["pagination"] as! NSDictionary) }
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.pagination?.dictionaryRepresentation(), forKey: "pagination")
        
        return dictionary
    }
    
}
public class Conversations {
    public var _id : String?
    public var user : User?
    public var store : Store?
    public var product : Product?
    public var lastMessage : LastMessage?
    public var createdAt : String?
    public var updatedAt : String?
    
   
    public class func modelsFromDictionaryArray(array:NSArray) -> [Conversations]
    {
        var models:[Conversations] = []
        for item in array
        {
            models.append(Conversations(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        if (dictionary["user"] != nil) { user = User(dictionary: dictionary["user"] as! NSDictionary) }
        if (dictionary["store"] != nil) { store = Store(dictionary: dictionary["store"] as! NSDictionary) }
        if (dictionary["product"] != nil) { product = Product(dictionary: dictionary["product"] as! NSDictionary) }
        if (dictionary["lastMessage"] != nil) { lastMessage = LastMessage(dictionary: dictionary["lastMessage"] as! NSDictionary) }
        createdAt = dictionary["createdAt"] as? String
        updatedAt = dictionary["updatedAt"] as? String
    }
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
        dictionary.setValue(self.store?.dictionaryRepresentation(), forKey: "store")
        dictionary.setValue(self.product?.dictionaryRepresentation(), forKey: "product")
        dictionary.setValue(self.lastMessage?.dictionaryRepresentation(), forKey: "lastMessage")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        
        return dictionary
    }
    
}
