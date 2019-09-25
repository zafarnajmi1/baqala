//
//  AboutUsTermsConditionPrivacyPolicyModel.swift
//  Baqala
//
//  Created by Apple on 12/18/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation

public class AboutUsTermsConditionPrivacyPolicy {
    public var success : Bool?
    public var message : AboutUsTermsConditionPrivacyPolicyMessage?
    public var data : AboutUsTermsConditionPrivacyPolicyData?
    public var errors : AboutUsTermsConditionPrivacyPolicyErrors?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicy]
    {
        var models:[AboutUsTermsConditionPrivacyPolicy] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicy(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        if (dictionary["message"] != nil) { message = AboutUsTermsConditionPrivacyPolicyMessage(dictionary: dictionary["message"] as! NSDictionary) }
        if (dictionary["data"] != nil) { data = AboutUsTermsConditionPrivacyPolicyData(dictionary: dictionary["data"] as! NSDictionary) }
        if (dictionary["errors"] != nil) { errors = AboutUsTermsConditionPrivacyPolicyErrors(dictionary: dictionary["errors"] as! NSDictionary) }
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
public class AboutUsTermsConditionPrivacyPolicyMessage {
    public var ar : String?
    public var en : String?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicyMessage]
    {
        var models:[AboutUsTermsConditionPrivacyPolicyMessage] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicyMessage(dictionary: item as! NSDictionary)!)
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


public class AboutUsTermsConditionPrivacyPolicyPages {
    public var title : AboutUsTermsConditionPrivacyPolicyTitle?
    public var detail : AboutUsTermsConditionPrivacyPolicyDetail?
    public var image : String?
    public var icon : String?
    public var _id : String?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicyPages]
    {
        var models:[AboutUsTermsConditionPrivacyPolicyPages] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicyPages(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["title"] != nil) { title = AboutUsTermsConditionPrivacyPolicyTitle(dictionary: dictionary["title"] as! NSDictionary) }
        if (dictionary["detail"] != nil) { detail = AboutUsTermsConditionPrivacyPolicyDetail(dictionary: dictionary["detail"] as! NSDictionary) }
        image = dictionary["image"] as? String
        icon = dictionary["icon"] as? String
        _id = dictionary["_id"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.title?.dictionaryRepresentation(), forKey: "title")
        dictionary.setValue(self.detail?.dictionaryRepresentation(), forKey: "detail")
        dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self.icon, forKey: "icon")
        dictionary.setValue(self._id, forKey: "_id")
        
        return dictionary
    }
    
}
public class AboutUsTermsConditionPrivacyPolicyPriceTypes {
    public var title : AboutUsTermsConditionPrivacyPolicyTitle?
    public var _id : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicyPriceTypes]
    {
        var models:[AboutUsTermsConditionPrivacyPolicyPriceTypes] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicyPriceTypes(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["title"] != nil) { title = AboutUsTermsConditionPrivacyPolicyTitle(dictionary: dictionary["title"] as! NSDictionary) }
        _id = dictionary["_id"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.title?.dictionaryRepresentation(), forKey: "title")
        dictionary.setValue(self._id, forKey: "_id")
        
        return dictionary
    }
    
}


