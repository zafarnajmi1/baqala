

import Foundation 
import ObjectMapper


class StoreReviewModel : NSObject, NSCoding, Mappable{

	var id : String?
	var comment : String?
	var createdAt : String?
	var product : ProductModel?
	var rating : Float?
	var store : StoreModel?
	var user : UserModel?


	class func newInstance(map: Map) -> Mappable?{
		return StoreReviewModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		comment <- map["comment"]
		createdAt <- map["createdAt"]
		product <- map["product"]
		rating <- map["rating"]
		store <- map["store"]
		user <- map["user"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         comment = aDecoder.decodeObject(forKey: "comment") as? String
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         product = aDecoder.decodeObject(forKey: "product") as? ProductModel
         rating = aDecoder.decodeObject(forKey: "rating") as? Float
         store = aDecoder.decodeObject(forKey: "store") as? StoreModel
         user = aDecoder.decodeObject(forKey: "user") as? UserModel

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
		if comment != nil{
			aCoder.encode(comment, forKey: "comment")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if product != nil{
			aCoder.encode(product, forKey: "product")
		}
		if rating != nil{
			aCoder.encode(rating, forKey: "rating")
		}
		if store != nil{
			aCoder.encode(store, forKey: "store")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}
