

import Foundation 
import ObjectMapper


class PriceType : NSObject, NSCoding, Mappable{

	var id : String?
	var title : Title?


	class func newInstance(map: Map) -> Mappable?{
		return PriceType()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		title <- map["title"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         title = aDecoder.decodeObject(forKey: "title") as? Title

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
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}
