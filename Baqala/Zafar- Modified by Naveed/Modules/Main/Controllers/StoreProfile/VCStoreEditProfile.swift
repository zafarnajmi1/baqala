//
//  VCStoreEditProfile.swift
//  Baqala
//
//  Created by Macbook on 06/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import  GoogleMaps
import GooglePlaces
import GooglePlacePicker
import MapKit


import SocketIO
import  NVActivityIndicatorView
protocol storeProfileUrl {
    func storeImgUrlString(string: String)
}
class VCStoreEditProfile: UIViewController {

    @IBOutlet weak var imgStoreProfile: UIImageView!
    var CameraImage = UIImagePickerController()
    var galleryImage = UIImagePickerController()
    
    var socketClient: SocketIOClient!
    var soketManger: SocketManager!
    let fileName = "attachment"
    var imageUrl : URL!
    var imagePath: String?
    var socketImageUrl = ""
    let user = Sharedata.shareInfo
    var storeDelegate:storeProfileUrl?
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var descEn: UITextView!
    
    @IBOutlet weak var descAr: UITextView!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var storeNameEn: UITextField!
    @IBOutlet weak var storeNameAr: UITextField!
    @IBOutlet weak var descArView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var storeNameArView: UIView!
    @IBOutlet var storeDescView: UIView!
    @IBOutlet var StoreAddressUiview: UIView!
    @IBOutlet var StoreNameUiview: UIView!
    
    var location = [Double]()
    var mySelectedImage: UIImage?
 
    
    
    
    var pickLatitude : Double!
    var pickLongitude: Double!
    var locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadLocalization()
        self.setBackButton()
        self.title = "Edit Store Profile".localized
        self.applyTheme()
        
        self.address.delegate = self
    
