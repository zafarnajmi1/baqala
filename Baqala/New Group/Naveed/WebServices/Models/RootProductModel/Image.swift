//
//	Image.swift


import Foundation 
import ObjectMapper


class Image : NSObject, NSCoding, Mappable{

	var path : String?
    var imageUrl: URL? {
        get{
            return URL(string: path!)
        }
    }

	class func newInstance(map: Map) -> Mappable?{
		return Image()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		path <- map["path"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         path = aDecoder.decodeObject(forKey: "path") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if path != nil{
			aCoder.encode(path, forKey: "path")
		}

	}

}
