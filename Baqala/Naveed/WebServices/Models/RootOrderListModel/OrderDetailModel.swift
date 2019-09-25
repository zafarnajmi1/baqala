//
//	OrderDetailModel.swift


import Foundation 
import ObjectMapper

class OrderDetailModel : NSObject, NSCoding, Mappable{

	var id : String?
	var createdAt : String?
	var order : String?
	var price : Price?
	var product : ProductModel?
	var quantity : Int?
	var status : String?
	var total : Price?
	var updatedAt : String?
	var user : UserModel?


	class func newInstance(map: Map) -> Mappable?{
		return OrderDetailModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
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
         id = aDecoder.decodeObject(forKey: "_id") as? String
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         order = aDecoder.decodeObject(forKey: "order") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Price
         product = aDecoder.decodeObject(forKey: "product") as? ProductModel
         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? String
         total = aDecoder.decodeObject(forKey: "total") as? Price
         updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
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
