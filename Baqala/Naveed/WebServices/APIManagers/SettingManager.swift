
//
//  SettingManager.swift
//  Baqala
//
//  Created by apple on 1/16/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper


class SettingManager: BaseManager {
    
    static let shared = SettingManager()
    
    func fetchSettingList(completion: @escaping( String?, RootSettingModel?) -> Void) {
        
        let path = self.basePath + "settings"
        
        let params = ["locale": myDefaultLanguage.rawValue] as [String: Any]
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .get,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers:nil)
        
        request.responseObject { (response : DataResponse<RootSettingModel>) in
            
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
