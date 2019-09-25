//
//  AlertView.swift
//  Baqala
//
//  Created by Apple on 12/13/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation

import UIKit
class AlertView
{
    
    //MARK:- OKAlert
    class func NotificationAlert(title: String, message: String, okAction: (() -> ())?) -> UIAlertController
    {
     let AlerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OkactionView = UIAlertAction(title: "Ok".localized, style: .default){(action) in
            okAction?()
        }
        AlerController.addAction(OkactionView)
        return AlerController
    }
    //MARK:- OtherAlerts
    class func NotificationAlert(title:  String , action1 title1: String, actiont2 title2: String?, message: String, actionone:(()->())?, actionTwo: (()-> ())?, cancelAction:(()->())? )-> UIAlertController
    {
        let AlerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
      
        let actionOne = UIAlertAction(title: title1, style: .default){(action)in
            actionone?()
        }
        AlerController.addAction(actionOne)
        
        
        
        
        if title2 != nil
        {
            let actiontwo = UIAlertAction(title: title2, style: .cancel)
            { action in
                actionTwo?()
            }
            AlerController.addAction(actiontwo)
        }
        
        
        let cancelaction = UIAlertAction(title: "Cancel".localized, style: .cancel){action in
            cancelAction?()
        }
        AlerController.addAction(cancelaction)
        
        
        return AlerController
    }
    
    
}
extension UIViewController {
    
    func alertMessage(message:String,completionHandler:(()->())?) {
        let alert = UIAlertController(title:"", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok".localized, style: .default) { (action:UIAlertAction) in
            completionHandler?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
