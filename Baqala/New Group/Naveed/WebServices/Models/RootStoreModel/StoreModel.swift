//
//	Store.swift

import Foundation 
import ObjectMapper


class StoreModel : NSObject, NSCoding, Mappable{

	var id : String?
	var address : String?
	var descriptionField : Title?
	var distance : Float?
	var image : String?
	var location : [Float]?
	var reviewsCount : Int?
	var storeName : Title?
    
    var imageURL: URL? {
        get {
            return URL(string: self.image!)
        }
    }

	class func newInstance(map: Map) -> Mappable?{
		return StoreModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		address <- map["address"]
		descriptionField <- map["description"]
		distance <- map["distance"]
		image <- map["image"]
		location <- map["location"]
		reviewsCount <- map["reviewsCount"]
		storeName <- map["storeName"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         address = aDecoder.decodeObject(forKey: "address") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? Title
         distance = aDecoder.decodeObject(forKey: "distance") as? Float
         image = aDecoder.decodeObject(forKey: "image") as? String
         location = aDecoder.decodeObject(forKey: "location") as? [Float]
         reviewsCount = aDecoder.decodeObject(forKey: "reviewsCount") as? Int
         storeName = aDecoder.decodeObject(forKey: "storeName") as? Title

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
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if distance != nil{
			aCoder.encode(distance, forKey: "distance")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if reviewsCount != nil{
			aCoder.encode(reviewsCount, forKey: "reviewsCount")
		}
		if storeName != nil{
			aCoder.encode(storeName, forKey: "storeName")
		}

	}

}
