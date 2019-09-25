
import Foundation 
import ObjectMapper


class NotificationDataModel2 : NSObject, NSCoding, Mappable{

	var notifications : [NotificationModel2]?
	var pagination : Pagination?
	var unseenNotificationsCount : Int?


	class func newInstance(map: Map) -> Mappable?{
		return NotificationDataModel2()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		notifications <- map["notifications"]
		pagination <- map["pagination"]
		unseenNotificationsCount <- map["unseenNotificationsCount"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         notifications = aDecoder.decodeObject(forKey: "notifications") as? [NotificationModel2]
         pagination = aDecoder.decodeObject(forKey: "pagination") as? Pagination
         unseenNotificationsCount = aDecoder.decodeObject(forKey: "unseenNotificationsCount") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if notifications != nil{
			aCoder.encode(notifications, forKey: "notifications")
		}
		if pagination != nil{
			aCoder.encode(pagination, forKey: "pagination")
		}
		if unseenNotificationsCount != nil{
			aCoder.encode(unseenNotificationsCount, forKey: "unseenNotificationsCount")
		}

	}

}
