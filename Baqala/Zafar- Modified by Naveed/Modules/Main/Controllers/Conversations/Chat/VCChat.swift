//
//  VCChat.swift
//  Baqala
//
//  Created by Macbook on 06/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import  SocketIO
import  SDWebImage
import  PullToRefreshKit
import NVActivityIndicatorView
import ObjectMapper




class VCChat: UIViewController {

    var fetchingMore = false
    var productImage = ""
    var productName = ""
    var myTitle = ""
    var productPrice = ""
    var storeOrUsername = ""
    var userimg = ""
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var lblproductPrice: UILabel!
    @IBOutlet weak var lblproductName: UILabel!
    @IBOutlet weak var txtmessage: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var attchedBtn: LoaderButton!
    var socketClient: SocketIOClient!
    var soketManger: SocketManager!
    let fileName = "attachment"
    var imageUrl : URL!
    var socketImageUrl = ""
    var Page = 1
    var TotalPage = 0;
    var ObjPage = 0;
    
    var notificationid = ""
    
    var selectedImage: UIImage!
    var screenTitle : String!
   
    
    let user = Sharedata.shareInfo
    var imagePicker = UIImagePickerController()
    @IBOutlet var ChatTabelViewController: UITableView!
        {
        didSet{
            self.ChatTabelViewController.delegate = self
            self.ChatTabelViewController.dataSource = self
        }
    }
     var dataArray = [Messages]()
    
    
    //MARK:- Properties
    var productDetailModel : ProductDetailModel?
    var conversationModel: ConversationModelP?
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.loadLocalization()
        
        setCustomNavigationBar()
        setBackButton()
        self.title = self.storeOrUsername
      
