//
//  SocialLoginModel.swift
//  Baqala
//
//  Created by Apple on 12/21/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
public class SocialLogin {
    public var success : Bool?
    public var message : SocialLoginMessage?
    public var data : SocialLoginData?
    public var errors : SocialLoginErrors?
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [SocialLogin]
    {
        var models:[SocialLogin] = []
        for item in array
        {
            models.append(SocialLogin(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    

    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = SocialLoginMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = SocialLoginData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = SocialLoginErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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


public class SocialLoginLanguage {
    
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [SocialLoginLanguage]
    {
        var models:[SocialLoginLanguage] = []
        for item in array
        {
            models.append(SocialLoginLanguage(dictionary: item as! NSDictionary)!)
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



public class SocialLoginMessage {
    public var ar : String?
    public var en : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [SocialLoginMessage]
    {
        var models:[SocialLoginMessage] = []
        for item in array
        {
            models.append(SocialLoginMessage(dictionary: item as! NSDictionary)!)
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
public class SocialLoginStoreName {
    public var en : String?
    public var ar : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [SocialLoginStoreName]
    {
        var models:[SocialLoginStoreName] = []
        for item in array
        {
            models.append(SocialLoginStoreName(dictionary: item as! NSDictionary)!)
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
public class Google {
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Google]
    {
        var models:[Google] = []
        for item in array
        {
            models.append(Google(dictionary: item as! NSDictionary)!)
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
public class Facebook {
    public var id : String?
    public var accessToken : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Facebook]
    {
        var models:[Facebook] = []
        for item in array
        {
            models.append(Facebook(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? String
        accessToken = dictionary["accessToken"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.accessToken, forKey: "accessToken")
        
        return dictionary
    }
    
}
public class SocialLoginErrors {

    public class func modelsFromDictionaryArray(array:NSArray) -> [SocialLoginErrors]
    {
        var models:[SocialLoginErrors] = []
        for item in array
        {
            models.append(SocialLoginErrors(dictionary: item as! NSDictionary)!)
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
public class SocialLoginDescription {
    public var en : String?
    public var ar : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [SocialLoginDescription]
    {
        var models:[SocialLoginDescription] = []
        for item in array
        {
            models.append(SocialLoginDescription(dictionary: item as! NSDictionary)!)
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

public class SocialLoginData {
    public var storeName : SocialLoginStoreName?
    public var description : SocialLoginDescription?
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
    public var verificationCode : Int?
    public var _id : String?
    public var firstName : String?
    public var lastName : String?
    public var email : String?
    public var facebook : Facebook?
    public var createdAt : String?
    public var updatedAt : String?
    public var canReviewUsers : Array<String>?
    public var addresses : Array<String>?
    public var language : SocialLoginLanguage?
    public var google : Google?
    public var categories : Array<String>?
    public var authorization : String?
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [SocialLoginData]
    {
        var models:[SocialLoginData] = []
        for item in array
        {
            models.append(SocialLoginData(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["storeName"] != nil) { storeName = SocialLoginStoreName(dictionary: dictionary["storeName"] as! NSDictionary) }
        if (dictionary["description"] != nil) { description = SocialLoginDescription(dictionary: dictionary["description"] as! NSDictionary) }
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
        
       // if (dictionary["location"] != nil) { location = Location.modelsFromDictionaryArray(dictionary["location"] as! NSArray) }
        averageRating = dictionary["averageRating"] as? Int
        gender = dictionary["gender"] as? String
        image = dictionary["image"] as? String
        isCartProcessing = dictionary["isCartProcessing"] as? Bool
        isActive = dictionary["isActive"] as? Bool
        isEmailVerified = dictionary["isEmailVerified"] as? Bool
        verificationCode = dictionary["verificationCode"] as? Int
        _id = dictionary["_id"] as? String
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        email = dictionary["email"] as? String
        if (dictionary["facebook"] != nil) { facebook = Facebook(dictionary: dictionary["facebook"] as! NSDictionary) }
        createdAt = dictionary["createdAt"] as? String
        updatedAt = dictionary["updatedAt"] as? String
        
          canReviewUsers = dictionary["canReviewUsers"] as? Array<String>
         addresses = dictionary["addresses"] as? Array<String>
        
       // if (dictionary["canReviewUsers"] != nil) { canReviewUsers = CanReviewUsers.modelsFromDictionaryArray(dictionary["canReviewUsers"] as! NSArray) }
        //if (dictionary["addresses"] != nil) { addresses = Addresses.modelsFromDictionaryArray(dictionary["addresses"] as! NSArray) }
        if (dictionary["language"] != nil) { language = SocialLoginLanguage(dictionary: dictionary["language"] as! NSDictionary) }
        if (dictionary["google"] != nil) { google = Google(dictionary: dictionary["google"] as! NSDictionary) }
        
         categories = dictionary["categories"] as? Array<String>
        
        //if (dictionary["categories"] != nil) { categories = Categories.modelsFromDictionaryArray(dictionary["categories"] as! NSArray) }
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
        dictionary.setValue(self.firstName, forKey: "firstName")
        dictionary.setValue(self.lastName, forKey: "lastName")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.facebook?.dictionaryRepresentation(), forKey: "facebook")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        dictionary.setValue(self.language?.dictionaryRepresentation(), forKey: "language")
        dictionary.setValue(self.google?.dictionaryRepresentation(), forKey: "google")
        dictionary.setValue(self.authorization, forKey: "authorization")
        
        return dictionary
    }
    
}
