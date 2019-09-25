

import Foundation
import ObjectMapper

class NotificationRootModel : Mappable {
    
	var success : Bool?
	var message : String?
	var data : NotificationDataModel?

	init?() {

	}
    
    required init(map: Map) {
        
    }

	 func mapping(map: Map) {
        
		success <- map["success"]
		message <- map["message"]
		data <- map["data"]
	}

}
