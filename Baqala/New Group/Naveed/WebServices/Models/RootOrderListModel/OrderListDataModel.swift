//
//	OrderListDataModel.swift

import Foundation 
import ObjectMapper


class OrderListDataModel : NSObject, NSCoding, Mappable{

	var id : String?
	var addresses : [AddressModel]?
	var charges : Int?
	var createdAt : String?
	var currency : String?
	var firstName : String?
	var ip : String?
	var lastName : String?
	var orderDetails : [OrderDetailModel]?
	var orderNote : String?
	var orderNumber : String?
	var orderStatus : String?
	var payerEmail : String?
	var payerId : String?
	var payerStatus : String?
	var paymentId : String?
	var paymentMethod : String?
	var state : String?
	var status : String?
	var transactionDetails : String?
	var updatedAt : String?
	var user : String?


	class func newInstance(map: Map) -> Mappable?{
		return OrderListDataModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		addresses <- map["addresses"]
		charges <- map["charges"]
		createdAt <- map["createdAt"]
		currency <- map["currency"]
		firstName <- map["firstName"]
		ip <- map["ip"]
		lastName <- map["lastName"]
		orderDetails <- map["orderDetails"]
		orderNote <- map["orderNote"]
		orderNumber <- map["orderNumber"]
		orderStatus <- map["orderStatus"]
		payerEmail <- map["payerEmail"]
		payerId <- map["payerId"]
		payerStatus <- map["payerStatus"]
		paymentId <- map["paymentId"]
		paymentMethod <- map["paymentMethod"]
		state <- map["state"]
		status <- map["status"]
		transactionDetails <- map["transactionDetails"]
		updatedAt <- map["updatedAt"]
		user <- map["user"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         addresses = aDecoder.decodeObject(forKey: "addresses") as? [AddressModel]
         charges = aDecoder.decodeObject(forKey: "charges") as? Int
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         currency = aDecoder.decodeObject(forKey: "currency") as? String
         firstName = aDecoder.decodeObject(forKey: "firstName") as? String
         ip = aDecoder.decodeObject(forKey: "ip") as? String
         lastName = aDecoder.decodeObject(forKey: "lastName") as? String
         orderDetails = aDecoder.decodeObject(forKey: "orderDetails") as? [OrderDetailModel]
         orderNote = aDecoder.decodeObject(forKey: "orderNote") as? String
         orderNumber = aDecoder.decodeObject(forKey: "orderNumber") as? String
         orderStatus = aDecoder.decodeObject(forKey: "orderStatus") as? String
         payerEmail = aDecoder.decodeObject(forKey: "payerEmail") as? String
         payerId = aDecoder.decodeObject(forKey: "payerId") as? String
         payerStatus = aDecoder.decodeObject(forKey: "payerStatus") as? String
         paymentId = aDecoder.decodeObject(forKey: "paymentId") as? String
         paymentMethod = aDecoder.decodeObject(forKey: "paymentMethod") as? String
         state = aDecoder.decodeObject(forKey: "state") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         transactionDetails = aDecoder.decodeObject(forKey: "transactionDetails") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
         user = aDecoder.decodeObject(forKey: "user") as? String

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
		if addresses != nil{
			aCoder.encode(addresses, forKey: "addresses")
		}
		if charges != nil{
			aCoder.encode(charges, forKey: "charges")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if currency != nil{
			aCoder.encode(currency, forKey: "currency")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "firstName")
		}
		if ip != nil{
			aCoder.encode(ip, forKey: "ip")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "lastName")
		}
		if orderDetails != nil{
			aCoder.encode(orderDetails, forKey: "orderDetails")
		}
		if orderNote != nil{
			aCoder.encode(orderNote, forKey: "orderNote")
		}
		if orderNumber != nil{
			aCoder.encode(orderNumber, forKey: "orderNumber")
		}
		if orderStatus != nil{
			aCoder.encode(orderStatus, forKey: "orderStatus")
		}
		if payerEmail != nil{
			aCoder.encode(payerEmail, forKey: "payerEmail")
		}
		if payerId != nil{
			aCoder.encode(payerId, forKey: "payerId")
		}
		if payerStatus != nil{
			aCoder.encode(payerStatus, forKey: "payerStatus")
		}
		if paymentId != nil{
			aCoder.encode(paymentId, forKey: "paymentId")
		}
		if paymentMethod != nil{
			aCoder.encode(paymentMethod, forKey: "paymentMethod")
		}
		if state != nil{
			aCoder.encode(state, forKey: "state")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if transactionDetails != nil{
			aCoder.encode(transactionDetails, forKey: "transactionDetails")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}
