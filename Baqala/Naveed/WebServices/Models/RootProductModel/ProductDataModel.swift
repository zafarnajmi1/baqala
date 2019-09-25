//
//	ProductModel.swift


import Foundation 
import ObjectMapper

class ProductDataModel : NSObject, NSCoding, Mappable{

	var products : [ProductModel]?


	class func newInstance(map: Map) -> Mappable?{
		return ProductDataModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		products <- map["products"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         products = aDecoder.decodeObject(forKey: "products") as? [ProductModel]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if products != nil{
			aCoder.encode(products, forKey: "products")
		}

	}

}
