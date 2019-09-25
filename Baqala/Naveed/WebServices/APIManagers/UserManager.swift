//
//  UserManager.swift
//  Baqala
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation


import Alamofire
import AlamofireObjectMapper


class UserManager: BaseManager {
    
    static let shared = UserManager()
    
    func createUserAccount(params:[String: Any],completion: @escaping( String?, RootUserLoginModel?) -> Void) {
        
        let path = self.basePath + "register"
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: nil)
        
        request.responseObject { (response : DataResponse<RootUserLoginModel>) in
            
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
    
    func createUserAccountFromSoicalProfile(params:[String: Any],completion: @escaping( String?, RootUserLoginModel?) -> Void) {
        
        let path = self.basePath + "social-login"
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: nil)
        
        request.responseObject { (response : DataResponse<RootUserLoginModel>) in
            
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
    
    func userlogin(params:[String: Any],completion: @escaping( String?, RootUserLoginModel?) -> Void) {
        
        let path = self.basePath + "login"
      
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: nil )
        
        request.responseObject { (response : DataResponse<RootUserLoginModel>) in
            
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
                    //let msg = object?.errors
                    completion(object?.message?.en, nil)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
            
        }
        
    }
    
    
    func userSocialLogin(params:[String: Any],completion: @escaping( String?, RootUserLoginModel?) -> Void) {
        
        let path = self.basePath + "social-login/check"
        let header: HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootUserLoginModel>) in
            
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
                    //let msg = object?.errors
                    completion(object?.message?.en, nil)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
            
        }
        
    }
    
}
