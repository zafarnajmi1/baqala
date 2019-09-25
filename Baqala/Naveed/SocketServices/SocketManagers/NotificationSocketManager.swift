//
//  NotificationSocketManager.swift
//  Baqala
//
//  Created by apple on 2/5/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation
import ObjectMapper


class NotificationSocketManager {
   
    static let shared = NotificationSocketManager()
    
    func getNotificationList( completion: @escaping (_ error: String?, _ totalUnseen: String?) -> Void) {
    
      
        let socketClient = SocketIOManager.shared.socketManger.defaultSocket
        SocketIOManager.shared.connectSocket()
        //on connect
        socketClient.on(clientEvent: .connect){(data, emiterr)in
            //emit
            socketClient.emit("notificationsList")
        }
        
        //recieve data
        socketClient.on("notificationsList"){(data, ack)in
            
            //MARK:- StopProccessHere
           // socketClient.disconnect()
            
            let modified = data[0] as AnyObject
    
          
            if let obj =  Mapper<NotificationRootModel>().map(JSONObject: modified) {
             
            
                if obj.success == true {
                   
                    let notificationList = (obj.data?.notifications)!
                    
                    if notificationList.count == 0 {
                        print("no data")
                       // nvMessage.showError(title:"Notifications", body: appConstant.noMoreData)
                    }
                    let totalUnseen = obj.data?.unseenNotificationsCount ?? 0
                    Sharedata.shareInfo.notificationCount = "\(totalUnseen)"
                    completion(nil, "\(totalUnseen)" )
                    
                }
                else {
                   
                        completion(obj.message, nil )
                }
                
              
            }
            else {
                 completion("Server is not Responding", nil)
            }
       
            
        } // end .on
        
       
    }
}
