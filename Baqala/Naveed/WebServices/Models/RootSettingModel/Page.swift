
import Foundation 
import ObjectMapper


class Page : NSObject, NSCoding, Mappable{

	var id : String?
	var detail : Title?
	var icon : String?
	var image : String?
	var title : Title?


	class func newInstance(map: Map) -> Mappable?{
		return Page()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		detail <- map["detail"]
		icon <- map["icon"]
		image <- map["image"]
		title <- map["title"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         detail = aDecoder.decodeObject(forKey: "detail") as? Title
         icon = aDecoder.decodeObject(forKey: "icon") as? String
         image = aDecoder.decodeObject(forKey: "image") as? String
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
		if detail != nil{
			aCoder.encode(detail, forKey: "detail")
		}
		if icon != nil{
			aCoder.encode(icon, forKey: "icon")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}
