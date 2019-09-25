//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper

class StoreDataModel : NSObject, NSCoding, Mappable{

	var pagination : Pagination?
	var stores : [StoreModel]?


	class func newInstance(map: Map) -> Mappable?{
		return StoreDataModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		pagination <- map["pagination"]
		stores <- map["stores"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         pagination = aDecoder.decodeObject(forKey: "pagination") as? Pagination
         stores = aDecoder.decodeObject(forKey: "stores") as? [StoreModel]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if pagination != nil{
			aCoder.encode(pagination, forKey: "pagination")
		}
		if stores != nil{
			aCoder.encode(stores, forKey: "stores")
		}

	}

}