        self.getStoreProfile()
        connectSocketWithServer()
    }
    

   
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadLocalization()
        self.title = "Edit Store Profile".localized
        self.setBackButton()
        self.applyTheme()
    }
    
    
    
    func loadLocalization()  {
        
        self.saveBtn.setTitle("SAVE".localized, for: .normal)
       
        self.storeNameEn.placeholder = "Store Name En".localized
        self.storeNameAr.placeholder = "Store Name Ar".localized
        self.address.placeholder = "Email Address".localized
        self.phone.placeholder = "Phone Number".localized
        self.address.placeholder = "Address".localized
        let tfs = [storeNameEn, storeNameAr, address, phone] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
        let tv = [descEn, descAr] as [UITextView]
        self.setTextViewDirectionByLanguage(textViews: tv)
        self.setViewDirectionByLanguage()
    }
    
    fileprivate func applyTheme() {
        self.StoreAddressUiview.setLightGrayBorder()
        self.StoreNameUiview.setLightGrayBorder()
        self.storeDescView.setLightGrayBorder()
        self.descArView.setLightGrayBorder()
        self.phoneView.setLightGrayBorder()
        self.storeNameArView.setLightGrayBorder()
    }
    
    
    func getStoreProfile() {
     
        //self.ShowProccess()
        self.showNvLoader()
        
        Userhandler.StoreProfile(Success: {(response)in
            
           self.hideNvloader()
            
            switch(response.success!) {
            case true:
             
                self.storeNameEn.text = response.data?.storeName?.en
                self.storeNameAr.text = response.data?.storeName?.ar
                self.address.text = response.data?.address
                self.phone.text = response.data?.phone
                self.descAr.text = response.data?.description?.ar
                self.descEn.text = response.data?.description?.en
                let imgUrl = URL(string: response.data?.image ?? "")
                self.imagePath = response.data?.image ?? ""
            
                Sharedata.shareInfo.userImage = response.data?.image
                self.imgStoreProfile.kf.indicatorType = .activity
                self.imgStoreProfile.kf.setImage(with: imgUrl , placeholder: appConstant.storeCatePh, options: nil, progressBlock: nil, completionHandler: nil)
                
                
                
                self.location = (response.data?.location)!
                self.pickLatitude = self.location[0]
                self.pickLongitude = self.location[1]
                break
            case false:
                self.hideNvloader()
                let msg = setDefaultLanguage(body: response.message!)
                nvMessage.showError(title: (self.title?.localized)!, body: msg)
                break
            }
            
        }, fail: {(error)in
            self.hideNvloader()
           
            nvMessage.showError(body: error.Message)
        })
        
    }
    

    @IBAction func btnSaveAction(_ sender: UIButton) {
       
        self.view.endEditing(true)
      
        if formIsValid(){
            requestToUpdateStoreProfile()
        }
    }
    
    
     func formIsValid()-> Bool {
        
        let title = self.title!.localized
        
        if((self.storeNameEn.text?.count)! < 2){
            
            let msg =  "Please enter valid Store name in English".localized
            nvMessage.showError(title: title, body: msg)
            return false
            
        }
        else if((self.storeNameAr.text?.count)! < 2 ){
            
            let msg =  "Please enter valid Store Name in Arabic".localized
            nvMessage.showError(title: title, body: msg)
            return false
            
        }
        
        else if (self.phone.text?.count)! < 8 {
            
            let msg =  "Please enter valid phone number".localized
            nvMessage.showError(title: title, body: msg)
            return false
            
        }
        else if((self.address.text?.count)! < 2){
            
            let msg =  "Please enter valid address".localized
            nvMessage.showError(title: title, body: msg)
            return false
            
        }
        
        else if((self.descAr.text?.count)! < 2){
            
            let msg =  "Please enter valid Description In English".localized
            nvMessage.showError(title: title, body: msg)
            return false
            
        }
        else if((self.descAr.text?.count)! < 2){
            
            let msg =  "Please enter valid Description In Arabic".localized
            nvMessage.showError(title: title, body: msg)
            return false
            
        }
       
        
        return true
    }
    
    func requestToUpdateStoreProfile()
    {
        print(self.storeNameEn.text!)
        
        //"productName": [self.lang! : self.titletxtField.text!],
        let storeName = ["en":self.storeNameEn.text!,
                         "ar": self.storeNameAr.text!] as [String: Any]
        let desc = ["en":self.descEn.text!,
                    "ar":self.descAr.text!] as [String: Any]
     
        var storeDic : [String:Any] = ["storeName": storeName,
                                       "description":desc,
                                       "address":self.address.text!,
                                       "latitude": self.pickLatitude,
                                       "longitude":self.pickLongitude,
                                       "phone": phone.text!]
        
        if socketImageUrl == "" {
            storeDic.updateValue(self.imagePath!, forKey: "image")
        }
        else {
           storeDic.updateValue(self.socketImageUrl, forKey: "image")
        }

       // self.ShowProccess()
        self.showNvLoader()
        Userhandler.StoreUpdateProfile(param: storeDic as NSDictionary , Success: {(response)in
           
            self.hideNvloader()
            
            switch(response.success!) {
                
            case true:
                //self.stopAnimating()
                 Sharedata.shareInfo.userImage = self.socketImageUrl
                
                 let msg = setDefaultLanguage(body: response.message!)
                 nvMessage.showSuccess(title: (self.title?.localized)!, body: msg )
                 
                 
                 
                 self.storeDelegate?.storeImgUrlString(string: "image Updated")
                 
                 if let image = self.mySelectedImage {
                      self.imgStoreProfile.image = image
                 }
                 self.navigationController?.popViewController(animated: true)
              
                break
               
            case false:
               
                let msg = setDefaultLanguage(body: response.message!)
                nvMessage.showError(title: (self.title?.localized)!, body: msg )
                
                break
            }
            
        }, falioure: {(error)in
            
            self.hideNvloader()
            let alertView  = AlertView.NotificationAlert(title: "Error".localized, message: error.Message, okAction:{
                self.requestToUpdateStoreProfile()
            })
            self.present(alertView, animated: true, completion: nil)
            
            
            
        })
        }
    
    
    @IBAction func BtnEditImageActionStoreProfile(_ sender: UIButton) {
        PicKImage()
    }
    func PicKImage()
    {
        
        let alert = UIAlertController(title: "Pick Image", message: "Choose The Image ", preferredStyle: .actionSheet)
        
        
        let Gallry = UIAlertAction(title: "Gallery", style: .default){ (Picimg) in self.GalleryPic()
        }
        let camraimg = UIAlertAction(title: "Camera", style: .default){ (ac) in self.cameraPic()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){(action) in self.cancel()
            
        }
        
        alert.addAction(Gallry)
        alert.addAction(camraimg)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    func GalleryPic(){
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary))
        {
            galleryImage.delegate = self
            galleryImage.sourceType = UIImagePickerController.SourceType.photoLibrary
            galleryImage.allowsEditing = false
            present(galleryImage, animated: true, completion: nil)
        }
        
    }
    func cameraPic(){
        if(UIImagePickerController.isSourceTypeAvailable(.camera))
        {
            CameraImage.delegate = self
            CameraImage.allowsEditing = false
            CameraImage.sourceType = .camera
            present(CameraImage, animated: true, completion: nil)
            
        }else{
            
            let alert = UIAlertController(title: "Camera", message: "Camera is not available", preferredStyle: .actionSheet)
            let alertaction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(alertaction)
            present(alert, animated: true, completion: nil)
            //self.CameraImage.dismiss(animated: true, completion: nil)
        }
    }
    func cancel(){
        
        self.galleryImage.dismiss(animated: true, completion: nil)
    }
    
}


extension VCStoreEditProfile: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == address{
            let config = GMSPlacePickerConfig(viewport: nil)
            let placePicker = GMSPlacePickerViewController(config: config)
            placePicker.delegate = self
            UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2914224267, green: 0.7155272365, blue: 0.3309046328, alpha: 1)
            self.present(placePicker, animated: true, completion: nil)
          
        }
    }
    
}

    
    
    

