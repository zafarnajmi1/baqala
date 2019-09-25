//
//  PaymentManager.swift
//  Baqala
//
//  Created by apple on 1/23/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation


import Alamofire
import AlamofireObjectMapper


class PaymentManager: BaseManager {
    
    static let shared = PaymentManager()
    
    
    func paymentExecute(params: [String: Any] ,completion: @escaping( String?, RootPaymentModel?) -> Void) {
        
        let path = self.basePath + "auth/payment"
        let  header: HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootPaymentModel>) in
            
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
