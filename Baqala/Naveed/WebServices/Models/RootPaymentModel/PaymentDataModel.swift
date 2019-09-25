
//	PyamentDataModel.swift

import Foundation 
import ObjectMapper


class PaymentDataModel : NSObject, NSCoding, Mappable{

	var v : Int?
	var id : String?
	var createdAt : String?
	var order : String?
	var price : Int?
	var product : String?
	var quantity : Int?
	var status : String?
	var total : Int?
	var updatedAt : String?
	var user : String?


	class func newInstance(map: Map) -> Mappable?{
		return PaymentDataModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		v <- map["__v"]
		id <- map["_id"]
		createdAt <- map["createdAt"]
		order <- map["order"]
		price <- map["price"]
		product <- map["product"]
		quantity <- map["quantity"]
		status <- map["status"]
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
         v = aDecoder.decodeObject(forKey: "__v") as? Int
         id = aDecoder.decodeObject(forKey: "_id") as? String
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         order = aDecoder.decodeObject(forKey: "order") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Int
         product = aDecoder.decodeObject(forKey: "product") as? String
         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? String
         total = aDecoder.decodeObject(forKey: "total") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
         user = aDecoder.decodeObject(forKey: "user") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if v != nil{
			aCoder.encode(v, forKey: "__v")
		}
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if order != nil{
			aCoder.encode(order, forKey: "order")
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
		if status != nil{
			aCoder.encode(status, forKey: "status")
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