        self.imageProduct.setRoundidCornerWithBorder()
        self.loadConersationInfo()
        self.configureTableViewRefresh()
        print(self.user.id!)
        print(self.userimg)
        
       
        self.getAllmessages()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        setCustomNavigationBar()
        setBackButton()
        self.title = self.storeOrUsername
    }
    
     //MARK:-  localization
    func loadLocalization()  {
        self.sendBtn.setTitle("Send".localized, for: .normal)
       
        self.txtmessage.placeholder = "Write message...".localized
        let tfs = [txtmessage] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
       
    }
    
    
    
    func loadConersationInfo(){
      
        self.lblproductName.text = self.productName
        self.lblproductPrice.text = self.productPrice
       
            let imageURL = URL(string:self.productImage)
            self.imageProduct.kf.indicatorType = .activity
            self.imageProduct.kf.setImage(with: imageURL, placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
        
        
        if productDetailModel != nil {
            let product = self.productDetailModel
            self.lblproductName.text = setDefaultLanguage(body: (product?.productName!)!)
            
            
            self.userimg = self.productDetailModel?.user?.image ?? ""
            
            
            self.lblproductPrice.text = setDefaultCurrency(body: (product?.price)!)
            let image = self.productDetailModel?.images?.first
            let imageURL = URL(string: image?.path ?? "")
            
            self.imageProduct.kf.indicatorType = .activity
            self.imageProduct.kf.setImage(with: imageURL, placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
            let title = self.productDetailModel?.user?.storeName
            self.title = setDefaultLanguage(body: title!)
        }
      
    }


    

    
    @IBAction func btnAttachClick(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Profile Picture".localized, message: nil, preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera".localized, style: .default) {
            UIAlertAction in self.openCamera()
        }
        let libraryAction = UIAlertAction(title: "Library".localized, style: .default) { (action) in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default) {
            UIAlertAction in self.cancel()
        }
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
       
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alertView  = AlertView.NotificationAlert(title: "Error".localized, message: "Camera not Available".localized, okAction:{})
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            print("Not Available")
        }
    }
    
    
    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK:- FetchPagesMoreData
    func beginBatchFetch() {
       
        fetchingMore = true
        
        print(self.ObjPage)
        print(self.TotalPage)
        
        if (self.ObjPage) < (self.TotalPage) {
        
            Page += 1
            let conversationsList = [
                "conversation":  self.user.conversationID,
                "page": Page
                
                ] as [String : Any]
            
            self.socketClient.emit("messagesList", with: [conversationsList])
            
            
            
        }
        
    }
    //MARK:- SendMessage
    @IBAction func tbnSendMessageClick(_ sender: UIButton) {
        guard let msg = txtmessage.text else {
            return
        }
        if (msg  == ""){
              self.alertMessage(message: "Write something to send".localized, completionHandler: nil)
        }
        else{
            let conversationID = [
                "conversation":  self.user.conversationID,
                "content" : msg
            ]
            self.socketClient.emit("sendMessage", with: [conversationID])
            self.txtmessage.text = ""
        }
        
        
    }
    
    //MARK:- Base Configuration
    fileprivate func configureTableViewRefresh() {
        let header = DefaultRefreshHeader.header()
        self.ChatTabelViewController.configRefreshHeader(with: header,container:self) { [weak self] in
            //call your function to update table View
            self?.dataArray.removeAll()
            self?.getAllmessages()
            if (self?.fetchingMore)! == false {
            self!.beginBatchFetch()
            }
        }
        delay(bySeconds: 0.2, closure: {
            self.ChatTabelViewController.switchRefreshHeader(to: .refreshing)
        })
        
    }
    
    
}
extension VCChat : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count == 0 ? 0: self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let arraybject = dataArray.getElement(at: indexPath.row) else {
            return UITableViewCell()
        }
       
        
        if ((arraybject.sender!) != self.user.id! )
        {
            if(arraybject.mimeType == "image/jpeg" || arraybject.mimeType == "image/png")
            {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "CellReceiverImage") as! CellReceiverImage
               
                cell.reciverimage.kf.indicatorType = .activity
                cell.reciverimage.kf.setImage(with: URL(string: arraybject.content!), placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
                
                if let date  = arraybject.createdAt {
                    cell.lblreciverImagetime.text = setTimeAgoFormatBy(dateString: date)
                }
                cell.updateFocusIfNeeded()
                 return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellReceiverMessage") as! CellReceiverMessage
                cell.lblchatdetail.text = arraybject.content!
                
                cell.userimage.kf.indicatorType = .activity
                cell.userimage.kf.setImage(with: URL(string: self.userimg), placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
                
                if let date = arraybject.createdAt{
                    cell.lbltime.text = setTimeAgoFormatBy(dateString: date)
                }
                cell.updateConstraintsIfNeeded()
                return cell
            }
        }else{
            if(arraybject.mimeType == "image/jpeg" ||   arraybject.mimeType == "image/png")
            {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSenderImage") as! CellSenderImage
                
                cell.senderimage.kf.indicatorType = .activity
                cell.senderimage.kf.setImage(with: URL(string:arraybject.content!), placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
                
                if let date = arraybject.createdAt {
                    

                    
                    cell.lblsenderimageTime.text = setTimeAgoFormatBy(dateString: date)
                }
                    cell.updateFocusIfNeeded()
                    return cell
            } else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSenderMessage") as! CellSenderMessage
                 cell.lblsenderMessage.text = arraybject.content
                if let date = arraybject.createdAt {
                    

                    cell.lblsenderTime.text = setTimeAgoFormatBy(dateString: date)
                }
                cell.updateConstraintsIfNeeded()
                return cell;
            }
            
            
        }
        
       
    }
    
    
    
}

//MARK: - Image Picker Delegates

extension  VCChat: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage){
        
           let myImage = pickedImage.resizeImage(newHeight: 600.0)
      
            
            let imgData: NSData  = NSData(data: (myImage.jpegData(compressionQuality: 1.0))!)
            
            
            let imageSize: Int = imgData.length
            print("size of image in B: %f ", Double(imageSize) )
            
            print(pickedImage.getFileSizeInMB())
            
            
            self.saveFileToDocumentDirectory(image: pickedImage)
            
            
            let imageDataforSever = [
                "name":   "test.png",
                "size" : Double(imageSize)
                ] as [String : Any]
            
            
            //self.showNvLoader()
            self.attchedBtn.showLoading()
            
            print(imageDataforSever)
            self.socketClient.emit("startFileUpload", with: [imageDataforSever])
            
            
            self.socketClient.on("startUpload") { (data, ack) in
                
                
                
                let modified =  (data[0] as AnyObject)
                
                let dictionary = modified as! [String: AnyObject]
                
                print(dictionary)
            }
            
