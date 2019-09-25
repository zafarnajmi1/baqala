//
//	Data.swift

import Foundation 
import ObjectMapper

class CategoryModel : NSObject, NSCoding, Mappable{

	var id : String?
	var imagePath : String?
	var title : Title?
    
    var imageUrl: URL? {
        get{
            return URL(string: imagePath!)
        }
    }


	class func newInstance(map: Map) -> Mappable?{
		return CategoryModel()
	}
	required init?(map: Map){}
    override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		imagePath <- map["image"]
		title <- map["title"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         imagePath = aDecoder.decodeObject(forKey: "image") as? String
         title = aDecoder.decodeObject(forKey: "title") as? Title

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
		if imagePath != nil{
			aCoder.encode(imagePath, forKey: "image")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}
