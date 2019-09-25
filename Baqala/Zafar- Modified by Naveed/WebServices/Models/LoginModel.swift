//
//  LoginModel.swift
//  Baqala
//
//  Created by Apple on 12/14/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation




public class Login {
    public var success : Bool?
    public var message : LoginMessage?
    public var data : LoginData?
    public var errors : LoginErrors?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Login]
    {
        var models:[Login] = []
        for item in array
        {
            models.append(Login(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = LoginMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = LoginData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = LoginErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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

public class LoginMessage {
    public var en : String?
    public var ar : String?
    public var helpUrl : String?
    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginMessage]
    {
        var models:[LoginMessage] = []
        for item in array
        {
            models.append(LoginMessage(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        en = dictionary["en"] as? String
        ar = dictionary["ar"] as? String
        helpUrl = dictionary["helpUrl"] as? String
    }
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.en, forKey: "en")
        dictionary.setValue(self.ar, forKey: "ar")
        dictionary.setValue(self.helpUrl, forKey: "helpUrl")
        
        return dictionary
    }
    
}
public class LoginStoreName {
    public var en : String?
    public var ar : String?
    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginStoreName]
    {
        var models:[LoginStoreName] = []
        for item in array
        {
            models.append(LoginStoreName(dictionary: item as! NSDictionary)!)
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

public class LoginErrors {

    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginErrors]
    {
        var models:[LoginErrors] = []
        for item in array
        {
            models.append(LoginErrors(dictionary: item as! NSDictionary)!)
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
public class LoginDescription {
    public var en : String?
    public var ar : String?
    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginDescription]
    {
        var models:[LoginDescription] = []
        for item in array
        {
            models.append(LoginDescription(dictionary: item as! NSDictionary)!)
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
public class LoginData {
    public var storeName : LoginStoreName?
    public var description : LoginDescription?
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
    public var firstName : String?
    public var lastName : String?
    public var email : String?
    public var role : String?
    public var canReviewUsers : Array<String>?
    public var addresses : Array<String>?
    public var createdAt : String?
    public var updatedAt : String?
    public var authorization : String?
    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginData]
    {
        var models:[LoginData] = []
        for item in array
        {
            models.append(LoginData(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["storeName"] != nil) { storeName = LoginStoreName(dictionary: dictionary["storeName"] as! NSDictionary) }
        if (dictionary["description"] != nil) { description = LoginDescription(dictionary: dictionary["description"] as! NSDictionary) }
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
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        email = dictionary["email"] as? String
        role = dictionary["role"] as? String
        
        canReviewUsers = dictionary[""] as? Array<String>
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
        dictionary.setValue(self.firstName, forKey: "firstName")
        dictionary.setValue(self.lastName, forKey: "lastName")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.role, forKey: "role")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        dictionary.setValue(self.authorization, forKey: "authorization")
        
        return dictionary
    }
    
}


//public class Login {
//    public var success : Bool?
//    public var message : LoginMessage?
//    public var data : LoginData?
//    public var errors : LoginErrors?
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [Login]
//    {
//        var models:[Login] = []
//        for item in array
//        {
//            models.append(Login(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    required public init?(dictionary: NSDictionary) {
//
//        success = dictionary["success"] as? Bool
//        if (dictionary["message"] != nil) { message = LoginMessage(dictionary: dictionary["message"] as! NSDictionary) }
//        if (dictionary["data"] != nil) { data = LoginData(dictionary: dictionary["data"] as! NSDictionary) }
//        if (dictionary["errors"] != nil) { errors = LoginErrors(dictionary: dictionary["errors"] as! NSDictionary) }
//    }
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
//
//public class LoginMessage {
//
//    public var en : String?
//    public var ar : String?
//    public var helpUrl : String?
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginMessage]
//    {
//        var models:[LoginMessage] = []
//        for item in array
//        {
//            models.append(LoginMessage(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    required public init?(dictionary: NSDictionary) {
//
//        en = dictionary["en"] as? String
//        ar = dictionary["ar"] as? String
//        helpUrl = dictionary["helpUrl"] as? String
//    }
//    public func dictionaryRepresentation() -> NSDictionary {
//
//        let dictionary = NSMutableDictionary()
//
//        dictionary.setValue(self.en, forKey: "en")
//        dictionary.setValue(self.ar, forKey: "ar")
//        dictionary.setValue(self.helpUrl, forKey: "helpUrl")
//
//        return dictionary
//    }
//
//}
//public class LoginPermissions {
//    public var canViewSubadmins : Bool?
//    public var canStoreSubadmin : Bool?
//    public var canUpdateSubadmin : Bool?
//    public var canDeleteSubadmin : Bool?
//    public var canViewRoles : Bool?
//    public var canStoreRole : Bool?
//    public var canUpdateRole : Bool?
//    public var canDeleteRole : Bool?
//    public var canViewPages : Bool?
//    public var canStorePage : Bool?
//    public var canUpdatePage : Bool?
//    public var canDeletePage : Bool?
//    public var canViewSliders : Bool?
//    public var canStoreSlider : Bool?
//    public var canUpdateSlider : Bool?
//    public var canDeleteSlider : Bool?
//    public var canGiveFeedback : Bool?
//    public var canReportError : Bool?
//    public var canUpdateSetting : Bool?
//    public var canPermissions : Bool?
//    public var canProfile : Bool?
//    public var canProfileUpdate : Bool?
//    public var canPasswordChange : Bool?
//    public var canEditSetting : Bool?
//    public var canViewGroups : Bool?
//    public var canUpdateGroups : Bool?
//    public var canStoreGroups : Bool?
//    public var canDeleteGroups : Bool?
//    public var canViewDivisions : Bool?
//    public var canUpdateDivisions : Bool?
//    public var canStoreDivisions : Bool?
//    public var canDeleteDivisions : Bool?
//    public var canViewSections : Bool?
//    public var canUpdateSections : Bool?
//    public var canStoreSections : Bool?
//    public var canDeleteSections : Bool?
//    public var canViewFeatures : Bool?
//    public var canUpdateFeatures : Bool?
//    public var canStoreFeatures : Bool?
//    public var canDeleteFeatures : Bool?
//    public var canViewCharacteristics : Bool?
//    public var canUpdateCharacteristics : Bool?
//    public var canStoreCharacteristics : Bool?
//    public var canDeleteCharacteristics : Bool?
//    public var canViewManufacturers : Bool?
//    public var canUpdateManufacturers : Bool?
//    public var canStoreManufacturers : Bool?
//    public var canDeleteManufacturers : Bool?
//    public var canViewCities : Bool?
//    public var canUpdateCities : Bool?
//    public var canStoreCities : Bool?
//    public var canDeleteCities : Bool?
//    public var canViewPlaces : Bool?
//    public var canUpdatePlaces : Bool?
//    public var canStorePlaces : Bool?
//    public var canDeletePlaces : Bool?
//    public var canViewStores : Bool?
//    public var canUpdateStores : Bool?
//    public var canStoreStores : Bool?
//    public var canDeleteStores : Bool?
//    public var canViewProducts : Bool?
//    public var canUpdateProducts : Bool?
//    public var canStoreProducts : Bool?
//    public var canDeleteProducts : Bool?
//    public var canViewSlider : Bool?
//
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginPermissions]
//    {
//        var models:[LoginPermissions] = []
//        for item in array
//        {
//            models.append(LoginPermissions(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//
//    required public init?(dictionary: NSDictionary) {
//
//        canViewSubadmins = dictionary["canViewSubadmins"] as? Bool
//        canStoreSubadmin = dictionary["canStoreSubadmin"] as? Bool
//        canUpdateSubadmin = dictionary["canUpdateSubadmin"] as? Bool
//        canDeleteSubadmin = dictionary["canDeleteSubadmin"] as? Bool
//        canViewRoles = dictionary["canViewRoles"] as? Bool
//        canStoreRole = dictionary["canStoreRole"] as? Bool
//        canUpdateRole = dictionary["canUpdateRole"] as? Bool
//        canDeleteRole = dictionary["canDeleteRole"] as? Bool
//        canViewPages = dictionary["canViewPages"] as? Bool
//        canStorePage = dictionary["canStorePage"] as? Bool
//        canUpdatePage = dictionary["canUpdatePage"] as? Bool
//        canDeletePage = dictionary["canDeletePage"] as? Bool
//        canViewSliders = dictionary["canViewSliders"] as? Bool
//        canStoreSlider = dictionary["canStoreSlider"] as? Bool
//        canUpdateSlider = dictionary["canUpdateSlider"] as? Bool
//        canDeleteSlider = dictionary["canDeleteSlider"] as? Bool
//        canGiveFeedback = dictionary["canGiveFeedback"] as? Bool
//        canReportError = dictionary["canReportError"] as? Bool
//        canUpdateSetting = dictionary["canUpdateSetting"] as? Bool
//        canPermissions = dictionary["canPermissions"] as? Bool
//        canProfile = dictionary["canProfile"] as? Bool
//        canProfileUpdate = dictionary["canProfileUpdate"] as? Bool
//        canPasswordChange = dictionary["canPasswordChange"] as? Bool
//        canEditSetting = dictionary["canEditSetting"] as? Bool
//        canViewGroups = dictionary["canViewGroups"] as? Bool
//        canUpdateGroups = dictionary["canUpdateGroups"] as? Bool
//        canStoreGroups = dictionary["canStoreGroups"] as? Bool
//        canDeleteGroups = dictionary["canDeleteGroups"] as? Bool
//        canViewDivisions = dictionary["canViewDivisions"] as? Bool
//        canUpdateDivisions = dictionary["canUpdateDivisions"] as? Bool
//        canStoreDivisions = dictionary["canStoreDivisions"] as? Bool
//        canDeleteDivisions = dictionary["canDeleteDivisions"] as? Bool
//        canViewSections = dictionary["canViewSections"] as? Bool
//        canUpdateSections = dictionary["canUpdateSections"] as? Bool
//        canStoreSections = dictionary["canStoreSections"] as? Bool
//        canDeleteSections = dictionary["canDeleteSections"] as? Bool
//        canViewFeatures = dictionary["canViewFeatures"] as? Bool
//        canUpdateFeatures = dictionary["canUpdateFeatures"] as? Bool
//        canStoreFeatures = dictionary["canStoreFeatures"] as? Bool
//        canDeleteFeatures = dictionary["canDeleteFeatures"] as? Bool
//        canViewCharacteristics = dictionary["canViewCharacteristics"] as? Bool
//        canUpdateCharacteristics = dictionary["canUpdateCharacteristics"] as? Bool
//        canStoreCharacteristics = dictionary["canStoreCharacteristics"] as? Bool
//        canDeleteCharacteristics = dictionary["canDeleteCharacteristics"] as? Bool
//        canViewManufacturers = dictionary["canViewManufacturers"] as? Bool
//        canUpdateManufacturers = dictionary["canUpdateManufacturers"] as? Bool
//        canStoreManufacturers = dictionary["canStoreManufacturers"] as? Bool
//        canDeleteManufacturers = dictionary["canDeleteManufacturers"] as? Bool
//        canViewCities = dictionary["canViewCities"] as? Bool
//        canUpdateCities = dictionary["canUpdateCities"] as? Bool
//        canStoreCities = dictionary["canStoreCities"] as? Bool
//        canDeleteCities = dictionary["canDeleteCities"] as? Bool
//        canViewPlaces = dictionary["canViewPlaces"] as? Bool
//        canUpdatePlaces = dictionary["canUpdatePlaces"] as? Bool
//        canStorePlaces = dictionary["canStorePlaces"] as? Bool
//        canDeletePlaces = dictionary["canDeletePlaces"] as? Bool
//        canViewStores = dictionary["canViewStores"] as? Bool
//        canUpdateStores = dictionary["canUpdateStores"] as? Bool
//        canStoreStores = dictionary["canStoreStores"] as? Bool
//        canDeleteStores = dictionary["canDeleteStores"] as? Bool
//        canViewProducts = dictionary["canViewProducts"] as? Bool
//        canUpdateProducts = dictionary["canUpdateProducts"] as? Bool
//        canStoreProducts = dictionary["canStoreProducts"] as? Bool
//        canDeleteProducts = dictionary["canDeleteProducts"] as? Bool
//        canViewSlider = dictionary["canViewSlider"] as? Bool
//    }
//    public func dictionaryRepresentation() -> NSDictionary {
//
//        let dictionary = NSMutableDictionary()
//
//        dictionary.setValue(self.canViewSubadmins, forKey: "canViewSubadmins")
//        dictionary.setValue(self.canStoreSubadmin, forKey: "canStoreSubadmin")
//        dictionary.setValue(self.canUpdateSubadmin, forKey: "canUpdateSubadmin")
//        dictionary.setValue(self.canDeleteSubadmin, forKey: "canDeleteSubadmin")
//        dictionary.setValue(self.canViewRoles, forKey: "canViewRoles")
//        dictionary.setValue(self.canStoreRole, forKey: "canStoreRole")
//        dictionary.setValue(self.canUpdateRole, forKey: "canUpdateRole")
//        dictionary.setValue(self.canDeleteRole, forKey: "canDeleteRole")
//        dictionary.setValue(self.canViewPages, forKey: "canViewPages")
//        dictionary.setValue(self.canStorePage, forKey: "canStorePage")
//        dictionary.setValue(self.canUpdatePage, forKey: "canUpdatePage")
//        dictionary.setValue(self.canDeletePage, forKey: "canDeletePage")
//        dictionary.setValue(self.canViewSliders, forKey: "canViewSliders")
//        dictionary.setValue(self.canStoreSlider, forKey: "canStoreSlider")
//        dictionary.setValue(self.canUpdateSlider, forKey: "canUpdateSlider")
//        dictionary.setValue(self.canDeleteSlider, forKey: "canDeleteSlider")
//        dictionary.setValue(self.canGiveFeedback, forKey: "canGiveFeedback")
//        dictionary.setValue(self.canReportError, forKey: "canReportError")
//        dictionary.setValue(self.canUpdateSetting, forKey: "canUpdateSetting")
//        dictionary.setValue(self.canPermissions, forKey: "canPermissions")
//        dictionary.setValue(self.canProfile, forKey: "canProfile")
//        dictionary.setValue(self.canProfileUpdate, forKey: "canProfileUpdate")
//        dictionary.setValue(self.canPasswordChange, forKey: "canPasswordChange")
//        dictionary.setValue(self.canEditSetting, forKey: "canEditSetting")
//        dictionary.setValue(self.canViewGroups, forKey: "canViewGroups")
//        dictionary.setValue(self.canUpdateGroups, forKey: "canUpdateGroups")
//        dictionary.setValue(self.canStoreGroups, forKey: "canStoreGroups")
//        dictionary.setValue(self.canDeleteGroups, forKey: "canDeleteGroups")
//        dictionary.setValue(self.canViewDivisions, forKey: "canViewDivisions")
//        dictionary.setValue(self.canUpdateDivisions, forKey: "canUpdateDivisions")
//        dictionary.setValue(self.canStoreDivisions, forKey: "canStoreDivisions")
//        dictionary.setValue(self.canDeleteDivisions, forKey: "canDeleteDivisions")
//        dictionary.setValue(self.canViewSections, forKey: "canViewSections")
//        dictionary.setValue(self.canUpdateSections, forKey: "canUpdateSections")
//        dictionary.setValue(self.canStoreSections, forKey: "canStoreSections")
//        dictionary.setValue(self.canDeleteSections, forKey: "canDeleteSections")
//        dictionary.setValue(self.canViewFeatures, forKey: "canViewFeatures")
//        dictionary.setValue(self.canUpdateFeatures, forKey: "canUpdateFeatures")
//        dictionary.setValue(self.canStoreFeatures, forKey: "canStoreFeatures")
//        dictionary.setValue(self.canDeleteFeatures, forKey: "canDeleteFeatures")
//        dictionary.setValue(self.canViewCharacteristics, forKey: "canViewCharacteristics")
//        dictionary.setValue(self.canUpdateCharacteristics, forKey: "canUpdateCharacteristics")
//        dictionary.setValue(self.canStoreCharacteristics, forKey: "canStoreCharacteristics")
//        dictionary.setValue(self.canDeleteCharacteristics, forKey: "canDeleteCharacteristics")
//        dictionary.setValue(self.canViewManufacturers, forKey: "canViewManufacturers")
//        dictionary.setValue(self.canUpdateManufacturers, forKey: "canUpdateManufacturers")
//        dictionary.setValue(self.canStoreManufacturers, forKey: "canStoreManufacturers")
//        dictionary.setValue(self.canDeleteManufacturers, forKey: "canDeleteManufacturers")
//        dictionary.setValue(self.canViewCities, forKey: "canViewCities")
//        dictionary.setValue(self.canUpdateCities, forKey: "canUpdateCities")
//        dictionary.setValue(self.canStoreCities, forKey: "canStoreCities")
//        dictionary.setValue(self.canDeleteCities, forKey: "canDeleteCities")
//        dictionary.setValue(self.canViewPlaces, forKey: "canViewPlaces")
//        dictionary.setValue(self.canUpdatePlaces, forKey: "canUpdatePlaces")
//        dictionary.setValue(self.canStorePlaces, forKey: "canStorePlaces")
//        dictionary.setValue(self.canDeletePlaces, forKey: "canDeletePlaces")
//        dictionary.setValue(self.canViewStores, forKey: "canViewStores")
//        dictionary.setValue(self.canUpdateStores, forKey: "canUpdateStores")
//        dictionary.setValue(self.canStoreStores, forKey: "canStoreStores")
//        dictionary.setValue(self.canDeleteStores, forKey: "canDeleteStores")
//        dictionary.setValue(self.canViewProducts, forKey: "canViewProducts")
//        dictionary.setValue(self.canUpdateProducts, forKey: "canUpdateProducts")
//        dictionary.setValue(self.canStoreProducts, forKey: "canStoreProducts")
//        dictionary.setValue(self.canDeleteProducts, forKey: "canDeleteProducts")
//        dictionary.setValue(self.canViewSlider, forKey: "canViewSlider")
//
//        return dictionary
//    }
//
//}
//public class LoginRole {
//    public var permissions : LoginPermissions?
//    public var _id : String?
//    public var title : String?
//    public var roleType : String?
//    public var createdAt : String?
//    public var updatedAt : String?
//    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginRole]
//    {
//        var models:[LoginRole] = []
//        for item in array
//        {
//            models.append(LoginRole(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    required public init?(dictionary: NSDictionary) {
//
//        if (dictionary["permissions"] != nil) { permissions = LoginPermissions(dictionary: dictionary["permissions"] as! NSDictionary) }
//        _id = dictionary["_id"] as? String
//        title = dictionary["title"] as? String
//        roleType = dictionary["roleType"] as? String
//        createdAt = dictionary["createdAt"] as? String
//        updatedAt = dictionary["updatedAt"] as? String
//    }
//    public func dictionaryRepresentation() -> NSDictionary {
//
//        let dictionary = NSMutableDictionary()
//
//        dictionary.setValue(self.permissions?.dictionaryRepresentation(), forKey: "permissions")
//        dictionary.setValue(self._id, forKey: "_id")
//        dictionary.setValue(self.title, forKey: "title")
//        dictionary.setValue(self.roleType, forKey: "roleType")
//        dictionary.setValue(self.createdAt, forKey: "createdAt")
//        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
//
//        return dictionary
//    }
//
//}
//public class LoginStoreName {
//    public var en : String?
//    public var ar : String?
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginStoreName]
//    {
//        var models:[LoginStoreName] = []
//        for item in array
//        {
//            models.append(LoginStoreName(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    required public init?(dictionary: NSDictionary) {
//
//        en = dictionary["en"] as? String
//        ar = dictionary["ar"] as? String
//    }
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
//
//public class LoginErrors {
//    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginErrors]
//    {
//        var models:[LoginErrors] = []
//        for item in array
//        {
//            models.append(LoginErrors(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
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
//
//
//public class LoginDescription {
//    public var en : String?
//    public var ar : String?
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginDescription]
//    {
//        var models:[LoginDescription] = []
//        for item in array
//        {
//            models.append(LoginDescription(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
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
//
//public class LoginData {
//    public var storeName : LoginStoreName?
//    public var description : LoginDescription?
//    public var userType : String?
//    public var accountType : String?
//    public var reviews : Array<String>?
//    public var products : Array<String>?
//    public var paypalClientId : String?
//    public var paypalSecretId : String?
//    public var phone : String?
//    public var address : String?
//    public var location : Array<Double>?
//    public var averageRating : Int?
//    public var gender : String?
//    public var image : String?
//    public var isCartProcessing : Bool?
//    public var isActive : Bool?
//    public var isEmailVerified : Bool?
//    public var verificationCode : String?
//    public var _id : String?
//    public var firstName : String?
//    public var lastName : String?
//    public var email : String?
//    public var role : LoginRole?
//    public var canReviewUsers : Array<String>?
//    public var addresses : Array<String>?
//    public var createdAt : String?
//    public var updatedAt : String?
//    public var authorization : String?
//
//    public class func modelsFromDictionaryArray(array:NSArray) -> [LoginData]
//    {
//        var models:[LoginData] = []
//        for item in array
//        {
//            models.append(LoginData(dictionary: item as! NSDictionary)!)
//        }
//        return models
//    }
//    required public init?(dictionary: NSDictionary) {
//
//        if (dictionary["storeName"] != nil) { storeName = LoginStoreName(dictionary: dictionary["storeName"] as! NSDictionary) }
//        if (dictionary["description"] != nil) { description = LoginDescription(dictionary: dictionary["description"] as! NSDictionary) }
//        userType = dictionary["userType"] as? String
//        accountType = dictionary["accountType"] as? String
//
//        reviews = dictionary["reviews"] as? Array<String>
//        products = dictionary["products"] as? Array<String>
//
//        //if (dictionary["reviews"] != nil) { reviews = Reviews.modelsFromDictionaryArray(dictionary["reviews"] as! NSArray) }
//        //if (dictionary["products"] != nil) { products = Products.modelsFromDictionaryArray(dictionary["products"] as! NSArray) }
//
//        paypalClientId = dictionary["paypalClientId"] as? String
//        paypalSecretId = dictionary["paypalSecretId"] as? String
//        phone = dictionary["phone"] as? String
//        address = dictionary["address"] as? String
//
//        location = dictionary["location"] as? Array<Double>
//
//       // if (dictionary["location"] != nil) { location = Location.modelsFromDictionaryArray(dictionary["location"] as! NSArray) }
//        averageRating = dictionary["averageRating"] as? Int
//        gender = dictionary["gender"] as? String
//        image = dictionary["image"] as? String
//        isCartProcessing = dictionary["isCartProcessing"] as? Bool
//        isActive = dictionary["isActive"] as? Bool
//        isEmailVerified = dictionary["isEmailVerified"] as? Bool
//        verificationCode = dictionary["verificationCode"] as? String
//        _id = dictionary["_id"] as? String
//        firstName = dictionary["firstName"] as? String
//        lastName = dictionary["lastName"] as? String
//        email = dictionary["email"] as? String
//        if (dictionary["role"] != nil) { role = LoginRole(dictionary: dictionary["role"] as! NSDictionary) }
//
//           canReviewUsers = dictionary["canReviewUsers"] as? Array<String>
//          addresses = dictionary["addresses"] as? Array<String>
//
//        //if (dictionary["canReviewUsers"] != nil) { canReviewUsers = CanReviewUsers.modelsFromDictionaryArray(dictionary["canReviewUsers"] as! NSArray) }
//        //if (dictionary["addresses"] != nil) { addresses = Addresses.modelsFromDictionaryArray(dictionary["addresses"] as! NSArray) }
//
//        createdAt = dictionary["createdAt"] as? String
//        updatedAt = dictionary["updatedAt"] as? String
//        authorization = dictionary["authorization"] as? String
//    }
//    public func dictionaryRepresentation() -> NSDictionary {
//
//        let dictionary = NSMutableDictionary()
//
//        dictionary.setValue(self.storeName?.dictionaryRepresentation(), forKey: "storeName")
//        dictionary.setValue(self.description?.dictionaryRepresentation(), forKey: "description")
//        dictionary.setValue(self.userType, forKey: "userType")
//        dictionary.setValue(self.accountType, forKey: "accountType")
//        dictionary.setValue(self.paypalClientId, forKey: "paypalClientId")
//        dictionary.setValue(self.paypalSecretId, forKey: "paypalSecretId")
//        dictionary.setValue(self.phone, forKey: "phone")
//        dictionary.setValue(self.address, forKey: "address")
//        dictionary.setValue(self.averageRating, forKey: "averageRating")
//        dictionary.setValue(self.gender, forKey: "gender")
//        dictionary.setValue(self.image, forKey: "image")
//        dictionary.setValue(self.isCartProcessing, forKey: "isCartProcessing")
//        dictionary.setValue(self.isActive, forKey: "isActive")
//        dictionary.setValue(self.isEmailVerified, forKey: "isEmailVerified")
//        dictionary.setValue(self.verificationCode, forKey: "verificationCode")
//        dictionary.setValue(self._id, forKey: "_id")
//        dictionary.setValue(self.firstName, forKey: "firstName")
//        dictionary.setValue(self.lastName, forKey: "lastName")
//        dictionary.setValue(self.email, forKey: "email")
//        dictionary.setValue(self.role?.dictionaryRepresentation(), forKey: "role")
//        dictionary.setValue(self.createdAt, forKey: "createdAt")
//        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
//        dictionary.setValue(self.authorization, forKey: "authorization")
//
//        return dictionary
//    }
//
//}
