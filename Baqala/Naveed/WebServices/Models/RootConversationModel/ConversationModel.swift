

import Foundation 
import ObjectMapper


class ConversationModelP : NSObject, NSCoding, Mappable{

	var id : String?
	var createdAt : String?
	var lastMessage : LastMessageModel?
	var product : ProductModel?
	var store : StoreModel?
	var updatedAt : String?
	var user : UserModel?


	class func newInstance(map: Map) -> Mappable?{
		return ConversationModelP()
	}
	required init?(map: Map){}
	 override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		createdAt <- map["createdAt"]
		lastMessage <- map["lastMessage"]
		product <- map["product"]
		store <- map["store"]
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
         lastMessage = aDecoder.decodeObject(forKey: "lastMessage") as? LastMessageModel
         product = aDecoder.decodeObject(forKey: "product") as? ProductModel
         store = aDecoder.decodeObject(forKey: "store") as? StoreModel
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
		if lastMessage != nil{
			aCoder.encode(lastMessage, forKey: "lastMessage")
		}
		if product != nil{
			aCoder.encode(product, forKey: "product")
		}
		if store != nil{
			aCoder.encode(store, forKey: "store")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}
