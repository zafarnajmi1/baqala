//
//	Price.swift


import Foundation 
import ObjectMapper


class Price : NSObject, NSCoding, Mappable{

	var aed : Double?
	var usd : Double?


	class func newInstance(map: Map) -> Mappable?{
		return Price()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		aed <- map["aed"]
		usd <- map["usd"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         aed = aDecoder.decodeObject(forKey: "aed") as? Double
         usd = aDecoder.decodeObject(forKey: "usd") as? Double

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if aed != nil{
			aCoder.encode(aed, forKey: "aed")
		}
		if usd != nil{
			aCoder.encode(usd, forKey: "usd")
		}

	}

}