            let imageData = imgData as Data
            let uploadChunkSize = 102400
            //   let uploadChunkSize = 5
            let totalSize = imageData.count
            var offset = 0
            self.socketClient.on("moreData") { (data, ack) in
                
                
                let modified =  (data[0] as AnyObject)
                
                let dictionary = modified as! [String: AnyObject]
                let moreData = MoreData.init(dictionary: dictionary as NSDictionary)
            
                print(dictionary)
                
                
                let imageData = imgData as Data
                imageData.withUnsafeBytes { (u8Ptr: UnsafePointer<UInt8>) in
                    let mutRawPointer = UnsafeMutableRawPointer(mutating: u8Ptr)
                    
                    print(totalSize)
                    // while offset < totalSize {
                    
                    let chunkSize = offset + uploadChunkSize > totalSize ? totalSize - offset : uploadChunkSize
                    let chunk = Data(bytesNoCopy: mutRawPointer+offset, count: chunkSize, deallocator: Data.Deallocator.none)
                    offset += chunkSize
                    let chunkSize2 = chunk.count
                    
                    
                    
                    let imageDataupload = [
                        "name":   "test.png",
                        "data" : chunk as NSData ,
                        "pointer" : moreData!.data!.pointer! ,
                        "chunkSize" : chunkSize2
                        ] as [String : Any]
                    
                    print(imageDataupload)
                    
                    self.socketClient.emit("uploadChunk", with: [imageDataupload])
                    
                }
            }
            
            self.socketClient.on("uploadCompleted") { (data, ack) in
                
//                self.hideNvloader()
                 self.attchedBtn.hideLoading()
                
                let modified =  (data[0] as AnyObject)
                
                let dictionary = modified as! [String: AnyObject]
                let chat = CompleteChat.init(dictionary: dictionary as NSDictionary)
                print(dictionary)
                
                let conversationID = [
                    "conversation":  self.user.conversationID,
                    "type" : "image/jpeg",
                    
                    "fileName" : chat?.data?.fileName! ?? ""
                    ] as [String : Any]
                
                self.socketClient.emit("sendMessage", with: [conversationID])
                
                
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveFileToDocumentDirectory(image: UIImage) {
        
        if let savedUrl = FileManager.default.saveFileToDocumentsDirectory(image: image, name: self.fileName, extention: ".png") {
            self.imageUrl = savedUrl
            print(self.imageUrl!)
        }
    }
    
    
    
    func notificationSeenLlist() {
       
        var SeenArr = [String]()
        SeenArr.append(notificationid)
        let json2 = [
            "notifications": SeenArr
        ]
        print(json2)
        if(SeenArr.isEmpty){
            
        }else{
            self.socketClient.emit("notificationsSeen", with: [json2])
        }
    }
    
}

extension VCChat {
    
    fileprivate func socketConnect(_ userToken: String) {
        let usertoken = ["token":  userToken]
        
        let specs: SocketIOClientConfiguration = [
            .forcePolling(false),
            .forceWebsockets(true),
            .path("/projects/baqala/socket.io"),
            .connectParams(usertoken as [String : Any]),
            .log(true),
            .reconnects(true)
            
        ]
        
   
        //Socket URL
        self.soketManger = SocketManager(socketURL: URL(string:"https://hello-stream.com/projects/baqala/")! , config: specs)
        
        self.socketClient = soketManger.defaultSocket
        //socket connection
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
    }
    
