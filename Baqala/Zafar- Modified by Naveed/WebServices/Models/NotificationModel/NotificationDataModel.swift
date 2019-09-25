
import Foundation
import ObjectMapper

struct NotificationDataModel : Mappable {
	var notifications : [NotificationModel]?
    var unseenNotificationsCount: Int?
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		notifications <- map["notifications"]
        unseenNotificationsCount <- map["unseenNotificationsCount"]
	}

}
