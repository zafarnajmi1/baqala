

import Foundation
import ObjectMapper

struct NotificationSender : Mappable {
	var _id : String?
	var image : String?
	var fullName : String?
	var createdAt : String?
	var updatedAt : String?
	var parkingEnd : NotificationParkingEnd?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		_id <- map["_id"]
		image <- map["image"]
		fullName <- map["fullName"]
		createdAt <- map["createdAt"]
		updatedAt <- map["updatedAt"]
		parkingEnd <- map["parkingEnd"]
	}

}
