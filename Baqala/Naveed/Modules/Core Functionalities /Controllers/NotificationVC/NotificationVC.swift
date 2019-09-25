//
//  NotificationVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import SocketIO
import  PullToRefreshKit
import  NVActivityIndicatorView
import ObjectMapper
import MIBadgeButton_Swift

class NotificationVC: UIViewController {

    //MARK:- outlets
 
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- properties and Structures
    var socketClient: SocketIOClient!
    var soketManger: SocketManager!
   
    let fileName = "attachment"
    var imageUrl : URL!
    var socketImageUrl = ""
    let user = Sharedata.shareInfo
    var notificationList = [NotificationModel2]()
    var cartBadge: MIBadgeButton!
    

    var page = 1
    var totalPage = 0
    
    
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppear(false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButton()
        self.title = "Notifications".localized
   
      //  self.setCustomNavigationBar()
        self.setRemoveAllBarBtn()
        self.tableView.registerCustomCell(withCellId: "NotificationTableViewCell")
        
        self.NotificationSocket()
        
        self.configureTableViewRefresh()
    
        
        self.cartBadge = MIBadgeButton(type: .custom)
    }
    
   

    
}


//MARK:- Base Configuration
extension NotificationVC {
   
    func setRemoveAllBarBtn()
    {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "Clear"), for: .normal)
        btn1.setTitle(" Clear All ".localized, for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(removeAll), for: .touchUpInside)
        let btnCart = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([btnCart], animated: true)
        

    }
    
    //MARK:- RemoveAll
    @objc func removeAll() {
        print("I am here Baqala")
        self.removeAllNotification()
        self.notificationList.removeAll()
        self.tableView.reloadData()
    }

    
}