    func getAllmessages() {
        
       
        
        if let userToken = Sharedata.shareInfo.authToken {
            
            //Connect Socket
            self.socketConnect(userToken)
            
            
            
            self.socketClient.on("newConversation") { (data, ack) in
                let modified =  (data[0] as AnyObject)
            
                if let rootModel = Mapper<RootConversationModel>().map(JSONObject: modified) {
                    print(rootModel.message?.en ?? "" )
                    
                    Sharedata.shareInfo.conversationID = (rootModel.data?.conversation?.id)!
                    
                }
                
                
                let conversationID = [
                    "conversation":  self.user.conversationID,
                    "page": self.Page
                    
                    ] as [String : Any]
                
                self.socketClient.emit("messagesList", with: [conversationID])
                
            }
            
            self.socketClient.on("getConversation") { (data, ack) in
                let modified =  (data[0] as AnyObject)
                
                let dictionary = modified as! [String: AnyObject]
                
                print(dictionary)
                
                let Conversation = NewConversation.init(dictionary: dictionary as NSDictionary)
                
                self.user.conversationID = (Conversation?.data?.conversation?._id!)!
                self.user.personID = (Conversation?.data?.conversation?.user?._id!)!
                let fullname = (Conversation?.data?.conversation?.user?.firstName!)! + (Conversation?.data?.conversation?.user?.lastName!)!
                self.user.chatTitle = fullname
                
                print( self.user.conversationID)
                
                let conversationID = [
                    
                    "conversation":  self.user.conversationID,
                    "page": self.Page
                    
                    ] as [String : Any]
                print(conversationID)
                self.socketClient.emit("messagesList", with: [conversationID])
                
            }
            
            self.socketClient.on("messagesList") { (data, ack) in
                let modified =  (data[0] as AnyObject)
                
                let dictionary = modified as! [String: AnyObject]
                
                print(dictionary)
                
                let Conversation = ChatModel.init(dictionary: dictionary as NSDictionary)
                
                
                self.dataArray +=  (Conversation?.data?.messages ?? [])
                
                self.TotalPage = (Conversation?.data?.pagination?.pages ?? 0)
                print(self.TotalPage)
                self.ObjPage =  (Conversation?.data?.pagination?.page ?? 0)
                self.fetchingMore = false
                
                
                
                self.ChatTabelViewController.delegate = self
                self.ChatTabelViewController.dataSource = self
                
                self.ChatTabelViewController.reloadData()
                self.stopAnimating()
                
                self.ChatTabelViewController.switchRefreshHeader(to: .normal(.success, 0.0))
                if( self.dataArray.count == 0) {
                    
                }
                else{
                    
                    print(self.user.conversationArray.count)
                    if(self.user.conversationArray.isEmpty){
                        
                    }else{
                        if(self.user.conversationArray[self.user.conversationTableId].user?._id == Sharedata.shareInfo.id ){
                            
                            self.screenTitle =  self.user.conversationArray[self.user.conversationTableId].store?.storeName?.en
                            if(self.screenTitle == nil || self.screenTitle == "")
                            {
                                self.title = self.storeOrUsername
                            }
                            else
                            {
                                self.title = self.storeOrUsername
                            }
                        }
                        else{
                            self.screenTitle =  self.user.conversationArray[self.user.conversationTableId].user?.firstName
                            if(self.screenTitle == nil || self.screenTitle == "")
                            {
                                self.title = self.storeOrUsername
                            }
                            else
                            {
                                self.title = self.storeOrUsername
                            }
                        }
                    }
                    
                    
                    
                    self.ChatTabelViewController.scrollToRow(at: IndexPath.init(row: self.dataArray.count - 1, section: 0), at: .bottom, animated: false)
                    
                }
                
                
                //self.stopAnimating()
                
            }
            
            
            
            self.socketClient.on("conversationsList") { (data, ack) in
                let conversationID = [
                    "conversation":  self.user.conversationID,
                    "page": self.Page
                    
                    ] as [String : Any]
                print(conversationID)
                self.socketClient.emit("messagesList", with: [conversationID])
            }
            self.socketClient.on("newMessage") { (data, ack) in
                
                let modified =  (data[0] as AnyObject)
                
                let dictionary = modified as! [String: AnyObject]
                
                print( dictionary)
                
                let objData = NewMessageModel.init(dictionary: dictionary as NSDictionary)
                
                //    print(objData?.data!.data_new_message!)
                if(objData?.data!.data_new_message! != nil)
                {
                    self.dataArray.append((objData?.data!.data_new_message!)!)
                    
                    if self.dataArray.count > 0
                    {
                        self.ChatTabelViewController.reloadData()
                        //   self.updateTableContentInset()
                        self.ChatTabelViewController.scrollToRow(at: IndexPath.init(row: self.dataArray.count - 1, section: 0), at: .bottom, animated: false)
                    }
                    
                }
                
                
                let conversationID = [
                    "conversation":  self.user.conversationID
                    //  "page":  2
                    
                    ] as [String : Any]
                print(conversationID)
                //  self.socket.emit("messagesList", with: [conversationID])
            }
            
             // handle connected
            self.socketClient.on(clientEvent: .connect) {data, emitter in
               
                
                ///fetch notification
                self.notificationSeenLlist()
               
                
                //fetch message List
                
                let params = ["conversation":  self.user.conversationID,
                          "page": self.Page] as [String : Any]
                self.socketClient.emit("messagesList", with: [params])
             
            }
            
            
            
            self.socketClient.onAny { (event: SocketAnyEvent) -> Void in
                print("Got event: \(event.event), with items: \(event.items!)")
            }
            
            self.socketClient.connect()
            self.socketClient.on(clientEvent: .disconnect, callback: { (data, emitter) in
                //handle diconnect
            })
            //self.stopAnimating()
            //self.finishLoading()
        }
    }
    
    
}


extension Array {
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}




