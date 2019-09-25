//
//	Slider.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Slider : NSObject, NSCoding, Mappable{

	var id : String?
	var detail : Title?
	var image : String?
	var title : Title?


	class func newInstance(map: Map) -> Mappable?{
		return Slider()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		detail <- map["detail"]
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
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}