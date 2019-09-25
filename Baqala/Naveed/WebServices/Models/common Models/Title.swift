//
//	Title.swift


import Foundation 
import ObjectMapper


class Title : NSObject, NSCoding, Mappable{

	var ar : String?
	var en : String?


	class func newInstance(map: Map) -> Mappable?{
		return Title()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		ar <- map["ar"]
		en <- map["en"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         ar = aDecoder.decodeObject(forKey: "ar") as? String
         en = aDecoder.decodeObject(forKey: "en") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if ar != nil{
			aCoder.encode(ar, forKey: "ar")
		}
		if en != nil{
			aCoder.encode(en, forKey: "en")
		}

	}

}