//MARK:- tableView Extension

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        
           let model = notificationList[indexPath.row]
         cell.setData(model: model)
        
         cell.myClearBtn.tag = indexPath.row
         cell.myClearBtn.addTarget(self, action: #selector(deletNotification(_:)) , for: .touchUpInside)
        
        
        return cell
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if (tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height - 20 {
            ProgressHUD.present(animated: true)
            let dic = ["page": self.page] as [String: Any]
            self.socketClient.emit("notificationsList", dic)
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        setupActions(indexPath)
        
        
        //read status
        let notification = self.notificationList[indexPath.row]
        
        if notification.seen == false {
            self.showNvLoader()
            let unSeenNofictionaIdList = [notification.id!]
            let parms = ["notifications": unSeenNofictionaIdList]
            self.socketClient.emit("notificationsSeen", with: [parms])
            
        }
        
    }
    
    
    
    fileprivate func setupActions(_ indexPath: IndexPath) {
        //perform actions by actount type
        
        switch myDefaultAccountType {
        case .seller:
            self.readNotificationBySeller(indexPath: indexPath)
        case .buyer:
            self.readNotificationByBuyer(indexPath: indexPath)
        case .guest:
            print("guest")
        default:
            print("not exist")
        }
    }
    
    
    
    func readNotificationBySeller(indexPath: IndexPath)  {
        
        let notification = self.notificationList[indexPath.row]
       
      
        if notification.action == "NEW_ORDER" {
                let storyboard = UIStoryboard(name: "Order", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "StoreOrderListVC") as! StoreOrderListVC
                self.navigationController?.pushViewController(vc, animated: true)
        }
    
        if notification.action == "OPEN_CONVERSATION" {
            self.getConversationObject(indexPath: indexPath)
        }
    }
    
    func readNotificationByBuyer(indexPath: IndexPath)  {
      
        let notification = self.notificationList[indexPath.row]
       
        if notification.action == "ORDER_SHIPPED" {
            let storyboard = UIStoryboard(name: "Order", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MyOrderDetailVC") as! MyOrderDetailVC
//            let desc = notification.descriptionField!.en
//
//            let datecomponents = desc!.components(separatedBy: "#")
//            let order = datecomponents[1]
//            
            
             let model = notificationList[indexPath.row]
            
            vc.orderId = model.extras?.order
            self.navigationController?.pushViewController(vc, animated: true)
        }
     
        
        if notification.action == "OPEN_CONVERSATION" {
           self.getConversationObject(indexPath: indexPath)
        }
        
        
    }
    
    
    
    //MARK: Delete a Notification
    @objc func deletNotification(_ sender: UIButton!)
    {
        print(sender.tag)
        self.removeNotification(i: sender.tag)
    }
   
    //MARK:- Base Configuration
    fileprivate func configureTableViewRefresh() {
       
        let header = DefaultRefreshHeader.header()
        self.tableView.configRefreshHeader(with: header,container:self) { [weak self] in
            //call your function to update table View
            self!.page = 1
            self?.NotificationSocket()
            
        }
        delay(bySeconds: 0.2, closure: {
            self.tableView.switchRefreshHeader(to: .refreshing)
        })
        
    }
    
    
 func NotificationSocket(){
    
        print(Sharedata.shareInfo.authToken!)
        let userToken = Sharedata.shareInfo.authToken
        let usertoken = [
            "token":  userToken!
        ]
        //self.ShowNvLoader()
        print(userToken!)
        let specs: SocketIOClientConfiguration = [
            .forcePolling(false),
            .forceWebsockets(true),
            .path("/projects/baqala/socket.io"),
            .connectParams(usertoken as [String : Any]),
            .log(true),
            .reconnects(true)
            
        ]
        print(specs)
        self.soketManger = SocketManager(socketURL: URL(string:"https://hello-stream.com/projects/baqala/")! , config: specs)
        self.socketClient = soketManger.defaultSocket
        self.soketManger.defaultSocket.on("connected") {data, ack in
            print(data)
        }
    
        self.socketClient.on("connected"){(data , ack)in
            if let arr = data as? [[String: Any]]
            {
                if let txt = arr[0]["text"] as? String
                {
                    print(txt)
                }
            }
        }
    
    
    
        socketClient.on("notificationsList"){(data, ack)in
      
            //MARK:- StopProccessHere
            self.hideNvloader()
            ProgressHUD.dismiss(animated: true)
            
            
            self.tableView.switchRefreshHeader(to: .normal(.success, 0.0))
            
            let modified = data[0] as AnyObject
            
            if let obj =  Mapper<RootNotificationModel>().map(JSONObject: modified) {
              
               // self.myRootNotificationModel = obj
               
                if obj.success == true {
                    
                    self.totalPage = (obj.data?.pagination?.pages)!
                    
                    if self.page == 1 {
                        self.notificationList = (obj.data?.notifications)! // default list
                        self.page += 1
                    }
                    else {
                        
                        if self.page <= self.totalPage {
                           
                            self.page += 1 //increment in current page
                            
                            for model in (obj.data?.notifications)! {
                                self.notificationList.append(model)
                            }
                        }
                    }
                    
                      Sharedata.shareInfo.notificationCount = "\(obj.data?.unseenNotificationsCount ?? 0)"
                    
                    
                    if self.notificationList.count == 0 {
                        nvMessage.showError(title:"Notifications", body: appConstant.noMoreData)
                    }
                  
                    self.tableView.reloadData()
                    
                }
                else {
                    let msg = obj.message
                    nvMessage.showError(body: msg ?? "")
                }
               
               
            }
            
       }
        
    
       socketClient.on("newNotification"){(data , ack )in
            let dic = ["page": self.page] as [String: Any]
            self.socketClient.emit("notificationsList", dic)
            
        }
       socketClient.on("removeNotifications"){(data , ack)in
           
            let modified = data[0] as AnyObject
            let dictionary = modified as! [String: AnyObject]
            print(dictionary)
        }
        socketClient.on("notificationsChanged"){(data, ack)in
            let dic = ["page": self.page] as [String: Any]
            self.socketClient.emit("notificationsList",dic)
        }
       socketClient.on(clientEvent: .disconnect){(data , emiterr)in
              print("clientEvent: .disconnect")
        }
    
    
       socketClient.onAny { (event: SocketAnyEvent) -> Void in
            print("Got event: \(event.event), with items: \(event.items!)")
        }
    
    
    
        socketClient.on(clientEvent: .connect){(data, emiterr)in
            let dic = ["page": self.page] as [String: Any]
            self.socketClient.emit("notificationsList",dic)
        
        }
    
       socketClient.connect()
        
    
        
        
    }
    
    
    func seenNotificationAray()
    {
        var seenArray = [String]()
        for i in 0 ..< self.notificationList.count{
            
            let seendata = self.notificationList[i]
                print(seendata.seen!)
            if(seendata.seen!){

            }
            else{

                seenArray.append(seendata.id!)
            }
        }
        
        let json2 = ["notifications": seenArray]
        if(seenArray.isEmpty){
                
        }
        else{
                self.socketClient.emit("notificationsSeen", with: [json2])
        }
    }
    
    
    func removeNotification(i : Int)
    {
        var seenArray = [String]()
        let seenData = self.notificationList[i]
        print(seenData.seen!)
        seenArray.append(seenData.id!)
        let json2 = ["notifications": seenArray]
       
        if(seenArray.count > 0) {
        
            self.socketClient.emit("removeNotifications", with: [json2])
            self.notificationList.remove(at: i)
        
            self.tableView.reloadData()
        }
    }
    
   func removeAllNotification()
   {
          var SeenArr = [String]()
          print(self.notificationList.count)
          for i in 0 ..< self.notificationList.count
           {
                let seenData =  self.notificationList[i]
                print(seenData.seen!)
            SeenArr.append(seenData.id!)
           }
    
    
        let json2 = ["notifications":SeenArr ]
          print(json2)
    
        if SeenArr.count > 0{
            self.socketClient.emit("removeNotifications", with: [json2])
        }
    
    }
        
    
}
//MARK:- helpers ( include form Validation and other Methods )

extension NotificationVC {
    
    func getConversationObject(indexPath: IndexPath)  {
        
        self.showNvLoader()
        
        //step 2: call getConversation .emit
        let notification = self.notificationList[indexPath.row]
       
        let productId = notification.extras?.product
        let conversation = notification.extras?.conversation
        
        //add ids to dictioanry
        let params = ["_id":  conversation!, "product_id": productId!] as[String : Any]
        
        self.socketClient.emit("getConversation", with: [params])
        
        //step 3: call getConversation Data .on
        self.socketClient.on("getConversation") { [weak self] (data, ack) in
            
            let modified =  (data[0] as AnyObject)
            
            //hide loader
            self?.hideNvloader()
            
            
            
            //Map your response Object
            if let rootModel = Mapper<RootConversationModel>().map(JSONObject: modified) {
                print(rootModel.message?.en ?? "" )
                self?.navigateToChatVC(rootModel)
            }
            else {
                nvMessage.showStatusError(body: "Response Changed")
            }
            
        }
    }
    
    //common method in convesation
    fileprivate func navigateToChatVC(_ rootModel: RootConversationModel) {
        
        let conversationId = rootModel.data?.conversation?.id
            Sharedata.shareInfo.conversationID = conversationId!
            
        let model =  rootModel.data?.conversation!
           
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let chatVc = storyboard.instantiateViewController(withIdentifier: "VCChat") as! VCChat
    
        
            chatVc.productName = setDefaultLanguage(body: (model?.product?.productName)!)
            chatVc.productPrice = setDefaultCurrency(body: (model?.product?.price)!)
            chatVc.productImage = model?.product?.image ?? ""
            
            switch myDefaultAccountType {
                
            case .seller:
                let firstName = model?.user?.firstName ?? "Unkown"
                let lastName = model?.user?.lastName ?? "name"
                let fullName = "\(firstName) \(lastName)"
                chatVc.storeOrUsername = fullName
                
            case .buyer:
                
                let storeName = setDefaultLanguage(body: (model?.store?.storeName)!)
                chatVc.storeOrUsername = storeName
                
            default:
                print("No Account Selected")
            }
        
//        if (chatVc == self.navigationController?.topViewController ) {
//            print("ignore double")
//        } else {
            self.navigationController?.pushViewController(chatVc, animated: true)
//        }
        
    
            
       
    }
    
}
