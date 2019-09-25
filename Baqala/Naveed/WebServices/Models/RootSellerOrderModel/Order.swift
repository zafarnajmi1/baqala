//
//	Order.swift

import Foundation 
import ObjectMapper


class Order : NSObject, NSCoding, Mappable{

	var id : String?
    var orderNumber: String?
	var addresses : [AddressModel]?
	var user : UserModel?


	class func newInstance(map: Map) -> Mappable?{
		return Order()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		addresses <- map["addresses"]
		user <- map["user"]
		orderNumber <- map["orderNumber"]
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         orderNumber = aDecoder.decodeObject(forKey: "orderNumber") as? String
         addresses = aDecoder.decodeObject(forKey: "addresses") as? [AddressModel]
         user = aDecoder.decodeObject(forKey: "user") as? UserModel

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "orderNumber")
		}
        if orderNumber != nil{
            aCoder.encode(id, forKey: "_id")
        }
		if addresses != nil{
			aCoder.encode(addresses, forKey: "addresses")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}
