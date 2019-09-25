//
//	Setting.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Setting : NSObject, NSCoding, Mappable{

	var id : String?
	var aboutShortDescription : Title?
	var contactEmail : String?
	var contactNumber : String?
	var createdAt : String?
	var emailFrom : String?
	var emailSenderName : String?
	var facebook : String?
	var footerImage : String?
	var instagram : String?
	var latitude : String?
	var linkedin : String?
	var location : String?
	var longitude : String?
	var maxPrice : Int?
	var minPrice : Int?
	var twitter : String?
	var updatedAt : String?
	var vatPercentage : Int?
	var webUrl : String?


	class func newInstance(map: Map) -> Mappable?{
		return Setting()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		aboutShortDescription <- map["aboutShortDescription"]
		contactEmail <- map["contactEmail"]
		contactNumber <- map["contactNumber"]
		createdAt <- map["createdAt"]
		emailFrom <- map["emailFrom"]
		emailSenderName <- map["emailSenderName"]
		facebook <- map["facebook"]
		footerImage <- map["footerImage"]
		instagram <- map["instagram"]
		latitude <- map["latitude"]
		linkedin <- map["linkedin"]
		location <- map["location"]
		longitude <- map["longitude"]
		maxPrice <- map["maxPrice"]
		minPrice <- map["minPrice"]
		twitter <- map["twitter"]
		updatedAt <- map["updatedAt"]
		vatPercentage <- map["vatPercentage"]
		webUrl <- map["webUrl"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         aboutShortDescription = aDecoder.decodeObject(forKey: "aboutShortDescription") as? Title
         contactEmail = aDecoder.decodeObject(forKey: "contactEmail") as? String
         contactNumber = aDecoder.decodeObject(forKey: "contactNumber") as? String
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         emailFrom = aDecoder.decodeObject(forKey: "emailFrom") as? String
         emailSenderName = aDecoder.decodeObject(forKey: "emailSenderName") as? String
         facebook = aDecoder.decodeObject(forKey: "facebook") as? String
         footerImage = aDecoder.decodeObject(forKey: "footerImage") as? String
         instagram = aDecoder.decodeObject(forKey: "instagram") as? String
         latitude = aDecoder.decodeObject(forKey: "latitude") as? String
         linkedin = aDecoder.decodeObject(forKey: "linkedin") as? String
         location = aDecoder.decodeObject(forKey: "location") as? String
         longitude = aDecoder.decodeObject(forKey: "longitude") as? String
         maxPrice = aDecoder.decodeObject(forKey: "maxPrice") as? Int
         minPrice = aDecoder.decodeObject(forKey: "minPrice") as? Int
         twitter = aDecoder.decodeObject(forKey: "twitter") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
         vatPercentage = aDecoder.decodeObject(forKey: "vatPercentage") as? Int
         webUrl = aDecoder.decodeObject(forKey: "webUrl") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if aboutShortDescription != nil{
			aCoder.encode(aboutShortDescription, forKey: "aboutShortDescription")
		}
		if contactEmail != nil{
			aCoder.encode(contactEmail, forKey: "contactEmail")
		}
		if contactNumber != nil{
			aCoder.encode(contactNumber, forKey: "contactNumber")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if emailFrom != nil{
			aCoder.encode(emailFrom, forKey: "emailFrom")
		}
		if emailSenderName != nil{
			aCoder.encode(emailSenderName, forKey: "emailSenderName")
		}
		if facebook != nil{
			aCoder.encode(facebook, forKey: "facebook")
		}
		if footerImage != nil{
			aCoder.encode(footerImage, forKey: "footerImage")
		}
		if instagram != nil{
			aCoder.encode(instagram, forKey: "instagram")
		}
		if latitude != nil{
			aCoder.encode(latitude, forKey: "latitude")
		}
		if linkedin != nil{
			aCoder.encode(linkedin, forKey: "linkedin")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if longitude != nil{
			aCoder.encode(longitude, forKey: "longitude")
		}
		if maxPrice != nil{
			aCoder.encode(maxPrice, forKey: "maxPrice")
		}
		if minPrice != nil{
			aCoder.encode(minPrice, forKey: "minPrice")
		}
		if twitter != nil{
			aCoder.encode(twitter, forKey: "twitter")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}
		if vatPercentage != nil{
			aCoder.encode(vatPercentage, forKey: "vatPercentage")
		}
		if webUrl != nil{
			aCoder.encode(webUrl, forKey: "webUrl")
		}

	}

}