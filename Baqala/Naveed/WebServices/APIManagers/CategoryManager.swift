//
//  CategoryManager.swift
//  Baqala
//
//  Created by apple on 12/13/18.
//  Copyright © 2018 My Technology. All rights reserved.
//


import Alamofire
import AlamofireObjectMapper


class CategoryManager: BaseManager {
    
    static let shared = CategoryManager()
    
    func fetchCatgoryList(title: String? ,completion: @escaping( String?, RootCategoryModel?) -> Void) {
        
        let path = self.basePath + "categories"
        
        var params = ["locale": myDefaultLanguage.rawValue] as [String: Any]
 
        if title != nil {
            params.updateValue(title!, forKey: "title")
        }
        
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers:nil)
        
        request.responseObject { (response : DataResponse<RootCategoryModel>) in
            
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
  
    
    //fecth subCatgory by Id
    func fetchSubCatgoryList(title: String?, model: CategoryModel  ,completion: @escaping( String?, RootCategoryModel?) -> Void) {
        
    
      
        
        var params = ["locale": myDefaultLanguage.rawValue,
                      "id" : model.id] as [String: Any]
        
        if title != nil {
            params.updateValue(title!, forKey: "title")
        }
        
        
        let path = self.basePath + "sub-categories"
        // make calls with the session manager
        let request = sessionManager.request(path,
                                             method: .post,
                                             parameters: params,
                                             encoding: JSONEncoding.default,
                                             headers:nil)
        
        request.responseObject { (response : DataResponse<RootCategoryModel>) in
            
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
}
