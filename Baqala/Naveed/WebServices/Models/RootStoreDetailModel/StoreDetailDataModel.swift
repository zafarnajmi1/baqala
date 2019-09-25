

import Foundation 
import ObjectMapper


class StoreDetailDataModel : NSObject, NSCoding, Mappable{

	var id : String?
	var address : String?
	var averageRating : Float?
	var canReviewUsers : [CanReviewUserModel]?
	var descriptionField : Title?
	var distance : Double?
	var image : String?
	var isActive : Bool?
	var location : [Float]?
	var reviews : [StoreReviewModel]?
	var storeName : Title?


	class func newInstance(map: Map) -> Mappable?{
		return StoreDetailDataModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		address <- map["address"]
		averageRating <- map["averageRating"]
		canReviewUsers <- map["canReviewUsers"]
		descriptionField <- map["description"]
		distance <- map["distance"]
		image <- map["image"]
		isActive <- map["isActive"]
		location <- map["location"]
		reviews <- map["reviews"]
		storeName <- map["storeName"]
		
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
         canReviewUsers = aDecoder.decodeObject(forKey: "canReviewUsers") as? [CanReviewUserModel]
         descriptionField = aDecoder.decodeObject(forKey: "description") as? Title
         distance = aDecoder.decodeObject(forKey: "distance") as? Double
         image = aDecoder.decodeObject(forKey: "image") as? String
         isActive = aDecoder.decodeObject(forKey: "isActive") as? Bool
         location = aDecoder.decodeObject(forKey: "location") as? [Float]
         reviews = aDecoder.decodeObject(forKey: "reviews") as? [StoreReviewModel]
         storeName = aDecoder.decodeObject(forKey: "storeName") as? Title

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
		if canReviewUsers != nil{
			aCoder.encode(canReviewUsers, forKey: "canReviewUsers")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if distance != nil{
			aCoder.encode(distance, forKey: "distance")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if isActive != nil{
			aCoder.encode(isActive, forKey: "isActive")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if reviews != nil{
			aCoder.encode(reviews, forKey: "reviews")
		}
		if storeName != nil{
			aCoder.encode(storeName, forKey: "storeName")
		}

	}

}
