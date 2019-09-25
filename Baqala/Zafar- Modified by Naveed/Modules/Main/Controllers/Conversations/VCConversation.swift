//
//  VCConversation.swift
//  Baqala
//
//  Created by Macbook on 06/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import SocketIO
import  PullToRefreshKit
import  IQKeyboardManagerSwift
import ObjectMapper


class VCConversation: UIViewController {

    
    //MARK:- ConversationCycle
    var productimg = ""
    var product_user_name = ""
    var productPrice = ""
    
    
    
    
    var socketClient: SocketIOClient!
    var soketManger: SocketManager!
    var  myRootConversation  = RootConversationModel()
    
    
    
    
    
    
    @IBOutlet var conversationtableview: UITableView!
        {
        didSet{
            self.conversationtableview.delegate =  self
            self.conversationtableview.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
      
       viewWillAppear(true)
    
        configureTableViewRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Conversation".localized
        
        setCustomNavigationBar()
        setBackButton()
       
       
    }
    
    func hitConversation(){
        
        if let userToken = Sharedata.shareInfo.authToken {
            
            let usertoken = [
                "token":  userToken
            ]
            
            let specs: SocketIOClientConfiguration = [
                .forcePolling(false),
                .forceWebsockets(true),
                .path("/projects/baqala/socket.io"),
                .connectParams(usertoken as [String : Any]),
                .log(true),
                .reconnects(true)
                
            ]
            
            self.soketManger = SocketManager(socketURL: URL(string:"https://hello-stream.com/projects/baqala/")! , config: specs)
            
            self.socketClient = soketManger.defaultSocket
            
            self.soketManger.defaultSocket.on("connected") {data, ack in
                print(data)
            }
            
            self.socketClient.on("connected") { (data, ack) in
                if let arr = data as? [[String: Any]] {
                    if let txt = arr[0]["text"] as? String {
                        print(txt)
                    }
                }
            }
            
            self.socketClient.on("error") { (data, ack) in
                if let arr = data as? [[String: Any]] {
                    if let txt = arr[0]["text"] as? String {
                        print(txt)
                    }
                }
            }
            
            
            
            self.socketClient.on("conversationsList") { (data, ack) in
                let modified =  (data[0] as AnyObject)
                
                let dictionary = modified as! [String: AnyObject]
                
                if let rootModel = Mapper<RootConversationModel>().map(JSONObject: dictionary) {
                    print(rootModel.message?.en ?? "" )
                   self.myRootConversation =  rootModel
                    
                }
                else {
                    nvMessage.showStatusError(body: "Response Changed")
                }
                
                self.conversationtableview.delegate = self
                self.conversationtableview.dataSource = self
                
                self.conversationtableview.reloadData()
                
                
               
                
                self.conversationtableview.switchRefreshHeader(to: .normal(.success, 0.0))
            }
            
            self.socketClient.on("lastMessage") { (data, ack) in
                let modified =  (data[0] as AnyObject)
                
                let dictionary = modified as! [String: AnyObject]
                
                print(dictionary)
                self.socketClient.emit("conversationsList")
                
            }
            
            self.socketClient.on(clientEvent: .connect) {data, emitter in
                // handle connected
                self.socketClient.emit("conversationsList")
                
            }
            
            self.socketClient.on(clientEvent: .disconnect, callback: { (data, emitter) in
                //handle diconnect
            })
            
            self.socketClient.onAny { (event: SocketAnyEvent) -> Void in
                print("Got event: \(event.event), with items: \(event.items!)")
            }
            
            self.socketClient.connect()
        
        }
    }
    
    //MARK:- Base Configuration
    fileprivate func configureTableViewRefresh() {
        let header = DefaultRefreshHeader.header()
        self.conversationtableview.configRefreshHeader(with: header,container:self) { [weak self] in
            //call your function to update table View
            self?.hitConversation()
            
        }
        delay(bySeconds: 0.2, closure: {
            self.conversationtableview.switchRefreshHeader(to: .refreshing)
        })
        
    }

}
extension VCConversation: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myRootConversation.data?.conversations?.count ?? 0
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellConversation") as! CellConversation
        
        let model = self.myRootConversation.data?.conversations?[indexPath.row]
        
        cell.setData(model: model!)
        
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCChat") as! VCChat
        
        let model = self.myRootConversation.data?.conversations?[indexPath.row]
        vc.conversationModel = model
        vc.userimg = model?.user?.image ?? ""
        
        
        let product = model?.product
        vc.productName = setDefaultLanguage(body: (product?.productName)!)//productName ?? "Unkown"
      
        vc.productImage = product?.image ?? ""
        
        let price = myDefaultCurrency == .usd ? product?.price?.usd: product?.price?.aed
        vc.productPrice =  setDefaultCurrency(price: Float(price ?? 0))
       
       
        switch myDefaultAccountType {
        
        case .seller:
          
            let fullName = "\(model?.user?.firstName ?? "Unkown") \(model?.user?.lastName ?? "name")"
             vc.storeOrUsername = fullName
       
        case .buyer:
           
            let store = model?.store
            vc.storeOrUsername = setDefaultLanguage(body: (store?.storeName)!)
            
        default:
            print("No Account Selected")
        }
       
        Sharedata.shareInfo.conversationID = (model?.id!)!
        Sharedata.shareInfo.conversationTableId = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
 

}
