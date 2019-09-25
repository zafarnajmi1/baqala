//
//  EmailverificationModel.swift
//  Baqala
//
//  Created by Apple on 12/14/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
public class Emailverification {
    public var success : Bool?
    public var message : EmailverificationMessage?
    public var data : EmailverificationData?
    public var errors : EmailverificationErrors?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Emailverification]
    {
        var models:[Emailverification] = []
        for item in array
        {
            models.append(Emailverification(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = EmailverificationMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = EmailverificationData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = EmailverificationErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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
public class EmailverificationMessage {
    public var ar : String?
    public var en : String?
    public class func modelsFromDictionaryArray(array:NSArray) -> [EmailverificationMessage]
    {
        var models:[EmailverificationMessage] = []
        for item in array
        {
            models.append(EmailverificationMessage(dictionary: item as! NSDictionary)!)
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
public class EmailverificationStoreName {
    public var en : String?
    public var ar : String?
    public class func modelsFromDictionaryArray(array:NSArray) -> [EmailverificationStoreName]
    {
        var models:[EmailverificationStoreName] = []
        for item in array
        {
            models.append(EmailverificationStoreName(dictionary: item as! NSDictionary)!)
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
public class EmailverificationErrors {
    public class func modelsFromDictionaryArray(array:NSArray) -> [EmailverificationErrors]
    {
        var models:[EmailverificationErrors] = []
        for item in array
        {
            models.append(EmailverificationErrors(dictionary: item as! NSDictionary)!)
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
public class EmailverificationDescription {
    public var en : String?
    public var ar : String?
    public class func modelsFromDictionaryArray(array:NSArray) -> [EmailverificationDescription]
    {
        var models:[EmailverificationDescription] = []
        for item in array
        {
            models.append(EmailverificationDescription(dictionary: item as! NSDictionary)!)
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
public class EmailverificationData {
    public var storeName : EmailverificationStoreName?
    public var description : EmailverificationDescription?
    public var userType : String?
    public var accountType : String?
    public var reviews : Array<String>?
    public var products : Array<String>?
    public var paypalClientId : String?
    public var paypalSecretId : String?
    public var phone : String?
    public var address : String?
    public var location : Array<Double>?
    public var averageRating : Int?
    public var gender : String?
    public var image : String?
    public var isCartProcessing : Bool?
    public var isActive : Bool?
    public var isEmailVerified : Bool?
    public var verificationCode : String?
    public var _id : String?
    public var lastName : String?
    public var email : String?
    public var firstName : String?
    public var role : String?
    public var canReviewUsers : Array<String>?
    public var addresses : Array<String>?
    public var createdAt : String?
    public var updatedAt : String?
    public var authorization : String?
    public class func modelsFromDictionaryArray(array:NSArray) -> [EmailverificationData]
    {
        var models:[EmailverificationData] = []
        for item in array
        {
            models.append(EmailverificationData(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["storeName"] != nil) { storeName = EmailverificationStoreName(dictionary: dictionary["storeName"] as! NSDictionary) }
        if (dictionary["description"] != nil) { description = EmailverificationDescription(dictionary: dictionary["description"] as! NSDictionary) }
        userType = dictionary["userType"] as? String
        accountType = dictionary["accountType"] as? String
        
        reviews = dictionary["reviews"] as? Array<String>
         products = dictionary["products"] as? Array<String>
        
        //if (dictionary["reviews"] != nil) { reviews = Reviews.modelsFromDictionaryArray(dictionary["reviews"] as! NSArray) }
        //if (dictionary["products"] != nil) { products = Products.modelsFromDictionaryArray(dictionary["products"] as! NSArray) }
        paypalClientId = dictionary["paypalClientId"] as? String
        paypalSecretId = dictionary["paypalSecretId"] as? String
        phone = dictionary["phone"] as? String
        address = dictionary["address"] as? String
        
          location = dictionary["location"] as? Array<Double>
        
        //if (dictionary["location"] != nil) { location = Location.modelsFromDictionaryArray(dictionary["location"] as! NSArray) }
        averageRating = dictionary["averageRating"] as? Int
        gender = dictionary["gender"] as? String
        image = dictionary["image"] as? String
        isCartProcessing = dictionary["isCartProcessing"] as? Bool
        isActive = dictionary["isActive"] as? Bool
        isEmailVerified = dictionary["isEmailVerified"] as? Bool
        verificationCode = dictionary["verificationCode"] as? String
        _id = dictionary["_id"] as? String
        lastName = dictionary["lastName"] as? String
        email = dictionary["email"] as? String
        firstName = dictionary["firstName"] as? String
        role = dictionary["role"] as? String
        
        canReviewUsers = dictionary["canReviewUsers"] as? Array<String>
        addresses = dictionary["addresses"] as? Array<String>
        
        //if (dictionary["canReviewUsers"] != nil) { canReviewUsers = CanReviewUsers.modelsFromDictionaryArray(dictionary["canReviewUsers"] as! NSArray) }
        //if (dictionary["addresses"] != nil) { addresses = Addresses.modelsFromDictionaryArray(dictionary["addresses"] as! NSArray) }
        
        createdAt = dictionary["createdAt"] as? String
        updatedAt = dictionary["updatedAt"] as? String
        authorization = dictionary["authorization"] as? String
    }
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.storeName?.dictionaryRepresentation(), forKey: "storeName")
        dictionary.setValue(self.description?.dictionaryRepresentation(), forKey: "description")
        dictionary.setValue(self.userType, forKey: "userType")
        dictionary.setValue(self.accountType, forKey: "accountType")
        dictionary.setValue(self.paypalClientId, forKey: "paypalClientId")
        dictionary.setValue(self.paypalSecretId, forKey: "paypalSecretId")
        dictionary.setValue(self.phone, forKey: "phone")
        dictionary.setValue(self.address, forKey: "address")
        dictionary.setValue(self.averageRating, forKey: "averageRating")
        dictionary.setValue(self.gender, forKey: "gender")
        dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self.isCartProcessing, forKey: "isCartProcessing")
        dictionary.setValue(self.isActive, forKey: "isActive")
        dictionary.setValue(self.isEmailVerified, forKey: "isEmailVerified")
        dictionary.setValue(self.verificationCode, forKey: "verificationCode")
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.lastName, forKey: "lastName")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.firstName, forKey: "firstName")
        dictionary.setValue(self.role, forKey: "role")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        dictionary.setValue(self.authorization, forKey: "authorization")
        
        return dictionary
    }
    
}
