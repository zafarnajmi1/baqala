//
//  StoreManager.swift
//  Baqala
//
//  Created by apple on 12/17/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper


class StoreManager: BaseManager {
    
    static let shared = StoreManager()
    
    
    func fetchStoreListby(storeName: String?, lat: Double? , long: Double? , page: Int = 1 ,completion: @escaping( String?, RootStoreModel?) -> Void) {
        
        let path = self.basePath + "stores"
        
        var params = ["locale": myDefaultLanguage.rawValue] as [String: Any]
       
        if page > 1 {
            params.updateValue(page, forKey: "page")
        }
        
        if Sharedata.shareInfo.userLatitude != nil {
            params.updateValue(Sharedata.shareInfo.userLatitude!, forKey: "latitude" )
            params.updateValue(Sharedata.shareInfo.userLongitude!, forKey: "longitude" )
        }
        
        if  lat != nil && long != nil {
            params.updateValue(lat!, forKey: "latitude" )
            params.updateValue(long!, forKey: "longitude" )
        }
        if storeName != nil {
            params.updateValue(storeName!, forKey: "storeName")
        }
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers:nil)
        
        request.responseObject { (response : DataResponse<RootStoreModel>) in
            
            //response Http
            print("ws Error: \(String(describing: response.error))")
            print("ws Response: \(String(describing: response.response))")
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("ws Data: \(utf8Text)")
            }
            
            //response result API
            switch response.result {
            case .success(_):
                let object = response.result.value
                if (object?.success)! {
                    completion(nil, object)
                }
                else {
                    let error = setDefaultLanguage(body: (object?.message)!)
                    completion(error, nil)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
            
            
        }
        
    }
    

    
    func getStoreReviews(Page:Int?, storeId: String? , completion: @escaping( String?, RootStoreReviewModel?) -> Void) {
        
        let path = self.basePath + "store/reviews"
        let  header: HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
        //default is seller store id
        var dicParams = ["store": Sharedata.shareInfo.id!] as [String: Any]
        //store specific id
        if storeId != nil {
            dicParams.updateValue(storeId!, forKey: "store")
        }
        
        if Page != nil {
            dicParams.updateValue(Page!, forKey: "page")
        }
        
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: dicParams,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootStoreReviewModel>) in
            
            print("ws Error: \(String(describing: response.error))")
            print("ws Response: \(String(describing: response.response))")
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("ws Data: \(utf8Text)")
            }
            
            switch response.result {
            case .success(_):
                let object = response.result.value
                if (object?.success)! {
                    completion(nil, object)
                }
                else {
                    completion(object?.message?.en, nil)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
            
        }
        
    }
    
    
    func getStoreDetail(storeId: String?, location:[Double]? , completion: @escaping( String?, RootStoreDetailModel?) -> Void) {
        
      
        var dicParams : [String: Any] = ["id": storeId!]
     
        
        if let location = location {
            dicParams.updateValue(location[0], forKey: "latitude")
            dicParams.updateValue(location[1], forKey: "longitude")
        }
        
        let path = self.basePath + "auth/store/detail"
       let  header: HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: dicParams,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootStoreDetailModel>) in
            
            print("ws Error: \(String(describing: response.error))")
            print("ws Response: \(String(describing: response.response))")
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("ws Data: \(utf8Text)")
            }
            
            switch response.result {
            case .success(_):
                let object = response.result.value
                if (object?.success)! {
                    completion(nil, object)
                }
                else {
                    completion(object?.message?.en, nil)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
            
        }
        
    }
    

    func submitStoreReview(params:[String:Any], completion: @escaping( String?, RootModel?) -> Void) {
        
        let path = self.basePath + "auth/submit/store-review"
        let  header: HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootModel>) in
            
            print("ws Error: \(String(describing: response.error))")
            print("ws Response: \(String(describing: response.response))")
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("ws Data: \(utf8Text)")
            }
            
            switch response.result {
            case .success(_):
                let object = response.result.value
                if (object?.success)! {
                    completion(nil, object)
                }
                else {
                    completion(object?.message?.en, nil)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
            
        }
        
    }
    
}


//auth/submit/store-review
