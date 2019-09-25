//
//  CheckOutManager.swift
//  Baqala
//
//  Created by apple on 12/19/18.
//  Copyright © 2018 My Technology. All rights reserved.
//


import Alamofire
import AlamofireObjectMapper


class CheckOutManager: BaseManager {
    
    static let shared = CheckOutManager()
    
    func submitCashOndeliveryForm(params: [String: Any], completion: @escaping( String?, RootAddProductToCartModel?) -> Void) {
        
        let path = self.basePath + "auth/payment"
    
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers:self.authorizedHeader)
        
        request.responseObject { (response : DataResponse<RootAddProductToCartModel>) in
            
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
