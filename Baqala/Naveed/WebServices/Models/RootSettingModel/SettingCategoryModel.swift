//
//	SettingCategoryModel.swift

import Foundation 
import ObjectMapper


class SettingCategoryModel : NSObject, NSCoding, Mappable{

	var id : String?
	var children : [AnyObject]?
	var image : String?
	var title : Title?


	class func newInstance(map: Map) -> Mappable?{
		return SettingCategoryModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		children <- map["children"]
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
         children = aDecoder.decodeObject(forKey: "children") as? [AnyObject]
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
		if children != nil{
			aCoder.encode(children, forKey: "children")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}
