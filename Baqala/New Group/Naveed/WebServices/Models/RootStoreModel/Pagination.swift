//
//	Pagination.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Pagination : NSObject, NSCoding, Mappable{

	var next : Int?
	var page : Int?
	var pages : Int?
	var perPage : Int?
	var previous : Int?
	var total : Int?


	class func newInstance(map: Map) -> Mappable?{
		return Pagination()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		next <- map["next"]
		page <- map["page"]
		pages <- map["pages"]
		perPage <- map["per_page"]
		previous <- map["previous"]
		total <- map["total"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         next = aDecoder.decodeObject(forKey: "next") as? Int
         page = aDecoder.decodeObject(forKey: "page") as? Int
         pages = aDecoder.decodeObject(forKey: "pages") as? Int
         perPage = aDecoder.decodeObject(forKey: "per_page") as? Int
         previous = aDecoder.decodeObject(forKey: "previous") as? Int
         total = aDecoder.decodeObject(forKey: "total") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if next != nil{
			aCoder.encode(next, forKey: "next")
		}
		if page != nil{
			aCoder.encode(page, forKey: "page")
		}
		if pages != nil{
			aCoder.encode(pages, forKey: "pages")
		}
		if perPage != nil{
			aCoder.encode(perPage, forKey: "per_page")
		}
		if previous != nil{
			aCoder.encode(previous, forKey: "previous")
		}
		if total != nil{
			aCoder.encode(total, forKey: "total")
		}

	}

}
