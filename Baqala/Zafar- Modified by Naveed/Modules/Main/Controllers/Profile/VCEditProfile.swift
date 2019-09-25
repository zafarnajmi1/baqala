//
//  VCEditProfile.swift
//  Baqala
//
//  Created by Macbook on 05/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import DLRadioButton
import  GooglePlaces
import GoogleMaps
import  AlamofireImage
import SocketIO
import GooglePlacePicker
import MapKit

protocol VCEditProfileDelegate:class {
    func refreshProfile()
}



class VCEditProfile: UIViewController {

    var delegate : VCEditProfileDelegate?
    var myProfileDataModel: ProfileDataModel!
    
    
    
    var location : [Double]!
    var pickLatitude : Double = 25.276987 // Default dubai location
    var pickLongitude: Double = 55.296249
    var locationManager = CLLocationManager()
    
    var socketClient: SocketIOClient!
    var soketManger: SocketManager!
    let fileName = "attachment"
    var imageUrl : URL!
    var socketImageUrl = ""
    let user = Sharedata.shareInfo
    var CameraImage = UIImagePickerController()
//    var galleryImage = UIImagePickerController()
    
    var mySelectedImage: UIImage?
    
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet weak var femaleBtn: DLRadioButton!
    @IBOutlet weak var maleBtn: DLRadioButton!
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet var myImage: UIImageView!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
   

 
 
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.myImage.setCircle()
        self.loadLocalization()
        
        self.setBackButton()
        
        self.title = "Edit Profile".localized
        self.navigationItem.hidesBackButton = false
       
