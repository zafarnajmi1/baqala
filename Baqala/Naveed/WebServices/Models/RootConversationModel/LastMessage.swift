

import Foundation 
import ObjectMapper


class LastMessageModel : NSObject, NSCoding, Mappable{

	var id : String?
	var content : String?
	var conversation : String?
	var createdAt : String?
	var mimeType : String?
	var sender : String?
	var updatedAt : String?


	class func newInstance(map: Map) -> Mappable?{
		return LastMessageModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		content <- map["content"]
		conversation <- map["conversation"]
		createdAt <- map["createdAt"]
		mimeType <- map["mimeType"]
		sender <- map["sender"]
		updatedAt <- map["updatedAt"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         content = aDecoder.decodeObject(forKey: "content") as? String
         conversation = aDecoder.decodeObject(forKey: "conversation") as? String
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         mimeType = aDecoder.decodeObject(forKey: "mimeType") as? String
         sender = aDecoder.decodeObject(forKey: "sender") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String

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
		if content != nil{
			aCoder.encode(content, forKey: "content")
		}
		if conversation != nil{
			aCoder.encode(conversation, forKey: "conversation")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if mimeType != nil{
			aCoder.encode(mimeType, forKey: "mimeType")
		}
		if sender != nil{
			aCoder.encode(sender, forKey: "sender")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}

	}

}
