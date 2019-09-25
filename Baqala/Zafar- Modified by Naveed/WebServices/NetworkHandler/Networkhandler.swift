//
//  Networkhandler.swift
//  Baqala
//
//  Created by Macbook on 12/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SDWebImage
class Networkhandler {
    
    //MARK:- PostRequest
    class func PostRequest(url: String,parameters:Parameters?, Success: @escaping (Any?)->Void, Falioure: @escaping (NetWorkError)->Void ) {
     
        let Manger = Alamofire.SessionManager.default
        var Headers : HTTPHeaders
        
        
        if let userToken = UserDefaults.standard.value(forKey: "userAuthToken") as? String {
            Headers = [
                "Accept": "application/json",
                "authorization"  : userToken
            ]
        } else {
            Headers = [
                "Accept": "application/json"
            ]
        }
        
        Manger.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Headers).validate(statusCode: 200..<600).responseJSON{(response)->  Void in
            
            switch(response.result)
            {
          case .success:
               let ModelResponse = response.result.value
               Success(ModelResponse!)
               print(ModelResponse!)
                break
            case .failure(let error):
                
                var NetworkErrors = NetWorkError()
                
                if(error._code == NSURLErrorTimedOut)
                {
                  NetworkErrors.Status = Constant.NetworkErrorType.timout
                    NetworkErrors.Message = Constant.NetworkErrorType.timoutError
                    Falioure(NetworkErrors)
                }else{
                    NetworkErrors.Status = Constant.NetworkErrorType.generic
                    NetworkErrors.Message = Constant.NetworkErrorType.genericError
                    Falioure(NetworkErrors)
                }
                
                break
            }
            
        }
        
    }
    
     //MARK:- GetRequest
    class func GetRequest(url : String, parameters: Parameters?,  Success: @escaping (Any)-> Void, Faloiur: @escaping (NetWorkError)->Void)
    {
        let Manger = Alamofire.SessionManager.default
        var Headers : HTTPHeaders
        
        if let userToken = UserDefaults.standard.value(forKey: "userAuthToken") as? String {
            Headers = [
                "Accept": "application/json",
                "authorization"  : userToken
            ]
        } else {
            Headers = [
                "Accept": "application/json"
            ]
        }
        
        Manger.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: Headers).validate(statusCode: 200..<600).responseJSON{(respons)->Void in
            
            switch(respons.result)
            {
                
            case .success:
                let ModelResponse  = respons.result.value
                Success(ModelResponse!)
                print(ModelResponse!)
                break
            case .failure(let error):
                
                var NetworkErrors = NetWorkError()
                
                if(error._code == NSURLErrorTimedOut)
                {
                    NetworkErrors.Status = Constant.NetworkErrorType.timout
                    NetworkErrors.Message = Constant.NetworkErrorType.timoutError
                    Faloiur(NetworkErrors)
                }else{
                    NetworkErrors.Status = Constant.NetworkErrorType.generic
                    NetworkErrors.Message = Constant.NetworkErrorType.genericError
                    Faloiur(NetworkErrors)
                }
                
                break
            }
            
        }
        
    }
    
    //MARK:-  MultiPartDataUpload
    
    
    class func UploadData(url: String, parameters: Parameters?,userimg: UIImage,Progress: @escaping (Int) ->Void, Success: @escaping (Any?)->Void, Falioure: @escaping (NetWorkError) -> Void)
    {
        var Headers : HTTPHeaders
        let Manger = Alamofire.SessionManager.default
        if let userToken = UserDefaults.standard.value(forKey: "userAuthToken") as? String {
            Headers = [
                "Accept": "application/json",
                "Authorization" : userToken,
                "Content-type": "multipart/form-data"
            ]
        }else
        {
            Headers = ["Accept": "application/json"]
        }
        
        let type = "any"
        let fileName = "image"
        
        Manger.upload(multipartFormData: {(multipart) in
            
            if let data = userimg.jpegData(compressionQuality: 0.7)
            {
                print(data)
                multipart.append(data, withName: "image", fileName: fileName, mimeType: type)
            }
            for(key, values ) in parameters!
            {
                multipart.append((values as! String).data(using: String.Encoding.utf8)!, withName: key)
                print(values)
                print(values)
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: Headers, encodingCompletion:{(result) in
            switch(result)
            {
            case .success(let request,_,_):
                request.uploadProgress(closure: { (prgrs) in
                    
                    let progress = Int(prgrs.fractionCompleted * 100)
                    print(progress)
                    Progress(progress)
                })
                request.responseJSON(completionHandler: {(successresponse)in
                    
                    switch(successresponse.result)
                    {
                    case .success:
                        let resultValue = successresponse.result.value
                        print(resultValue!)
                        Success(resultValue)
                        break
                        
                    case .failure (let error):
                        
                        
                        var networkError = NetWorkError()
                        
                        if error._code == NSURLErrorTimedOut {
                            networkError.Status = Constant.NetworkErrorType.timout
                            networkError.Message = Constant.NetworkErrorType.timoutError
                            
                            Falioure(networkError)
                        } else {
                            networkError.Status = Constant.NetworkErrorType.generic
                            networkError.Message = Constant.NetworkErrorType.genericError
                            
                            Falioure(networkError)
                        }
                        break
                        
                    }
                    
                })
            case .failure(let error):
                Falioure(error as! NetWorkError)
            }
            
        })
        
        
    }
    
    
    
    
    //MARK:- UpLoadImage
    class func UploadImage(url: String, parameters: Parameters?,userimg: UIImage,Progress: @escaping (Int) ->Void, Success: @escaping (Any?)->Void, Falioure: @escaping (NetWorkError) -> Void)
    {
        var Headers : HTTPHeaders
        let Manger = Alamofire.SessionManager.default
        print(UserDefaults.standard.value(forKey: "userAuthToken")!)
        if let userToken = UserDefaults.standard.value(forKey: "userAuthToken") as? String {
            Headers = [
                "Accept": "application/json",
                "authorization" : userToken
                //"Content-type": "multipart/form-data"
            ]
        }else
        {
            Headers = ["Accept": "application/json"]
        }
        
        let type = "any"
        let fileName = "image"
        
        Manger.upload(multipartFormData: {(multipart) in
            
            if let data = userimg.jpegData(compressionQuality: 0.7)
            {
                print(data)
                multipart.append(data, withName: "image", fileName: fileName, mimeType: type)
            }
            //            for(key, values ) in parameters!
            //            {
            //                multipart.append((values as! String).data(using: String.Encoding.utf8)!, withName: key)
            //                print(values)
            //                print(values)
            //            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: Headers, encodingCompletion:{(result) in
            switch(result)
            {
            case .success(let request,_,_):
                request.uploadProgress(closure: { (prgrs) in
                    
                    let progress = Int(prgrs.fractionCompleted * 100)
                    print(progress)
                    Progress(progress)
                })
                request.responseJSON(completionHandler: {(successresponse)in
                    
                    switch(successresponse.result)
                    {
                    case .success:
                        let resultValue = successresponse.result.value
                        print(resultValue!)
                        Success(resultValue)
                        break
                        
                    case .failure (let error):
                        
                        
                        var networkError = NetWorkError()
                        
                        if error._code == NSURLErrorTimedOut {
                            networkError.Status = Constant.NetworkErrorType.timout
                            networkError.Message = Constant.NetworkErrorType.timoutError
                            
                            Falioure(networkError)
                        } else {
                            networkError.Status = Constant.NetworkErrorType.generic
                            networkError.Message = Constant.NetworkErrorType.genericError
                            
                            Falioure(networkError)
                        }
                        break
                        
                    }
                    
                })
            case .failure(let error):
                Falioure(error as! NetWorkError)
            }
            
        })
    }
    
    
    
}



struct NetWorkError {
    var Status : Int = Constant.NetworkErrorType.generic
    var Message : String = Constant.NetworkErrorType.genericError
}
struct NetworkSuccess {
    var Status : Int = Constant.NetworkErrorType.generic
    var Message : String = Constant.NetworkErrorType.genericError
}


/*
 let imgUrl = NSURL( string:  self.subDivisionArr[indexPath.row].image!)
 print(imgUrl!)
 cell.imgsubdivision.af_setImage(withURL: imgUrl! as URL, placeholderImage: UIImage(named : "test"), filter: nil, imageTransition:.curlDown(0.1), runImageTransitionIfCached: true, completion: nil)*/