        self.reloadUserProfile()
        SocketConectWithServer()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadLocalization()
        self.title = "Edit Profile".localized
        setCustomNavigationBar()
        self.setBackButton()
        //self.navigationItem.hidesBackButton = false
    }
    
    //MARK: - Base Config
    func loadLocalization()  {
    
        self.saveBtn.setTitle("SAVE".localized, for: .normal)
        self.maleBtn.setTitle("Male".localized, for: .normal)
        self.femaleBtn.setTitle("Female".localized, for: .normal)
        self.genderLabel.text = "Gender".localized
        self.firstName.placeholder = "First Name".localized
        self.lastName.placeholder = "Last Name".localized
        self.email.placeholder = "Email Address".localized
        self.phone.placeholder = "Phone Number".localized
        self.address.placeholder = "Address".localized
        let tfs = [firstName, lastName, email, phone, address] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
        self.setViewDirectionByLanguage()
    
    }
    
    
    
    func reloadUserProfile()  {
       
        self.firstName.text = self.myProfileDataModel.firstName
        self.lastName.text = self.myProfileDataModel.lastName //success.data?.lastName
        self.email.text = self.myProfileDataModel.email
        self.address.text = self.myProfileDataModel.address
        self.phone.text = self.myProfileDataModel.phone
        
        self.socketImageUrl = self.myProfileDataModel.image ?? ""

        self.myImage.kf.indicatorType = .activity
        self.myImage.kf.setImage(with: URL(string: self.myProfileDataModel.image ?? ""), placeholder: appConstant.placeHolderUser, options: nil, progressBlock: nil, completionHandler: nil)


        switch self.myProfileDataModel.gender {
       
        case "male":
             self.maleBtn.isSelected = true
        case "female":
           self.femaleBtn.isSelected = true
        default:
            self.maleBtn.isSelected = false
            self.femaleBtn.isSelected = false
        }
        
        self.location = self.myProfileDataModel.location
        //wrong index - server side fixing
        for (index , item) in location.enumerated() {
            print("\(index)-- \(item)")
            if index == 0 {
                self.pickLongitude = item
            }
            else {
                self.pickLatitude = item
            }
        }
    }
    
   
  
    @IBAction func addressBtnTapped(_ sender: UIButton) {

        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2914224267, green: 0.7155272365, blue: 0.3309046328, alpha: 1)
        self.present(placePicker, animated: true, completion: nil)
    }
    
    @IBAction func BtnSaveActionEditprofile(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if ProfileFormIsValid(){
          
            requestToUpdateprofile()
            
        }
    }
    
    func ProfileFormIsValid() -> Bool {
      
        let title = "Profile".localized
        
        if((self.firstName.text?.count)! < 2){
           
            let msg =  "Please enter valid first name".localized
            nvMessage.showError(title: title, body: msg)
            return false
            
        }
        else if((self.lastName.text?.count)! < 2 ){
            
            let msg =  "Please enter valid last name".localized
            nvMessage.showError(title: title, body: msg)
            return false
         
        }
        else if isValid(email: self.email.text!) == false {
            
            let msg =  "Please enter valid email".localized
            nvMessage.showError(title: title, body: msg)
            return false
            
        }
            
        else if((self.address.text?.count)! < 2){
            
            let msg =  "Please enter valid address".localized
            nvMessage.showError(title: title, body: msg)
            return false
            
        }
        else if (self.phone.text?.count)! < 8 {
            
            let msg =  "Please enter valid phone number".localized
            nvMessage.showError(title: title, body: msg)
            return false
          
        }
       
        
       return true
    }
    
    
    //MARK:- AP'i will Hit Here
    func requestToUpdateprofile(){
        print("socket Url \(self.socketImageUrl)")
        let gender = maleBtn.isSelected ? "male" : "female"
        
        let userprofileDic = ["email":self.email.text!,
                                             "firstName":self.firstName.text!,
                                             "lastName":self.lastName.text!,
                                             "phone":self.phone.text!,
                                             "address":self.address.text!,
                                             "latitude":self.pickLatitude,
                                             "longitude":self.pickLongitude,
                                             "gender":gender,
                                             "image":self.socketImageUrl] as [String:Any]
        
        self.showNvLoader()
        
        Userhandler.updateUserProfile(param: userprofileDic, Success: {(response) in
            
              self.hideNvloader()
            
            switch(response.success!){
            
            
            case true:
              
                let msg =  myDefaultLanguage == .en ? response.message?.en : response.message?.ar
                nvMessage.showSuccess(title:"Profile".localized, body: msg ?? "Unkown" )
                
                if (self.delegate != nil) {
                    self.delegate?.refreshProfile()
                  
                    if let image = self.mySelectedImage {
                         self.myImage.image = image
                    }
                    self.navigationController?.popViewController(animated: true)
                }
                
                
                break
                
            case false:
                
                let msg =  myDefaultLanguage == .en ? response.message?.en : response.message?.ar
                let title = "Error".localized
                nvMessage.showError(title: title , body: msg ?? "Unkown" )
                break
            }
            
        }, falioure: {(error)in
         
            let msg = error.Message
            let title = "Faliure".localized
            
            nvMessage.showError(title: title , body: msg )
        })
       
        
    }
    
    
    @IBAction func BtnEditPRofileImageActon(_ sender: UIButton) {
        
        pickImagefromDevice()
    }
    
    func pickImagefromDevice()
    {
        
        let alert = UIAlertController(title: "Pick Image", message: "Choose The Image ", preferredStyle: .actionSheet)
        
        
        let Gallry = UIAlertAction(title: "Gallery", style: .default){ (Picimg) in self.openPhotos()
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
    
    func openPhotos(){
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            let galleryImage = UIImagePickerController()
            galleryImage.delegate = self
            galleryImage.sourceType = UIImagePickerController.SourceType.photoLibrary
            galleryImage.allowsEditing = false
            present(galleryImage, animated: true, completion: nil)
        }
        
    }
    func cameraPic(){
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
           let CameraImage =  UIImagePickerController()
            CameraImage.delegate = self
            CameraImage.sourceType = .camera
            CameraImage.allowsEditing = true
           
            present(CameraImage, animated: true, completion: nil)
            
        }
        else{
            
            let alert = UIAlertController(title: "Camera", message: "Camera is not available", preferredStyle: .actionSheet)
            let alertaction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(alertaction)
            present(alert, animated: true, completion: nil)
           self.CameraImage.dismiss(animated: true, completion: nil)
        }
    }
    func cancel()
    {
        
//        self.galleryImage.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
extension  VCEditProfile: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//        dismiss(animated: true, completion: nil)
        
        guard let selectedImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else {
            dismiss(animated: true, completion: nil)
        return // Out From Func
        }
        
        let selectedImageResized = selectedImage.resizeImage(newHeight: 600)
        self.mySelectedImage = selectedImage
        
        
        let imagedata : NSData = NSData(data: selectedImageResized.jpegData(compressionQuality: 1.0)!)
        
        let imageSize : Int  = imagedata.length
        print(Double(imageSize))
        print( imagedata as Data)
        
        self.saveFileInDocDirectory(image: selectedImage)
        
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
            
            
            let modified =  (data[0] as AnyObject)
            
            let dictionary = modified as! [String: AnyObject]
            let chat = CompleteChat.init(dictionary: dictionary as NSDictionary)
            print(dictionary)
            
            let conversationId = [
                "conversation":  self.user.conversationID,
                "type" : "image/jpeg",
                
                "fileName" : chat?.data?.fileName!
                ] as [String : Any]
            
            self.socketClient.emit("sendMessage", with: [conversationId])
           
            self.hideNvloader()
            
            //*important for update image url to to reuqest update rofile
            self.socketImageUrl = (chat?.data?.fileName!)!
            
            print(self.socketImageUrl)
            
          
            self.requestToUpdateprofile()
        }

      
       picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
    }
    
    func saveFileInDocDirectory(image: UIImage) {
        
        if let savedUrl = FileManager.default.saveFileToDocumentsDirectory(image: image, name: self.fileName, extention: ".png") {
            self.imageUrl = savedUrl
            print(self.imageUrl!)
        }
    }
    
    
    
    
    //MARK:-  SOcket
    func SocketConectWithServer()
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

        
    }
    
}

extension VCEditProfile: GMSPlacePickerViewControllerDelegate {
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


extension VCEditProfile: CLLocationManagerDelegate {
    
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

