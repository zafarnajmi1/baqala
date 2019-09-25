//
//	Data.swift


import Foundation 
import ObjectMapper


class AddProductToCartDataModel : NSObject, NSCoding, Mappable{

	var id : String?
	var createdAt : String?
	var price : Price?
	var product : String?
	var quantity : Int?
	var total : Price?
	var updatedAt : String?
	var user : String?


	class func newInstance(map: Map) -> Mappable?{
		return AddProductToCartDataModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		createdAt <- map["createdAt"]
		price <- map["price"]
		product <- map["product"]
		quantity <- map["quantity"]
		total <- map["total"]
		updatedAt <- map["updatedAt"]
		user <- map["user"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Price
         product = aDecoder.decodeObject(forKey: "product") as? String
         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
         total = aDecoder.decodeObject(forKey: "total") as? Price
         updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
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
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if product != nil{
			aCoder.encode(product, forKey: "product")
		}
		if quantity != nil{
			aCoder.encode(quantity, forKey: "quantity")
		}
		if total != nil{
			aCoder.encode(total, forKey: "total")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}
