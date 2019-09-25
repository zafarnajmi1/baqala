//
//  SocketManager.swift
//  Baqala
//
//  Created by apple on 2/5/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation
import SocketIO


class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    
    //update user token -> dictionary object global
    static let usertoken = ["token":  Sharedata.shareInfo.authToken!] as [String : Any]
    
    //configure socket
    static let specs: SocketIOClientConfiguration = [
        .forcePolling(false),
        .forceWebsockets(true),
        .path("/projects/baqala/socket.io"),
        .connectParams(usertoken ),
        .log(true),
        .reconnects(true)
        
    ]
    
    
    let socketManger = SocketManager(socketURL: URL(string:"https://hello-stream.com/projects/baqala/")! , config: specs)
    
    //Main Object - for global call
   // let  socketClient = socketManger.defaultSocket
    
    //call this function to connect socket
    
    
    
     func addHandlers() {
        socketManger.defaultSocket.on("myEvent") {data, ack in
            print(data)
        }
    }
     func connectSocket(){

        socketManger.defaultSocket.connect()
        
        self.socketManger.defaultSocket.on("connected") {data, ack in
            print(data)
        }
        
        self.socketManger.defaultSocket.on("connected"){(data , ack)in
            if let arr = data as? [[String: Any]]
            {
                if let txt = arr[0]["text"] as? String
                {
                    print(txt)
                }
            }
        }
        
    }
    
    //call this function to disconnect socket
     func disconnectSocket(){
        socketManger.defaultSocket.disconnect()
    }
    
    
    
}
