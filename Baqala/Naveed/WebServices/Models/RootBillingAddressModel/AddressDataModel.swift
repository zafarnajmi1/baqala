//
//	AddressModel.swift


import Foundation 
import ObjectMapper

class AddressDataModel : NSObject, NSCoding, Mappable{

	var id : String?
	var accountType : String?
	var address : String?
	var addresses : [AddressModel]?
	var authorization : String?
	var averageRating : Int?
	var canReviewUsers : [AnyObject]?
	var createdAt : String?
	var descriptionField : Title?
	var email : String?
	var firstName : String?
	var gender : String?
	var image : String?
	var isActive : Bool?
	var isCartProcessing : Bool?
	var isEmailVerified : Bool?
	var lastName : String?
	var location : [Float]?
	var paypalClientId : String?
	var paypalSecretId : String?
	var phone : String?
	var products : [AnyObject]?
	var reviews : [AnyObject]?
	var role : Role?
	var storeName : Title?
	var updatedAt : String?
	var userType : String?
	var verificationCode : String?


	class func newInstance(map: Map) -> Mappable?{
		return AddressDataModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		accountType <- map["accountType"]
		address <- map["address"]
		addresses <- map["addresses"]
		authorization <- map["authorization"]
		averageRating <- map["averageRating"]
		canReviewUsers <- map["canReviewUsers"]
		createdAt <- map["createdAt"]
		descriptionField <- map["description"]
		email <- map["email"]
		firstName <- map["firstName"]
		gender <- map["gender"]
		image <- map["image"]
		isActive <- map["isActive"]
		isCartProcessing <- map["isCartProcessing"]
		isEmailVerified <- map["isEmailVerified"]
		lastName <- map["lastName"]
		location <- map["location"]
		paypalClientId <- map["paypalClientId"]
		paypalSecretId <- map["paypalSecretId"]
		phone <- map["phone"]
		products <- map["products"]
		reviews <- map["reviews"]
		role <- map["role"]
		storeName <- map["storeName"]
		updatedAt <- map["updatedAt"]
		userType <- map["userType"]
		verificationCode <- map["verificationCode"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         accountType = aDecoder.decodeObject(forKey: "accountType") as? String
         address = aDecoder.decodeObject(forKey: "address") as? String
         addresses = aDecoder.decodeObject(forKey: "addresses") as? [AddressModel]
         authorization = aDecoder.decodeObject(forKey: "authorization") as? String
         averageRating = aDecoder.decodeObject(forKey: "averageRating") as? Int
         canReviewUsers = aDecoder.decodeObject(forKey: "canReviewUsers") as? [AnyObject]
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? Title
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstName = aDecoder.decodeObject(forKey: "firstName") as? String
         gender = aDecoder.decodeObject(forKey: "gender") as? String
         image = aDecoder.decodeObject(forKey: "image") as? String
         isActive = aDecoder.decodeObject(forKey: "isActive") as? Bool
         isCartProcessing = aDecoder.decodeObject(forKey: "isCartProcessing") as? Bool
         isEmailVerified = aDecoder.decodeObject(forKey: "isEmailVerified") as? Bool
         lastName = aDecoder.decodeObject(forKey: "lastName") as? String
         location = aDecoder.decodeObject(forKey: "location") as? [Float]
         paypalClientId = aDecoder.decodeObject(forKey: "paypalClientId") as? String
         paypalSecretId = aDecoder.decodeObject(forKey: "paypalSecretId") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         products = aDecoder.decodeObject(forKey: "products") as? [AnyObject]
         reviews = aDecoder.decodeObject(forKey: "reviews") as? [AnyObject]
         role = aDecoder.decodeObject(forKey: "role") as? Role
         storeName = aDecoder.decodeObject(forKey: "storeName") as? Title
         updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
         userType = aDecoder.decodeObject(forKey: "userType") as? String
         verificationCode = aDecoder.decodeObject(forKey: "verificationCode") as? String

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
		if accountType != nil{
			aCoder.encode(accountType, forKey: "accountType")
		}
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if addresses != nil{
			aCoder.encode(addresses, forKey: "addresses")
		}
		if authorization != nil{
			aCoder.encode(authorization, forKey: "authorization")
		}
		if averageRating != nil{
			aCoder.encode(averageRating, forKey: "averageRating")
		}
		if canReviewUsers != nil{
			aCoder.encode(canReviewUsers, forKey: "canReviewUsers")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "firstName")
		}
		if gender != nil{
			aCoder.encode(gender, forKey: "gender")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if isActive != nil{
			aCoder.encode(isActive, forKey: "isActive")
		}
		if isCartProcessing != nil{
			aCoder.encode(isCartProcessing, forKey: "isCartProcessing")
		}
		if isEmailVerified != nil{
			aCoder.encode(isEmailVerified, forKey: "isEmailVerified")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "lastName")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if paypalClientId != nil{
			aCoder.encode(paypalClientId, forKey: "paypalClientId")
		}
		if paypalSecretId != nil{
			aCoder.encode(paypalSecretId, forKey: "paypalSecretId")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
		if products != nil{
			aCoder.encode(products, forKey: "products")
		}
		if reviews != nil{
			aCoder.encode(reviews, forKey: "reviews")
		}
		if role != nil{
			aCoder.encode(role, forKey: "role")
		}
		if storeName != nil{
			aCoder.encode(storeName, forKey: "storeName")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}
		if userType != nil{
			aCoder.encode(userType, forKey: "userType")
		}
		if verificationCode != nil{
			aCoder.encode(verificationCode, forKey: "verificationCode")
		}

	}

}
