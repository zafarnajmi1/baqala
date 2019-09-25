//
//  ResendVerificationcodeModel.swift
//  Baqala
//
//  Created by Apple on 12/14/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation

public class ResendVerificationCode {
    public var success : Bool?
    public var message : ResendVerificationCodeMessage?
    public var data : ResendVerificationCodeData?
    public var errors : ResendVerificationCodeErrors?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ResendVerificationCode]
    {
        var models:[ResendVerificationCode] = []
        for item in array
        {
            models.append(ResendVerificationCode(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = ResendVerificationCodeMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = ResendVerificationCodeData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = ResendVerificationCodeErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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

public class ResendVerificationCodeMessage {
    public var ar : String?
    public var en : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ResendVerificationCodeMessage]
    {
        var models:[ResendVerificationCodeMessage] = []
        for item in array
        {
            models.append(ResendVerificationCodeMessage(dictionary: item as! NSDictionary)!)
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
public class ResendVerificationCodePermissions {
    public var canProfile : Bool?
    public var canProfileUpdate : Bool?
    public var canPasswordChange : Bool?

    public class func modelsFromDictionaryArray(array:NSArray) -> [ResendVerificationCodePermissions]
    {
        var models:[ResendVerificationCodePermissions] = []
        for item in array
        {
            models.append(ResendVerificationCodePermissions(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        canProfile = dictionary["canProfile"] as? Bool
        canProfileUpdate = dictionary["canProfileUpdate"] as? Bool
        canPasswordChange = dictionary["canPasswordChange"] as? Bool
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.canProfile, forKey: "canProfile")
        dictionary.setValue(self.canProfileUpdate, forKey: "canProfileUpdate")
        dictionary.setValue(self.canPasswordChange, forKey: "canPasswordChange")
        
        return dictionary
    }
    
}


public class ResendVerificationCodeRole {
    public var _id : String?
    public var title : String?
    public var roleType : String?
    public var createdAt : String?
    public var updatedAt : String?
    public var permissions : ResendVerificationCodePermissions?

    public class func modelsFromDictionaryArray(array:NSArray) -> [ResendVerificationCodeRole]
    {
        var models:[ResendVerificationCodeRole] = []
        for item in array
        {
            models.append(ResendVerificationCodeRole(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        title = dictionary["title"] as? String
        roleType = dictionary["roleType"] as? String
        createdAt = dictionary["createdAt"] as? String
        updatedAt = dictionary["updatedAt"] as? String
        if (dictionary["permissions"] != nil) { permissions = ResendVerificationCodePermissions(dictionary: dictionary["permissions"] as! NSDictionary) }
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.roleType, forKey: "roleType")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        dictionary.setValue(self.permissions?.dictionaryRepresentation(), forKey: "permissions")
        
        return dictionary
    }
    
}

public class ResendVerificationCodeStoreName {
    public var en : String?
    public var ar : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [ResendVerificationCodeStoreName]
    {
        var models:[ResendVerificationCodeStoreName] = []
        for item in array
        {
            models.append(ResendVerificationCodeStoreName(dictionary: item as! NSDictionary)!)
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
public class ResendVerificationCodeErrors {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ResendVerificationCodeErrors]
    {
        var models:[ResendVerificationCodeErrors] = []
        for item in array
        {
            models.append(ResendVerificationCodeErrors(dictionary: item as! NSDictionary)!)
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

public class ResendVerificationCodeDescription {
    public var en : String?
    public var ar : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ResendVerificationCodeDescription]
    {
        var models:[ResendVerificationCodeDescription] = []
        for item in array
        {
            models.append(ResendVerificationCodeDescription(dictionary: item as! NSDictionary)!)
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
public class ResendVerificationCodeData {
    public var _id : String?
    public var storeName : ResendVerificationCodeStoreName?
    public var description : ResendVerificationCodeDescription?
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
    public var email : String?
    public var lastName : String?
    public var firstName : String?
    public var role : ResendVerificationCodeRole?
    public var canReviewUsers : Array<String>?
    public var addresses : Array<String>?
    public var createdAt : String?
    public var updatedAt : String?
    public var authorization : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [ResendVerificationCodeData]
    {
        var models:[ResendVerificationCodeData] = []
        for item in array
        {
            models.append(ResendVerificationCodeData(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        _id = dictionary["_id"] as? String
        if (dictionary["storeName"] != nil) { storeName = ResendVerificationCodeStoreName(dictionary: dictionary["storeName"] as! NSDictionary) }
        if (dictionary["description"] != nil) { description = ResendVerificationCodeDescription(dictionary: dictionary["description"] as! NSDictionary) }
        userType = dictionary["userType"] as? String
        accountType = dictionary["accountType"] as? String
        
        reviews = dictionary["reviews"] as? Array<String>
        products = dictionary["products"] as? Array<String>
        
       // if (dictionary["reviews"] != nil) { reviews = Reviews.modelsFromDictionaryArray(dictionary["reviews"] as! NSArray) }
        //if (dictionary["products"] != nil) { products = Products.modelsFromDictionaryArray(dictionary["products"] as! NSArray) }
        paypalClientId = dictionary["paypalClientId"] as? String
        paypalSecretId = dictionary["paypalSecretId"] as? String
        phone = dictionary["phone"] as? String
        address = dictionary["address"] as? String
        
        location = dictionary["location"] as? Array<Double>
       // if (dictionary["location"] != nil) { location = Location.modelsFromDictionaryArray(dictionary["location"] as! NSArray) }
        
        averageRating = dictionary["averageRating"] as? Int
        gender = dictionary["gender"] as? String
        image = dictionary["image"] as? String
        isCartProcessing = dictionary["isCartProcessing"] as? Bool
        isActive = dictionary["isActive"] as? Bool
        isEmailVerified = dictionary["isEmailVerified"] as? Bool
        verificationCode = dictionary["verificationCode"] as? String
        email = dictionary["email"] as? String
        lastName = dictionary["lastName"] as? String
        firstName = dictionary["firstName"] as? String
        if (dictionary["role"] != nil) { role = ResendVerificationCodeRole(dictionary: dictionary["role"] as! NSDictionary) }
        
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
        
        dictionary.setValue(self._id, forKey: "_id")
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
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.lastName, forKey: "lastName")
        dictionary.setValue(self.firstName, forKey: "firstName")
        dictionary.setValue(self.role?.dictionaryRepresentation(), forKey: "role")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        dictionary.setValue(self.authorization, forKey: "authorization")
        
        return dictionary
    }
    
}