public class AboutUsTermsConditionPrivacyPolicySettings {
    public var aboutShortDescription : AboutUsTermsConditionPrivacyPolicyAboutShortDescription?
    public var contactEmail : String?
    public var emailSenderName : String?
    public var emailFrom : String?
    public var facebook : String?
    public var twitter : String?
    public var instagram : String?
    public var linkedin : String?
    public var location : String?
    public var latitude : String?
    public var longitude : String?
    public var minPrice : Int?
    public var maxPrice : Int?
    public var _id : String?
    public var contactNumber : String?
    public var updatedAt : String?
    public var footerImage : String?
    public var createdAt : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicySettings]
    {
        var models:[AboutUsTermsConditionPrivacyPolicySettings] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicySettings(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["aboutShortDescription"] != nil) { aboutShortDescription = AboutUsTermsConditionPrivacyPolicyAboutShortDescription(dictionary: dictionary["aboutShortDescription"] as! NSDictionary) }
        contactEmail = dictionary["contactEmail"] as? String
        emailSenderName = dictionary["emailSenderName"] as? String
        emailFrom = dictionary["emailFrom"] as? String
        facebook = dictionary["facebook"] as? String
        twitter = dictionary["twitter"] as? String
        instagram = dictionary["instagram"] as? String
        linkedin = dictionary["linkedin"] as? String
        location = dictionary["location"] as? String
        latitude = dictionary["latitude"] as? String
        longitude = dictionary["longitude"] as? String
        minPrice = dictionary["minPrice"] as? Int
        maxPrice = dictionary["maxPrice"] as? Int
        _id = dictionary["_id"] as? String
        contactNumber = dictionary["contactNumber"] as? String
        updatedAt = dictionary["updatedAt"] as? String
        footerImage = dictionary["footerImage"] as? String
        createdAt = dictionary["createdAt"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.aboutShortDescription?.dictionaryRepresentation(), forKey: "aboutShortDescription")
        dictionary.setValue(self.contactEmail, forKey: "contactEmail")
        dictionary.setValue(self.emailSenderName, forKey: "emailSenderName")
        dictionary.setValue(self.emailFrom, forKey: "emailFrom")
        dictionary.setValue(self.facebook, forKey: "facebook")
        dictionary.setValue(self.twitter, forKey: "twitter")
        dictionary.setValue(self.instagram, forKey: "instagram")
        dictionary.setValue(self.linkedin, forKey: "linkedin")
        dictionary.setValue(self.location, forKey: "location")
        dictionary.setValue(self.latitude, forKey: "latitude")
        dictionary.setValue(self.longitude, forKey: "longitude")
        dictionary.setValue(self.minPrice, forKey: "minPrice")
        dictionary.setValue(self.maxPrice, forKey: "maxPrice")
        dictionary.setValue(self._id, forKey: "_id")
        dictionary.setValue(self.contactNumber, forKey: "contactNumber")
        dictionary.setValue(self.updatedAt, forKey: "updatedAt")
        dictionary.setValue(self.footerImage, forKey: "footerImage")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        
        return dictionary
    }
    
}
public class AboutUsTermsConditionPrivacyPolicySliders {
    public var title : AboutUsTermsConditionPrivacyPolicyTitle?
    public var detail : AboutUsTermsConditionPrivacyPolicyDetail?
    public var image : String?
    public var _id : String?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicySliders]
    {
        var models:[AboutUsTermsConditionPrivacyPolicySliders] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicySliders(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    

    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["title"] != nil) { title = AboutUsTermsConditionPrivacyPolicyTitle(dictionary: dictionary["title"] as! NSDictionary) }
        if (dictionary["detail"] != nil) { detail = AboutUsTermsConditionPrivacyPolicyDetail(dictionary: dictionary["detail"] as! NSDictionary) }
        image = dictionary["image"] as? String
        _id = dictionary["_id"] as? String
    }
    

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.title?.dictionaryRepresentation(), forKey: "title")
        dictionary.setValue(self.detail?.dictionaryRepresentation(), forKey: "detail")
        dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self._id, forKey: "_id")
        
        return dictionary
    }
    
}


