//
//  OrderManager.swift
//  Baqala
//
//  Created by apple on 12/28/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper



class OrderManager: BaseManager {
  
    static let shared = OrderManager()
    //fecth buyer order list
    func fetchListBy(status: String = "confirmed"  ,completion: @escaping( String?, RootOrderListModel?) -> Void) {
        
        
        
        
        let params = ["locale": myDefaultLanguage.rawValue,
                      "status" : status] as [String: Any]
        
        let path = self.basePath + "auth/orders/show"
         let authorizedHeader = ["Authorization":Sharedata.shareInfo.authToken ?? "" ] as HTTPHeaders
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: authorizedHeader)
        
        request.responseObject { (response : DataResponse<RootOrderListModel>) in
            
            
            //this block  only for printing response to varify response
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
                    let error = setDefaultLanguage(body: (object?.message)!)
                    completion(error, nil)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
            
            
        }
        
    }
    
    
    
    //fetch seller order list
    func fetchSellerOrderListBy(status: String = "confirmed"  ,completion: @escaping( String?, RootSellerOrderModel?) -> Void) {
        
        
        
        
        let params = ["locale": myDefaultLanguage.rawValue,
                      "status" : status] as [String: Any]
        
        let path = self.basePath + "auth/orders/show"
        let authorizedHeader = ["Authorization":Sharedata.shareInfo.authToken ?? "" ] as HTTPHeaders
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: authorizedHeader)
        
        request.responseObject { (response : DataResponse<RootSellerOrderModel>) in
            
            
            //this block  only for printing response to varify response
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
                    let error = setDefaultLanguage(body: (object?.message)!)
                    completion(error, nil)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
            
            
        }
        
    }
    
    
    //MARK:- seller -> ship order by order ID
    
    func shipProductBy(orderDetailId: String,completion: @escaping( String?, RootModel?) -> Void) {
        
        let path = self.basePath + "auth/ship/product"
        let header: HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
        
        let params = ["orderDetailId": orderDetailId ] as [String: Any]
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootModel>) in
            
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
    
    
    func completeProductBy(orderDetailId: String,completion: @escaping( String?, RootModel?) -> Void) {
        
        let path = self.basePath + "auth/complete/product"
        let header : HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
        
        
        
        let params = ["orderDetailId": orderDetailId ] as [String: Any]
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootModel>) in
            
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
    
    
    
    
    func getMyOrderDetailBy(orderId: String,completion: @escaping( String?, RootOrderDetailModel?) -> Void) {
        
        let path = self.basePath + "auth/order/detail"
        let header: HTTPHeaders = ["Authorization": Sharedata.shareInfo.authToken ?? "" ]
        let params = ["order": orderId ] as [String: Any]
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers: header)
        
        request.responseObject { (response : DataResponse<RootOrderDetailModel>) in
            
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