extension  VCStoreEditProfile: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: {
            self.tabBarController?.selectedIndex = 3
        })
        
        
        if let selectedImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage){
           
            let selectedImageResized = selectedImage.resizeImage(newHeight: 600)
            self.mySelectedImage = selectedImage
            let imagedata : NSData = NSData(data: selectedImageResized.jpegData(compressionQuality: 1.0)!)
            
            let imageSize : Int  = imagedata.length
            print(Double(imageSize))
            print( imagedata as Data)
            
            self.saveFileToDocumentDirectory(image: selectedImage)
            
            //self.ShowProccess()
            self.showNvLoader()
            
            let ImageDataToServer: [String:Any] = ["name": "test.png",
                                                   "size": Double(imageSize)]
            print(ImageDataToServer)
            
            self.socketClient.emit("startFileUpload", with: [ImageDataToServer])
            
            self.socketClient.on("startUpload"){(data, ack)in
                let changeData = (data[0] as AnyObject)
                let ImagDictinary = changeData as! [String:AnyObject]
                print(ImagDictinary)
            }
            
            
            let imgData = imagedata as Data
            let uploadChunksize = 102400
            let totalsize = imgData.count
            var offset = 0
            
            
            
            self.socketClient.on("moreData"){(data, ack)in
                
                let modified = (data[0] as AnyObject)
                let OtherImageDictinary = modified as! [String: AnyObject]
                let moredata = MoreData(dictionary: OtherImageDictinary as NSDictionary)
                print(OtherImageDictinary)
                
                let imageData = imagedata as Data
                imageData.withUnsafeBytes{(u8Ptr:UnsafePointer<UInt8>)in
                    let mutRawPointer = UnsafeMutableRawPointer(mutating: u8Ptr)
                    print(totalsize)
                 
                    let chunkSize = offset + uploadChunksize > totalsize ? totalsize - offset : uploadChunksize
                    let chunk = Data(bytesNoCopy: mutRawPointer+offset, count: chunkSize, deallocator: Data.Deallocator.none)
                    offset += chunkSize
                    
                    let chunkSize2 = chunk.count
                    
                    let imageDataupload:[String : Any]  = [
                        "fileName":   "test.png",
                        "data" : chunk as NSData ,
                        "pointer" : moredata!.data!.pointer! ,
                        "chunkSize" : chunkSize2
                    ]
                    
                    
                    print(imageDataupload)
                    
                    self.socketClient.emit("uploadChunk", with: [imageDataupload])
                    
                }
            }
            
            self.socketClient.on("uploadCompleted") { (data, ack) in
                
                self.hideNvloader()
                
                let modified =  (data[0] as AnyObject)
                
                let dictionary = modified as! [String: AnyObject]
                let chat = CompleteChat.init(dictionary: dictionary as NSDictionary)
                print(dictionary)

                if chat?.success == true {
                    print("file is uploaded")
                    
                    self.socketImageUrl = (chat?.data?.fileName!)!
                    self.requestToUpdateStoreProfile()

                }
                else {
                    print("upload failed")
                }
            }
          
            
        }
        
        
    }//
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: false, completion: nil)
    }
    
    func saveFileToDocumentDirectory(image: UIImage) {
        
        if let savedUrl = FileManager.default.saveFileToDocumentsDirectory(image: image, name: self.fileName, extention: ".png") {
            self.imageUrl = savedUrl
            print(self.imageUrl!)
        }
    }
    
    
    
    
    //MARK:-  SOcket
    func connectSocketWithServer()
    {
        print(Sharedata.shareInfo.authToken!)
        let userToken = Sharedata.shareInfo.authToken
        let usertoken = [
            "token":  userToken!
        ]
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
        
        self.socketClient.onAny { (event: SocketAnyEvent) -> Void in
            print("Got event: \(event.event), with items: \(event.items!)")
        }
        
        self.socketClient.connect()
        
        
    }
    
    
    
}


extension VCStoreEditProfile: GMSPlacePickerViewControllerDelegate {
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        //in self view
        // self.location = place.coordinate
        self.pickLatitude =  place.coordinate.latitude
        self.pickLongitude = place.coordinate.longitude
        //update location in Global
        Sharedata.shareInfo.userLatitude = place.coordinate.latitude
        Sharedata.shareInfo.userLongitude = place.coordinate.longitude
        //formate address
        if place.formattedAddress != nil {
            self.address.text = place.formattedAddress!
        }
        else {
            let coordinate = "selected coordinat: \(place.coordinate.latitude), \(place.coordinate.longitude)"
            self.address.text = "Unkown Address, \(coordinate)"
        }
        
        
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        nvMessage.showError(body: error.toJSONString() ?? "didFailAutocompleteWithError")
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}


extension VCStoreEditProfile: CLLocationManagerDelegate {
    
    fileprivate func determineMyCurrentLocation() {
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
            
            
        }
    }
    
    
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            nvMessage.showError(body: "User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            locationManager.stopUpdatingLocation()
        }
    }
    
    // Handle location manager errors.
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = location?.coordinate.latitude
        let long = location?.coordinate.longitude
        
        
        //update user current location in Global
        Sharedata.shareInfo.userLatitude = lat
        Sharedata.shareInfo.userLongitude = long
        
        
        
    }
}
