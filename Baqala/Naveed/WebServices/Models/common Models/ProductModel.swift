//
//	Product.swift


import Foundation 
import ObjectMapper


class ProductModel : NSObject, NSCoding, Mappable{

	var id : String?
	var address : String?
	var available : Int?
	var distance : Double?
	var images : [ImageModel]?
	var price : Price?
	var productName : Title?
	var user : UserModel?
    var descriptionField : Title?
    var priceType: PriceType?
    var image : String?
    
    var imageUrl: URL? {
        get{
            return URL(string: image!)
        }
    }
    
    
    
    
    
	class func newInstance(map: Map) -> Mappable?{
		return ProductModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		address <- map["address"]
		available <- map["available"]
		distance <- map["distance"]
		images <- map["images"]
		price <- map["price"]
        priceType <- map["priceType"]
		productName <- map["productName"]
        descriptionField <- map["description"]
		user <- map["user"]
        
		image <- map["image"]
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         address = aDecoder.decodeObject(forKey: "address") as? String
         available = aDecoder.decodeObject(forKey: "available") as? Int
         distance = aDecoder.decodeObject(forKey: "distance") as? Double
         images = aDecoder.decodeObject(forKey: "images") as? [ImageModel]
         price = aDecoder.decodeObject(forKey: "price") as? Price
         priceType = aDecoder.decodeObject(forKey: "priceType") as? PriceType
         productName = aDecoder.decodeObject(forKey: "productName") as? Title
         descriptionField = aDecoder.decodeObject(forKey: "description") as? Title
         user = aDecoder.decodeObject(forKey: "user") as? UserModel
         image = aDecoder.decodeObject(forKey: "image") as? String

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
		if available != nil{
			aCoder.encode(available, forKey: "available")
		}
		if distance != nil{
			aCoder.encode(distance, forKey: "distance")
		}
		if images != nil{
			aCoder.encode(images, forKey: "images")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if productName != nil{
			aCoder.encode(productName, forKey: "productName")
		}
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        
        if priceType != nil{
            aCoder.encode(priceType, forKey: "priceType")
        }
	}

}
