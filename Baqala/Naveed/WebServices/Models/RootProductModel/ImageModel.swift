//
//	Image.swift


import Foundation 
import ObjectMapper

class ImageModel : NSObject, NSCoding, Mappable{
    
    var id : String?
	var path : String?
    var isDefault : Bool?
   
    var imageUrl: URL? {
        get{
            return URL(string: path!)
        }
    }

	class func newInstance(map: Map) -> Mappable?{
		return ImageModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
        id <- map["_id"]
        isDefault <- map["isDefault"]
        path <- map["path"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        id = aDecoder.decodeObject(forKey: "_id") as? String
        isDefault = aDecoder.decodeObject(forKey: "isDefault") as? Bool
        path = aDecoder.decodeObject(forKey: "path") as? String
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
        if isDefault != nil{
            aCoder.encode(isDefault, forKey: "isDefault")
        }
        if path != nil{
            aCoder.encode(path, forKey: "path")
        }
        
    }

}