public class AboutUsTermsConditionPrivacyPolicyTitle {
    public var en : String?
    public var ar : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicyTitle]
    {
        var models:[AboutUsTermsConditionPrivacyPolicyTitle] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicyTitle(dictionary: item as! NSDictionary)!)
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
public class AboutUsTermsConditionPrivacyPolicyErrors {
    

    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicyErrors]
    {
        var models:[AboutUsTermsConditionPrivacyPolicyErrors] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicyErrors(dictionary: item as! NSDictionary)!)
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
public class AboutUsTermsConditionPrivacyPolicyDetail {
    public var ar : String?
    public var en : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicyDetail]
    {
        var models:[AboutUsTermsConditionPrivacyPolicyDetail] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicyDetail(dictionary: item as! NSDictionary)!)
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
public class AboutUsTermsConditionPrivacyPolicyData {
    public var settings : AboutUsTermsConditionPrivacyPolicySettings?
    public var categories : Array<AboutUsTermsConditionPrivacyPolicyCategories>?
    public var pages : Array<AboutUsTermsConditionPrivacyPolicyPages>?
    public var sliders : Array<AboutUsTermsConditionPrivacyPolicySliders>?
    public var priceTypes : Array<AboutUsTermsConditionPrivacyPolicyPriceTypes>?

    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicyData]
    {
        var models:[AboutUsTermsConditionPrivacyPolicyData] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicyData(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["settings"] != nil) { settings = AboutUsTermsConditionPrivacyPolicySettings(dictionary: dictionary["settings"] as! NSDictionary) }
        if (dictionary["categories"] != nil) { categories = AboutUsTermsConditionPrivacyPolicyCategories.modelsFromDictionaryArray(array: dictionary["categories"] as! NSArray) }
        if (dictionary["pages"] != nil) { pages = AboutUsTermsConditionPrivacyPolicyPages.modelsFromDictionaryArray(array: dictionary["pages"] as! NSArray) }
        if (dictionary["sliders"] != nil) { sliders = AboutUsTermsConditionPrivacyPolicySliders.modelsFromDictionaryArray(array: dictionary["sliders"] as! NSArray) }
        if (dictionary["priceTypes"] != nil) { priceTypes = AboutUsTermsConditionPrivacyPolicyPriceTypes.modelsFromDictionaryArray(array: dictionary["priceTypes"] as! NSArray) }
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.settings?.dictionaryRepresentation(), forKey: "settings")
        
        return dictionary
    }
    
}
public class AboutUsTermsConditionPrivacyPolicyChildren {
    public var title : AboutUsTermsConditionPrivacyPolicyTitle?
    public var image : String?
    public var children : Array<String>?
    public var depth : Int?
    public var _id : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicyChildren]
    {
        var models:[AboutUsTermsConditionPrivacyPolicyChildren] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicyChildren(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["title"] != nil) { title = AboutUsTermsConditionPrivacyPolicyTitle(dictionary: dictionary["title"] as! NSDictionary) }
        image = dictionary["image"] as? String
        
        children =  dictionary["children"] as? Array<String>
        
        //if (dictionary["children"] != nil) { children = AboutUsTermsConditionPrivacyPolicyChildren.modelsFromDictionaryArray(dictionary["children"] as! NSArray) }
        depth = dictionary["depth"] as? Int
        _id = dictionary["_id"] as? String
    }

    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.title?.dictionaryRepresentation(), forKey: "title")
        dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self.depth, forKey: "depth")
        dictionary.setValue(self._id, forKey: "_id")
        
        return dictionary
    }
    
}
public class AboutUsTermsConditionPrivacyPolicyCategories {
    public var title : AboutUsTermsConditionPrivacyPolicyTitle?
    public var image : String?
    public var children : Array<AboutUsTermsConditionPrivacyPolicyChildren>?
    public var _id : String?
    
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicyCategories]
    {
        var models:[AboutUsTermsConditionPrivacyPolicyCategories] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicyCategories(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["title"] != nil) { title = AboutUsTermsConditionPrivacyPolicyTitle(dictionary: dictionary["title"] as! NSDictionary) }
        image = dictionary["image"] as? String
        
        if (dictionary["children"] != nil) { children = AboutUsTermsConditionPrivacyPolicyChildren.modelsFromDictionaryArray(array: dictionary["children"] as! NSArray) }
        
        _id = dictionary["_id"] as? String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.title?.dictionaryRepresentation(), forKey: "title")
        dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self._id, forKey: "_id")
        
        return dictionary
    }
    
}
public class AboutUsTermsConditionPrivacyPolicyAboutShortDescription {
    public var en : String?
    public var ar : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [AboutUsTermsConditionPrivacyPolicyAboutShortDescription]
    {
        var models:[AboutUsTermsConditionPrivacyPolicyAboutShortDescription] = []
        for item in array
        {
            models.append(AboutUsTermsConditionPrivacyPolicyAboutShortDescription(dictionary: item as! NSDictionary)!)
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
