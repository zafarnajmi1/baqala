//
//	User.swift


import Foundation 
import ObjectMapper


class UserModel : NSObject, NSCoding, Mappable{

    //api attributes
	var id : String?
    var address : String?
	var averageRating : Float?
	var distance : Double?
	var reviewsCount : Int?
	var storeName : Title?
    var priceType: PriceType?
  
    var email : String?
    var gender : String?
    var image : String?
    var phone : String?
    var firstName: String?
    var lastName: String?

    //local attributes
    var imageUrl: URL? {
        get{
            return URL(string: image!)
        }
    }
    
    
    

	class func newInstance(map: Map) -> Mappable?{
		return UserModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
        address <- map["address"]
		averageRating <- map["averageRating"]
		distance <- map["distance"]
		reviewsCount <- map["reviewsCount"]
		storeName <- map["storeName"]
        priceType <- map["priceType"]
        email <- map["email"]
        gender <- map["gender"]
        image <- map["image"]
        phone <- map["phone"]
		
        firstName <- map["firstName"]
        lastName <- map["lastName"]
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
        address = aDecoder.decodeObject(forKey: "address") as? String
         averageRating = aDecoder.decodeObject(forKey: "averageRating") as? Float
         distance = aDecoder.decodeObject(forKey: "distance") as? Double
         reviewsCount = aDecoder.decodeObject(forKey: "reviewsCount") as? Int
         storeName = aDecoder.decodeObject(forKey: "storeName") as? Title
         priceType = aDecoder.decodeObject(forKey: "priceType") as? PriceType
         email = aDecoder.decodeObject(forKey: "email") as? String
         gender = aDecoder.decodeObject(forKey: "gender") as? String
         image = aDecoder.decodeObject(forKey: "image") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
        
        firstName = aDecoder.decodeObject(forKey: "firstName") as? String
        lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        
       

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
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
		if averageRating != nil{
			aCoder.encode(averageRating, forKey: "averageRating")
		}
		if distance != nil{
			aCoder.encode(distance, forKey: "distance")
		}
		if reviewsCount != nil{
			aCoder.encode(reviewsCount, forKey: "reviewsCount")
		}
		if storeName != nil{
			aCoder.encode(storeName, forKey: "storeName")
		}
        
        if priceType != nil{
            aCoder.encode(priceType, forKey: "priceType")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if gender != nil{
            aCoder.encode(gender, forKey: "gender")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }

        if firstName != nil{
            aCoder.encode(image, forKey: "firstName")
        }
        if lastName != nil{
            aCoder.encode(phone, forKey: "lastName")
        }
	}

}
