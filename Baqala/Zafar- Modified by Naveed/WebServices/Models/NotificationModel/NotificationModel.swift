


import Foundation
import ObjectMapper

struct NotificationModel : Mappable {
	var _id : String?
	var title : NotificationTitle?
	var description : NotificationDescription?
	var action : String?
	var seen : Bool?
	var read : Bool?
	var sender : NotificationSender?
	var extras : NotificationExtras?
	var createdAt : String?
    var store: StoreNotificaton?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		_id <- map["_id"]
		title <- map["title"]
		description <- map["description"]
		action <- map["action"]
		seen <- map["seen"]
		read <- map["read"]
		sender <- map["sender"]
		extras <- map["extras"]
		createdAt <- map["createdAt"]
		store <- map["store"]
	}

}


struct StoreNotificaton: Mappable{
    var _id : String?
    var createdAt : String?
    var image : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        _id <- map["_id"]
        image <- map["image"]
        createdAt <- map["createdAt"]
    }
}

