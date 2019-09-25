
//
//  ProfileManager.swift
//  Baqala
//
//  Created by apple on 1/23/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper


class ProfileManager: BaseManager {
    
    static let shared = ProfileManager()
    
    func getUserProfile(completion: @escaping( String?, RootProfileModel?) -> Void) {
        
        let path = self.basePath + "auth/user-profile"
        let  header: HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .get,
                                             parameters: nil,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootProfileModel>) in
            
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
