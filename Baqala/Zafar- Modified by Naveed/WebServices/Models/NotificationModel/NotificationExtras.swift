

import Foundation
import ObjectMapper

struct NotificationExtras : Mappable {
	var conversation : String?
    var order : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		conversation <- map["conversation"]
        conversation <- map["order"]
	}

}
