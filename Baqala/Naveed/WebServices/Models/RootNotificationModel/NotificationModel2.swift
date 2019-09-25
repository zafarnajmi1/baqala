

import Foundation 
import ObjectMapper


class NotificationModel2 : NSObject, NSCoding, Mappable{

	var id : String?
	var action : String?
	var createdAt : String?
	var descriptionField : Title?
	var extras : ExtraModel?
	var read : Bool?
	var receiver : String?
	var seen : Bool?
	var sender : UserModel?
	var title : Title?
	var updatedAt : String?


	class func newInstance(map: Map) -> Mappable?{
		return NotificationModel2()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		action <- map["action"]
		createdAt <- map["createdAt"]
		descriptionField <- map["description"]
		extras <- map["extras"]
		read <- map["read"]
		receiver <- map["receiver"]
		seen <- map["seen"]
		sender <- map["sender"]
		title <- map["title"]
		updatedAt <- map["updatedAt"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         action = aDecoder.decodeObject(forKey: "action") as? String
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? Title
         extras = aDecoder.decodeObject(forKey: "extras") as? ExtraModel
         read = aDecoder.decodeObject(forKey: "read") as? Bool
         receiver = aDecoder.decodeObject(forKey: "receiver") as? String
         seen = aDecoder.decodeObject(forKey: "seen") as? Bool
         sender = aDecoder.decodeObject(forKey: "sender") as? UserModel
         title = aDecoder.decodeObject(forKey: "title") as? Title
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
		if action != nil{
			aCoder.encode(action, forKey: "action")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if extras != nil{
			aCoder.encode(extras, forKey: "extras")
		}
		if read != nil{
			aCoder.encode(read, forKey: "read")
		}
		if receiver != nil{
			aCoder.encode(receiver, forKey: "receiver")
		}
		if seen != nil{
			aCoder.encode(seen, forKey: "seen")
		}
		if sender != nil{
			aCoder.encode(sender, forKey: "sender")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}

	}

}
