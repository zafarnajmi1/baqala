//


import Foundation 
import ObjectMapper


class ConversationDataModel : NSObject, NSCoding, Mappable{

	var conversation : ConversationModelP?
    var conversations: [ConversationModelP]?

	class func newInstance(map: Map) -> Mappable?{
		return ConversationModelP()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		conversation <- map["conversation"]
		conversations <- map["conversations"]
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         conversation = aDecoder.decodeObject(forKey: "conversation") as? ConversationModelP
        conversations = aDecoder.decodeObject(forKey: "conversations") as? [ConversationModelP]
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if conversation != nil{
			aCoder.encode(conversation, forKey: "conversation")
		}
        if conversations != nil{
            aCoder.encode(conversations, forKey: "conversation")
        }
	}

}
