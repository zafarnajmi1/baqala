//
//	Error.swift


import Foundation 
import ObjectMapper


class Error : NSObject, NSCoding, Mappable{



	class func newInstance(map: Map) -> Mappable?{
		return Error()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{

	}

}
