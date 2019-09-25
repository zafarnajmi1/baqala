

import Foundation 
import ObjectMapper


class ExtraModel : NSObject, NSCoding, Mappable{

	var conversation : String?
	var product : String?
    var order : String?

	class func newInstance(map: Map) -> Mappable?{
		return ExtraModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		conversation <- map["conversation"]
		product <- map["product"]
        order <- map["order"]
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         conversation = aDecoder.decodeObject(forKey: "conversation") as? String
         product = aDecoder.decodeObject(forKey: "product") as? String
         order = aDecoder.decodeObject(forKey: "order") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if conversation != nil{
			aCoder.encode(conversation, forKey: "conversation")
		}
		if product != nil{
			aCoder.encode(product, forKey: "product")
		}
        if order != nil{
            aCoder.encode(order, forKey: "order")
        }
	}

}
