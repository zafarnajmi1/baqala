

import Foundation 
import ObjectMapper


class CanReviewUserModel : NSObject, NSCoding, Mappable{

	var id : String?
	var order : String?
	var product : ProductModel?
	var store : String?
	var user : String?


	class func newInstance(map: Map) -> Mappable?{
		return CanReviewUserModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		order <- map["order"]
		product <- map["product"]
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
         order = aDecoder.decodeObject(forKey: "order") as? String
         product = aDecoder.decodeObject(forKey: "product") as? ProductModel
         store = aDecoder.decodeObject(forKey: "store") as? String
         user = aDecoder.decodeObject(forKey: "user") as? String

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
		if order != nil{
			aCoder.encode(order, forKey: "order")
		}
		if product != nil{
			aCoder.encode(product, forKey: "product")
		}
		if store != nil{
			aCoder.encode(store, forKey: "store")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}
