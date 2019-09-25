

import Foundation 
import ObjectMapper


class StoreReviewDataModel : NSObject, NSCoding, Mappable{

	var pagination : Pagination?
	var storeReviews : [StoreReviewModel]?


	class func newInstance(map: Map) -> Mappable?{
		return StoreReviewDataModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		pagination <- map["pagination"]
		storeReviews <- map["storeReviews"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         pagination = aDecoder.decodeObject(forKey: "pagination") as? Pagination
         storeReviews = aDecoder.decodeObject(forKey: "storeReviews") as? [StoreReviewModel]

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
		if storeReviews != nil{
			aCoder.encode(storeReviews, forKey: "storeReviews")
		}

	}

}
