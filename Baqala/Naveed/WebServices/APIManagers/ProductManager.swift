//
//  ProductManager.swift
//  Baqala
//
//  Created by apple on 12/14/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper


class ProductManager: BaseManager {
    
    static let shared = ProductManager()
    
  
    func fetchProductListBy(params: [String: Any] = ["locale": myDefaultLanguage.rawValue] ,completion: @escaping( String?, RootProductModel?) -> Void) {
        
        
        
        let path = self.basePath + "product/search"
        
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers:nil)
        
        request.responseObject { (response : DataResponse<RootProductModel>) in
           
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
    
    
    //fecth detail by Id
    func fetchProductDetail(id: String ,completion: @escaping( String?, RootProductDetailModel?) -> Void) {
        
        let path = self.basePath + "auth/product/detail"
        let  header: HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
        //add current location to get distance of store
        let latti = Sharedata.shareInfo.userLatitude
        let longi = Sharedata.shareInfo.userLongitude
        
        let params = ["locale": myDefaultLanguage.rawValue,
                      "id": id,
                      "latitude": latti!,
                      "longitude": longi!] as [String: Any]
        
        
       
        
        
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootProductDetailModel>) in
            
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

    
  
    func fetchStoreProductListBy(params: [String: Any] = ["locale": myDefaultLanguage.rawValue] ,completion: @escaping( String?, RootProductModel?) -> Void) {
        
        
        
        let path = self.basePath + "auth/store/products"
        let  header: HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootProductModel>) in
            
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
    
    
    
    
}