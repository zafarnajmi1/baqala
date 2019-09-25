//
//	User.swift


import Foundation 
import ObjectMapper


class UserModel : NSObject, NSCoding, Mappable{

	var id : String?
    var address : String?
	var averageRating : Int?
	var distance : Int?
	var reviewsCount : Int?
	var storeName : Title?


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
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
           address = aDecoder.decodeObject(forKey: "address") as? String
         averageRating = aDecoder.decodeObject(forKey: "averageRating") as? Int
         distance = aDecoder.decodeObject(forKey: "distance") as? Int
         reviewsCount = aDecoder.decodeObject(forKey: "reviewsCount") as? Int
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
		if distance != nil{
			aCoder.encode(distance, forKey: "distance")
		}
		if reviewsCount != nil{
			aCoder.encode(reviewsCount, forKey: "reviewsCount")
		}
		if storeName != nil{
			aCoder.encode(storeName, forKey: "storeName")
		}

	}

}
