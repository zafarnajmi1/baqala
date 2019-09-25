//
//  CartManager.swift
//  Baqala
//
//  Created by apple on 12/17/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper


class CartManager: BaseManager {
    
    static let shared = CartManager()
    
    
    func addProductToCart(productId: String, qty: Int, completion: @escaping( String?, RootAddProductToCartModel?) -> Void) {
        
        let path = self.basePath + "auth/cart/add-product"
        
        let params = ["quantity": qty,
                      "product": productId
            ] as [String: Any]
        
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
    
    func fetchMyCartList(completion: @escaping( String?, RootMyCardModel?) -> Void) {
        
        let path = self.basePath + "auth/cart"
  
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .get,
                                             parameters: nil,
                                             encoding: JSONEncoding.default,
                                             headers:self.authorizedHeader)
        
        request.responseObject { (response : DataResponse<RootMyCardModel>) in
            
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
    
    func removeProductByIdToCart(productId: String,completion: @escaping( String?, RootAddProductToCartModel?) -> Void) {
        
        let path = self.basePath + "auth/cart/product/remove"
        
        let params = ["product": productId ] as [String: Any]
        
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
    
    func  updateProductByIdToCart(productId: String, qty: Int, completion: @escaping( String?, RootAddProductToCartModel?) -> Void) {
        
        let path = self.basePath + "auth/cart/update"
        
        let params = ["quantity": qty,
                      "product": productId
            ] as [String: Any]
        
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
