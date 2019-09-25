//
//  ShareData.swift
//  Baqala
//
//  Created by Apple on 12/12/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation


class Sharedata {
    static let shareInfo = Sharedata()
    //private init(){}
    
    ///MARK:- InfoEmail
    var email : String?
    {
            set{
                UserDefaults.standard.set(newValue, forKey:"Email" )
                UserDefaults.standard.synchronize()
            }
            get{
                return UserDefaults.standard.string(forKey: "Email")
            }
    }
    
    var name : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"name" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "name")
        }
    }
    
    var password : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"password" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "password")
        }
    }
    var authToken : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"authToken" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "authToken")
        }
    }
    
    
    var accountType : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"accountType" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "accountType")
        }
    }
    
    var usertype : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"usertype" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "usertype")
        }
    }
    
    var userImage : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"userImage" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "userImage")
        }
    }
    
    var storeImage : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"storeImage" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "storeImage")
        }
    }
    
    var StoreName  : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"StoreName" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "StoreName")
        }
    }
    
    var emailIsVerfied: Bool?
    {
        set{
            UserDefaults.standard.set(newValue , forKey: "emailIsVerfied")
            UserDefaults.standard.synchronize()
            
        }
        get{
            
            return UserDefaults.standard.bool(forKey:  "emailIsVerfied")
        }}
    
    
    
    
    var storeNameEn  : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"storeNameEn" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "storeNameEn")
        }
    }
    var storeNameAr : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"storeNameAr" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "storeNameAr")
        }
    }
    
    
    
    var paypalClientId : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"paypalClientId" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "paypalClientId")
        }
    }
    
    var paypalSecretId : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"paypalSecretId" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "paypalSecretId")
        }
    }
    
    var notificationCount : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"notificationCount" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "notificationCount")
        }
    }
    
    var socialToken : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"socialToken" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "socialToken")
        }
    }
    
    var LoginType : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"LoginType" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "LoginType")
        }
    }
    
    var authMethod : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"authMethod" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "authMethod")
        }
    }
    
    var SocialId : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"SocialId" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "SocialId")
        }
    }
    
    
    
    var Gender : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"Gender" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "Gender")
        }
    }
    
    
    
    
    
    var Fname : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"Fname" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "Fname")
        }
    }
    
    
    var Lname : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"Lname" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "Lname")
        }
    }
    var autoLogin: Bool?
    {
        set{
            UserDefaults.standard.set(newValue , forKey: "isAutoLogin")
            UserDefaults.standard.synchronize()
            
        }
        get{
            
            return UserDefaults.standard.bool(forKey:  "isAutoLogin")
        }}
    
    
    var isFromSettingVC: Bool?
    {
        set{
            UserDefaults.standard.set(newValue , forKey: "isFromSettingVC")
            UserDefaults.standard.synchronize()
            
        }
        get{
            
            return UserDefaults.standard.bool(forKey:  "isFromSettingVC")
        }}
    
    var isLanguageSaved: Bool?
    {
        set{
            UserDefaults.standard.set(newValue , forKey: "isLanguageSaved")
            UserDefaults.standard.synchronize()
            
        }
        get{
            
            return UserDefaults.standard.bool(forKey:  "isLanguageSaved")
        }}
    var languageSaved: String?
    {
        set{
            UserDefaults.standard.set(newValue , forKey: "languageSaved")
            UserDefaults.standard.synchronize()
            
        }
        get{
            
            return UserDefaults.standard.string(forKey:  "languageSaved")
        }}
    
    var Phonenumber : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"Phonenumber" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "Phonenumber")
        }
    }
    
    
    
    
    var address : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"address" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "address")
        }
    }
    var userLatitude : Double?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"userLatitude" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.double(forKey: "userLatitude")
        }
    }
    
    var userLongitude : Double?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"userLongitude" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.double(forKey: "userLongitude")
        }
    }

    


    var cartItemsTotal : Int?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"cartItemsTotal" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.integer(forKey: "cartItemsTotal")
        }
    }
    


    

    var id : String?
    {
        set{
            UserDefaults.standard.set(newValue, forKey:"id" )
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "id")
        }
    }

    var conversationID = ""
    var conversationIDImage = ""
    var conversationArray = [Conversations]()
    var conversationTableId : Int = 0
    var chatTitle = ""
    var personID = ""
    var conversationuserID = ""
    
}
