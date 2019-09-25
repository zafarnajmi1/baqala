//
//  ProductDetailVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import PullToRefreshKit
import MIBadgeButton_Swift
import SocketIO
import ObjectMapper

class ProductDetailVC: UIViewController {
    //MARK:- outlets
    @IBOutlet weak var tableView:UITableView!
    
    
    //MARK:- properties and Structures
    var id = "0"
    var myRootProductDetailModel = RootProductDetailModel()
    let badgeBtn = MIBadgeButton(type: .custom)//UIButton(type: .custom)
    
    //socket variables
    var socketClient: SocketIOClient!
    var soketManger: SocketManager!
    let fileName = "attachment"
    var imageUrl : URL!
    var socketImageUrl = ""
    var Page = 1
    var TotalPage = 0;
    var ObjPage = 0;
    
   
   
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //setup custom navigation bar
    
       viewWillAppear(false)
        
        // Do any additional setup after loading the view.
        self.tableView.registerCustomCell(withCellId: "ProductDetailTableViewCell")
        self.configureTableViewRefresh()
        
        if myDefaultAccountType == .buyer {
            self.navigationBtnsBuyerProductDetail()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.setCustomNavigationBar()
        self.setBackButton()
        self.title = "Product Detail".localized
       
    }
    
   //MARK:- actions
    
    
    //MARK:- base configuration ( on load View)
    
    fileprivate func configureTableViewRefresh() {
        let header = DefaultRefreshHeader.header()
        self.tableView.configRefreshHeader(with: header,container:self) { [weak self] in
            //call your function to update table View
            self?.requestToFetchProductDetailList()
            
        }
        delay(bySeconds: 0.2, closure: {
            self.tableView.switchRefreshHeader(to: .refreshing)
        })
        
    }
    
    
    func navigationBtnsBuyerProductDetail(){
        
        let msgBtn = UIButton(type: .custom)
        msgBtn.setImage(UIImage(named: "Messages"), for: .normal)
        msgBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        msgBtn.addTarget(self, action: #selector(btnMessageTapped(_:)), for: .touchUpInside)
        
        msgBtn.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        msgBtn.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        let callBtn = UIButton(type: .custom)
        callBtn.setImage(UIImage(named: "Call"), for: .normal)
        callBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        callBtn.addTarget(self, action: #selector(btnCallTapped(_:)), for: .touchUpInside)
        
        callBtn.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        callBtn.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        
        let msgBarBtn = UIBarButtonItem(customView: msgBtn)
        let callBarBtn = UIBarButtonItem(customView: callBtn)
        //add buttons to navigationsBaR RightBarButtonItems
        self.navigationItem.setRightBarButtonItems([callBarBtn,msgBarBtn], animated: true)
    }
    
    
    @objc func btnCallTapped (_ sender: Any){

        let phone = self.myRootProductDetailModel.data?.user?.phone
        if phone == nil {
            nvMessage.showError(body: "Phone Number Not Found".localized)
        }
        else {
            callNumber(phoneNumber: phone!)
        }
       
    }
    
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                    
                }
            }
        }
    }
    
    @objc func btnMessageTapped (_ sender: Any)
    {
        
        self.conectSocketWithServer()
    }

}




//MARK:- ws: Web Services Requests

extension ProductDetailVC {
    
    func requestToFetchProductDetailList() {
       
         ProductManager.shared.fetchProductDetail(id: self.id) { (error, rootModel) in
           
            if error == nil {
                self.myRootProductDetailModel = rootModel!
                self.tableView.reloadData()
                self.tableView.switchRefreshHeader(to: .normal(.success, 0.0))
            }
            else {
                nvMessage.showError(body: error!)
                self.tableView.switchRefreshHeader(to: .normal(.failure, 0.0))
            }
        }
    }
    
}
//MARK:- tableView Extension
extension ProductDetailVC: UITableViewDelegate, UITableViewDataSource, ProductDetailTableViewCellDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (self.myRootProductDetailModel.data != nil) {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell") as! ProductDetailTableViewCell
        cell.myController = self
        cell.delegate = self
        
        let model = self.myRootProductDetailModel.data
        cell.setData(model: model!)
        
        
        return cell
    }
    
    
    func addToCartBtnDidTap(BadgNumber: Int) {
        if BadgNumber > 0 {
            badgeBtn.showBadge()
            badgeBtn.badgeString = "\(BadgNumber)"
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}

//MARK:- Socket Implemtation
extension ProductDetailVC{
    //Connect Socket
    
    //MARK:-  SOcket
    func conectSocketWithServer()
    {
        print(Sharedata.shareInfo.authToken!)
        let userToken = Sharedata.shareInfo.authToken
        let params = ["token":  userToken!] as [String : Any]
        
        let specs: SocketIOClientConfiguration = [
            .forcePolling(false),
            .forceWebsockets(true),
            .path("/projects/baqala/socket.io"),
            .connectParams(params ),
            .log(true),
            .reconnects(true)
            
        ]
        print(specs)
        self.soketManger = SocketManager(socketURL: URL(string:"https://hello-stream.com/projects/baqala/")! , config: specs)
        
        self.socketClient = soketManger.defaultSocket
        
        self.socketClient.onAny { (event: SocketAnyEvent) -> Void in
            print("Got event: \(event.event), with items: \(event.items!)")
        }
        
        
        
        self.socketClient.connect()
        
        
         self.socketClient.on(clientEvent: .connect) {data, emitter in
        
            self.getConversationObject()
        
        }
    }
    
    
    
    
   
    
    func getConversationObject()  {
        
          self.showNvLoader()
        
        //step 2: call getConversation .emit
 
            let model = self.myRootProductDetailModel.data
            let productId = model?.id
            let storeId = model?.user?.id
         
            //add ids to dictioanry
            let params = ["store":  storeId!, "product": productId!] as[String : Any]
            
            self.socketClient.emit("getConversation", with: [params])
        
         //step 3: call getConversation Data .on
           self.socketClient.on("getConversation") { (data, ack) in
            
            let modified =  (data[0] as AnyObject)
            
            //hide loader
            self.hideNvloader()
            
          

            //Map your response Object
            if let rootModel = Mapper<RootConversationModel>().map(JSONObject: modified) {
                print(rootModel.message?.en ?? "" )
                self.navigateToChatVC(rootModel)
            }
            else {
                    nvMessage.showStatusError(body: "Response Changed")
                 }
        
            }
    }
    
    
    fileprivate func navigateToChatVC(_ rootModel: RootConversationModel) {
       
        if let conversationId = rootModel.data?.conversation?.id {
            //importan save
            Sharedata.shareInfo.conversationID = conversationId
            
            let  storydoard = UIStoryboard(name: "Main", bundle: nil)
            let vc =   storydoard.instantiateViewController(withIdentifier: "VCChat") as! VCChat
            vc.productDetailModel = self.myRootProductDetailModel.data
            let name = self.myRootProductDetailModel.data!.user?.storeName
            vc.storeOrUsername = setDefaultLanguage(body: name!)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            nvMessage.showError(title: "Conversation ID", body: "Result not found")
        }
    }
   
    
    
}
    
 

