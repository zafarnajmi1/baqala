

import Foundation 
import ObjectMapper


class RootNotificationModel : NSObject, NSCoding, Mappable{

	var data : NotificationDataModel2?
	var errors : Error?
	var message : String?
	var success : Bool?


	class func newInstance(map: Map) -> Mappable?{
		return RootNotificationModel()
	}
	required init?(map: Map){}
	 override init(){}

	func mapping(map: Map)
	{
		data <- map["data"]
		errors <- map["errors"]
		message <- map["message"]
		success <- map["success"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         data = aDecoder.decodeObject(forKey: "data") as? NotificationDataModel2
         errors = aDecoder.decodeObject(forKey: "errors") as? Error
         message = aDecoder.decodeObject(forKey: "message") as? String
         success = aDecoder.decodeObject(forKey: "success") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if errors != nil{
			aCoder.encode(errors, forKey: "errors")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if success != nil{
			aCoder.encode(success, forKey: "success")
		}

	}

}
