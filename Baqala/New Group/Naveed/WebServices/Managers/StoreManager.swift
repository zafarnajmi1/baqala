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
    
    
    func fetchStoreListbyLocation(completion: @escaping( String?, RootStoreModel?) -> Void) {
        
        let path = self.basePath + "stores"
        
        let params = ["locale": myDefaultLanguage.rawValue,
                      "latitude": userLocation.latitude,
                      "longitude": userLocation.longitude
                     ] as [String: Any]
        
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
                    let error = setDefaultSelectedLanguage(body: (object?.message)!)
                    completion(error, nil)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
            
            
        }
        
    }

}
