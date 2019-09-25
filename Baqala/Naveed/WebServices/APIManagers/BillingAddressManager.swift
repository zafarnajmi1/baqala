//
//  BillingAddressManager.swift
//  Baqala
//
//  Created by apple on 12/19/18.
//  Copyright © 2018 My Technology. All rights reserved.
//


import Alamofire
import AlamofireObjectMapper

class BillingAddressManager: BaseManager {
    
    static let shared = BillingAddressManager()
    
    func  submitBillingAddressForm(billing: [String: Any], shipping : [String: Any]?, completion: @escaping( String?, RootBillingAddressModel?) -> Void) {
        
        let path = self.basePath + "auth/update/user-addresses"
        let header: HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
       
        var list = [billing]
        //optional parameter
        if shipping != nil {
            list.append(shipping!)
        }
        let params = ["addresses": list ] as [String: Any]
        

        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootBillingAddressModel>) in

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
