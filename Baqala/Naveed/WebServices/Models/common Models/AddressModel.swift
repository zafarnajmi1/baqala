//
//	AddressModel.swift


import Foundation 
import ObjectMapper


class AddressModel : NSObject, NSCoding, Mappable{

	var id : String?
	var address1 : String?
	var address2 : String?
	var address3 : String?
	var addressType : String?
	var email : String?
	var firstName : String?
	var lastName : String?
	var phone : String?
	var postCode : String?


	class func newInstance(map: Map) -> Mappable?{
		return AddressModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		address1 <- map["address1"]
		address2 <- map["address2"]
		address3 <- map["address3"]
		addressType <- map["addressType"]
		email <- map["email"]
		firstName <- map["firstName"]
		lastName <- map["lastName"]
		phone <- map["phone"]
		postCode <- map["postCode"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         address1 = aDecoder.decodeObject(forKey: "address1") as? String
         address2 = aDecoder.decodeObject(forKey: "address2") as? String
         address3 = aDecoder.decodeObject(forKey: "address3") as? String
         addressType = aDecoder.decodeObject(forKey: "addressType") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstName = aDecoder.decodeObject(forKey: "firstName") as? String
         lastName = aDecoder.decodeObject(forKey: "lastName") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         postCode = aDecoder.decodeObject(forKey: "postCode") as? String

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
		if address1 != nil{
			aCoder.encode(address1, forKey: "address1")
		}
		if address2 != nil{
			aCoder.encode(address2, forKey: "address2")
		}
		if address3 != nil{
			aCoder.encode(address3, forKey: "address3")
		}
		if addressType != nil{
			aCoder.encode(addressType, forKey: "addressType")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "firstName")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "lastName")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
		if postCode != nil{
			aCoder.encode(postCode, forKey: "postCode")
		}

	}

}
