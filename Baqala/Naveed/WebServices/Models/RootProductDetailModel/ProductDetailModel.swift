//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper

class ProductDetailModel : NSObject, NSCoding, Mappable{

	var id : String?
	var address : String?
	var available : Int?
	var categories : [Category]?
	var descriptionField : Title?
	var images : [ImageModel]?
	var price : Price?
	var productName : Title?
	var user : UserModel?


	class func newInstance(map: Map) -> Mappable?{
		return ProductDetailModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		address <- map["address"]
		available <- map["available"]
		categories <- map["categories"]
		descriptionField <- map["description"]
		images <- map["images"]
		price <- map["price"]
		productName <- map["productName"]
		user <- map["user"]
		
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
         categories = aDecoder.decodeObject(forKey: "categories") as? [Category]
         descriptionField = aDecoder.decodeObject(forKey: "description") as? Title
         images = aDecoder.decodeObject(forKey: "images") as? [ImageModel]
         price = aDecoder.decodeObject(forKey: "price") as? Price
         productName = aDecoder.decodeObject(forKey: "productName") as? Title
         user = aDecoder.decodeObject(forKey: "user") as? UserModel

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
		if categories != nil{
			aCoder.encode(categories, forKey: "categories")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
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
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}
