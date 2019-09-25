//
//  SocketShareInstance.swift
//  Baqala
//
//  Created by Apple on 12/28/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
import UIKit
import SocketIO


class SocketMangercl{
    
    static let socketshareMangercl = SocketMangercl()
    
    var SocketshareManger : SocketManager!
    
     var socketshareClient : SocketIOClient!
    
    
    
      func SocketUrlOfUser()
    {
        if let userToken = Sharedata.shareInfo.authToken {
            
            let usertoken = [
                "Authorization":  userToken
            ]
            
            let specs: SocketIOClientConfiguration = [
                .forcePolling(false),
                .forceWebsockets(true),
                .path("/projects/baqala/socket.io"),
                .connectParams(usertoken),
                .log(true)
            ]
            
            self.SocketshareManger = SocketManager(socketURL: URL(string:"https://hello-stream.com/projects/baqala/")! , config: specs)
            
            self.socketshareClient = SocketshareManger.defaultSocket
            
            self.SocketshareManger.defaultSocket.on("connected") {data, ack in
                print(data)
            }
    }
    
    }
    
    
    func establishConnection() {
        socketshareClient.connect()
    }
    
    
    func closeConnection() {
        socketshareClient.disconnect()
    }
}
