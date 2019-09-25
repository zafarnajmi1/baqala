//

import Foundation 
import ObjectMapper


class SettingDataModel : NSObject, NSCoding, Mappable{

	var categories : [SettingCategoryModel]?
	var pages : [Page]?
	var priceTypes : [PriceType]?
	var settings : Setting?
	var sliders : [Slider]?


	class func newInstance(map: Map) -> Mappable?{
		return SettingDataModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		categories <- map["categories"]
		pages <- map["pages"]
		priceTypes <- map["priceTypes"]
		settings <- map["settings"]
		sliders <- map["sliders"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         categories = aDecoder.decodeObject(forKey: "categories") as? [SettingCategoryModel]
         pages = aDecoder.decodeObject(forKey: "pages") as? [Page]
         priceTypes = aDecoder.decodeObject(forKey: "priceTypes") as? [PriceType]
         settings = aDecoder.decodeObject(forKey: "settings") as? Setting
         sliders = aDecoder.decodeObject(forKey: "sliders") as? [Slider]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if categories != nil{
			aCoder.encode(categories, forKey: "categories")
		}
		if pages != nil{
			aCoder.encode(pages, forKey: "pages")
		}
		if priceTypes != nil{
			aCoder.encode(priceTypes, forKey: "priceTypes")
		}
		if settings != nil{
			aCoder.encode(settings, forKey: "settings")
		}
		if sliders != nil{
			aCoder.encode(sliders, forKey: "sliders")
		}

	}

}
