//
//  VCHome.swift
//  Baqala
//
//  Created by Macbook on 04/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import MapKit
import  GoogleMaps
import GooglePlaces
import MIBadgeButton_Swift
import DropDown
import GradientLoadingBar
import GooglePlacePicker
import SocketIO
import ObjectMapper

class VCHome: UIViewController {

    struct MyPlace {
        var name: String
        var lat: Double
        var long: Double
    }
    
   
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var txtyourlocation: UITextField!
    @IBOutlet var txtSearchProduct: UITextField!
    @IBOutlet weak var searchLocationView: UIView!
    @IBOutlet weak var gpsBtn: UIButton!
   
    
    //dropdown outlets
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var subCategoryButton: UIButton!
    @IBOutlet var lblcategories: UILabel!
    @IBOutlet var lblSubCategories: UILabel!
    
    //dropdown instance and intialization
    let categoryDropDown = DropDown()
    let subtCategoryDropDown = DropDown()
    //this attribute use is optional - target for all dropdowns customization
    lazy var dropDowns: [DropDown] = { return[
        self.categoryDropDown,
        self.subtCategoryDropDown
        ] }()
    
    //Root Model
    var myRootCategoryModel = RootCategoryModel()
    var myRootSubCategoryModel = RootCategoryModel()
    var categoryModel: CategoryModel?
    var subCategoryModel: CategoryModel?
    
    //Root Model for storelisting
    var myRootStoreModel = RootStoreModel()
    
    //Location
    var userSelectedLocation: CLLocationCoordinate2D?
    private let locationManager = CLLocationManager()
    var currentmarker = GMSMarker()
   
    let cartBadgeBtn = MIBadgeButton(type: .custom)
    let notificationBadgeBtn = MIBadgeButton(type: .custom)
    var categoryLoadingBar: GradientLoadingBar!
    var subCategoryLoadingBar: GradientLoadingBar!
    
 
    //Socket
    var myRootNotificationModel = RootNotificationModel()
    var notificationList = [NotificationModel2]()
      //Socket Properites
    var socketClient: SocketIOClient!
    var soketManger: SocketManager!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        self.setupGradiantLoader()
        
        viewWillAppear(true)
      
    }
   
    
    
    override func viewWillAppear(_ animated: Bool){

        // set tab title
        self.loadLocalization()
        self.title = "Home".localized
        Sharedata.shareInfo.notificationCount = ""
        
        // optionally, set different title for navigation controller
        self.navigationItem.title = "Baqala".localized
     
        //set ur location
        self.determineMyCurrentLocation()
        
        
        setCustomNavigationBar()
        self.searchLocationView.setLightShadow()
        self.setBarBtnsByAccountType(cartBadgeBtn: cartBadgeBtn )
        self.refresh(cartBadgeBtn: cartBadgeBtn)
        
       
        
        //service calls
        self.setupDropDowns()
        // self.refreshNotification()
        self.requestToFetchStoreListByUserLocation(lat: nil, long: nil)
        
        
        
        //API Calls
        switch myDefaultAccountType {
            
        case .buyer:
            self.requestToRefreshMyCartList()
        default: // seller
            //Socket Call
            self.requestToSocketGetNotificationList()
        }
     
    }
    
    
  
    //MARK:- Base configuration
    
    func loadLocalization() {
      
        self.txtSearchProduct.placeholder = "Search your Product".localized
        self.txtyourlocation.placeholder = "Your Location".localized
        self.lblcategories.text = "Categories".localized
        self.lblSubCategories.text = "Subcategories".localized
        
        let tfs = [txtSearchProduct, txtyourlocation] as [UITextField]
        setTextFieldDirectionByLanguage(textFields: tfs)
        setViewDirectionByLanguage()
       
        switch myDefaultLanguage {
        case .ar:
            categoryDropDown.anchorView = subCategoryButton
            subtCategoryDropDown.anchorView = categoryButton

           
        default:
            categoryDropDown.anchorView = categoryButton
            subtCategoryDropDown.anchorView = subCategoryButton
        }
    }
    
    
    
    
    
    
    fileprivate func setupGradiantLoader() {
        //Setuploader
        
        categoryLoadingBar = BottomGradientLoadingBar(height: 2, durations: Durations.default, gradientColorList: [#colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1), #colorLiteral(red: 0.5229000449, green: 0.6485285163, blue: 0.1439691782, alpha: 1), #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)], isRelativeToSafeArea: true, onView: self.categoryButton )
        subCategoryLoadingBar = BottomGradientLoadingBar(height: 2, durations: Durations.default, gradientColorList: [#colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1), #colorLiteral(red: 0.5229000449, green: 0.6485285163, blue: 0.1439691782, alpha: 1), #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)], isRelativeToSafeArea: true, onView: self.subCategoryButton )
    }
    
    fileprivate func determineMyCurrentLocation() {
        
        
        self.mapView.delegate = self
        self.mapView.isMyLocationEnabled = true
       // self.mapView.settings.myLocationButton = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            
      
        }
        
       // let _ = self.didTapMyLocationButton(for: self.mapView)
        self.gpsBtnTapped(gpsBtn)
    }
    

 

    //MyLocation button default method
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        //empty your text field on current location
        self.txtyourlocation.text = ""
       
        let mylocation = locationManager.location?.coordinate
        if mylocation?.latitude == nil {
            return true
        }
        let camera = GMSCameraPosition.camera(withLatitude: (mylocation?.latitude)! , longitude: (mylocation?.longitude)!, zoom: 12.0)
        self.mapView.animate(to: camera)
      
        
        Sharedata.shareInfo.userLatitude = mylocation?.latitude
        Sharedata.shareInfo.userLongitude = mylocation?.longitude
        
        self.requestToFetchStoreListByUserLocation(lat: mylocation?.latitude, long: mylocation?.longitude)
    
        return true
        
    }
    
    //location TextField tapped
    @IBAction func gpsBtnTapped(_ sender: UIButton) {
        //empty your text field on current location
        self.txtyourlocation.text = ""
        
        let mylocation = locationManager.location?.coordinate
        
        if mylocation?.latitude != nil {
            let camera = GMSCameraPosition.camera(withLatitude: (mylocation?.latitude)! , longitude: (mylocation?.longitude)!, zoom: 12.0)
            self.mapView.animate(to: camera)
            
            
            Sharedata.shareInfo.userLatitude = mylocation?.latitude
            Sharedata.shareInfo.userLongitude = mylocation?.longitude
            
            self.requestToFetchStoreListByUserLocation(lat: mylocation?.latitude, long: mylocation?.longitude)
        }
        
        
       
    }
    
    
    //location Btn tapped
    @IBAction func BtnLocationAction(_ sender: UIButton) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2914224267, green: 0.7155272365, blue: 0.3309046328, alpha: 1)
        self.present(placePicker, animated: true, completion: nil)
    }
    
  
   
    //Move to search Product List
    @IBAction func searchBtnTapped(_ sender: UIButton) {
     
     
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductSearchVC") as! ProductSearchVC
        //for listing
        vc.myRootCategoryModel = self.myRootCategoryModel
        vc.myRootSubCategoryModel = self.myRootSubCategoryModel
        // for fill labels
        vc.categoryModel = self.categoryModel
        vc.subCategoryModel = self.subCategoryModel
        vc.searchString = self.txtSearchProduct.text!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    
}

  // MARK:- dropdown setup

extension VCHome {
    
    @IBAction func categoryBtnTapped(_ sender: AnyObject) {
        if myRootCategoryModel.data == nil {
            requestToFetchCatgoryList()
        }
        self.categoryDropDown.show()
    }
    @IBAction func subcategoryBtnTapped(_ sender: AnyObject) {
        self.subtCategoryDropDown.show()
    }
    
  
    func setupDropDowns() {
        self.requestToFetchCatgoryList()
        setupCategoryDropDown(list: nil )
        setupSubCategoryDropDown(list: nil)
    }
    
    func setupCategoryDropDown(list:[String]?  ) {
        
        categoryDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .center
        
        }
        categoryDropDown.bottomOffset = CGPoint(x: 0, y: categoryButton.bounds.height)
      
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        var mylist = list ?? []
        mylist.insert("Categories".localized, at: 0) //static at 0 index
        categoryDropDown.dataSource =  mylist
        
        // Action triggered on selection
        categoryDropDown.selectionAction = { [weak self] (index, item) in
            self?.lblcategories.text = item
            
            if index == 0 {
                
                return
                
            } // handle static 0 index
            
            //get model at selected index
            let model = self?.myRootCategoryModel.data?[index-1]
            guard let myModel = model else {return}
            
            self?.categoryModel = myModel
            self?.subCategoryModel = nil
            self!.requestToFetchSubCatgoryList(model: myModel)
        }
    }
    
    func setupSubCategoryDropDown(list:[String]? ) {
        //cell text alignment
        subtCategoryDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .center
            
        }
        //bottom offset
        subtCategoryDropDown.bottomOffset = CGPoint(x: 0, y: subCategoryButton.bounds.height)
        
       
        var mylist = list ?? []
        mylist.insert("Subcategories".localized, at: 0) //static at 0 index
        subtCategoryDropDown.dataSource =  mylist
        
        // Action triggered on selection
        self.subtCategoryDropDown.selectionAction = { [weak self]
            (index, item) in
            
            self?.lblSubCategories.text = item
            if index == 0 { return } // handle static 0 index
            
            let model = self?.myRootSubCategoryModel.data?[index-1]
            guard let myModel = model  else {return}
            
            self?.subCategoryModel = myModel
        }
        
    }
    
    //MARK:- ws: Web Services Requests
    
    func requestToFetchCatgoryList() {
      
        self.categoryLoadingBar.show()
       
        self.subCategoryModel = nil
        self.lblSubCategories.text = "Subcategories".localized
        
        CategoryManager.shared.fetchCatgoryList(title: nil) { (error, categoryModel) in
        self.categoryLoadingBar.hide()
            
            if error == nil {
                
                self.myRootCategoryModel = categoryModel!
                
                var list = [String]()
                for item in self.myRootCategoryModel.data! {
                    let title = setDefaultLanguage(body: item.title!)
                    list.append(title)
                }
                self.setupCategoryDropDown(list: list)
                
                
            }
            else {
                nvMessage.showError(body: error!)

            }
        }
    }
    
    
    func requestToFetchSubCatgoryList(model: CategoryModel) {
           self.subCategoryLoadingBar.show()
        CategoryManager.shared.fetchSubCatgoryList(title: nil, model:model, completion: { (error, categoryModel) in
            self.subCategoryLoadingBar.hide()
            
            if error == nil {
                
                self.myRootSubCategoryModel = categoryModel!
                
                var list = [String]()
                for item in self.myRootSubCategoryModel.data! {
                    let title = setDefaultLanguage(body: item.title!)
                    list.append(title)
                }
                self.setupSubCategoryDropDown(list: list)
                
                
                if self.myRootSubCategoryModel.data?.count == 0 {

                    self.subCategoryModel = nil
                }
                
            }
            else {
                nvMessage.showError(body: error!)
                self.subCategoryModel = nil
            }
        })
    }
    
    
} 


// MARK: - MapView markers and Custom Window

extension  VCHome: GMSMapViewDelegate{
    
    /* handles Info Window tap */
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf")
        
        let index = marker.userData as! Int
        let model = self.myRootStoreModel.data?.stores![index]
        
        let storyboard = UIStoryboard(name: "Core", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StorePagerVC") as! StorePagerVC
        vc.storeId = (model?.id)!
        vc.title = setDefaultLanguage(body: (model?.storeName)!)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        
        print("didLongPressInfoWindowOf")
    }
    
    /* set a custom Info Window */
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {

        let infoWindow = Bundle.main.loadNibNamed("MarkerContentInfo", owner: self, options: nil)!.first! as! MarkerContentInfo
        infoWindow.setLightGrayBorder()
        
        let index = marker.userData as! Int
        let store = self.myRootStoreModel.data?.stores![index]
        infoWindow.setData(Model: store!)
      
      
        return infoWindow

    }


    func setListofStoreMarker(lat: Double, long: Double, index: Int) {
       // self.mapView.clear()
        
            let marker = GMSMarker()
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 50, height: 70), image: #imageLiteral(resourceName: "Store-Unactive") , borderColor: UIColor.darkGray, tag: index)
            marker.iconView = customMarker
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.userData = index
            marker.map = self.mapView
     
    }

}


// MARK: - Location Manager authorization

extension VCHome: CLLocationManagerDelegate {
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            nvMessage.showError(body: "User denied access to location.")
            mapView.isHidden = false
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
        
        self.userSelectedLocation = location?.coordinate
        
        //update user current location in Global
        Sharedata.shareInfo.userLatitude = lat
        Sharedata.shareInfo.userLongitude = long
        
        let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: long!, zoom: 12.0)
        _ = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
        
        self.mapView.animate(to: camera)
        
        //self.currentmarker.map = self.mapView
        
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - google Place Picker implementation

extension VCHome: GMSPlacePickerViewControllerDelegate {
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
      
        //in self view
        self.userSelectedLocation = place.coordinate
      
        //update location in Global
        Sharedata.shareInfo.userLatitude = place.coordinate.latitude
        Sharedata.shareInfo.userLongitude = place.coordinate.longitude
        //formate address
        if place.formattedAddress != nil {
           self.txtyourlocation.text = place.formattedAddress!
        }
        else {
            let coordinate = "selected coordinat: \(place.coordinate.latitude), \(place.coordinate.longitude)"
            self.txtyourlocation.text = "Unkown Address, \(coordinate)"
        }
        
        
        let mylocation = place.coordinate
        
        let camera = GMSCameraPosition.camera(withLatitude: mylocation.latitude , longitude: mylocation.longitude, zoom: 12.0)
        
        self.mapView.animate(to: camera)
        
        //self.currentmarker.map = self.mapView
        self.requestToFetchStoreListByUserLocation(lat: mylocation.latitude, long: mylocation.longitude)
        
        
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

 //MARK:- ws: Web Services Requests
extension VCHome{
    
    func requestToFetchStoreListByUserLocation(lat: Double? , long: Double?) {
            
            self.showNvLoader()
            
            StoreManager.shared.fetchStoreListby(storeName: nil, lat: nil, long: nil) { (error, rootStoreModel) in
                self.hideNvloader()
                if error == nil {
                    self.myRootStoreModel = rootStoreModel!
                 
                    if self.myRootStoreModel.data?.stores?.count == 0 {
                        nvMessage.showError(title: self.title! , body: appConstant.noMoreData)
                    }
                    else {
                        self.mapView.clear()
                        let storeList = self.myRootStoreModel.data?.stores!
                        for (index, store) in storeList!.enumerated() {
                            self.setListofStoreMarker(lat: Double(store.location![1]), long: Double(store.location![0]), index: index)
                        }
                
                    }
                }
                else {
                    nvMessage.showError(body: error!)
                }
       
            }
        }
  
    
    func requestToRefreshMyCartList() {
    
        CartManager.shared.fetchMyCartList { (error, rootModel) in
          
            if error == nil {
              
                //reset total items on refresh list
                var totalItems = 0
                //sum of each item quantity
                for model in (rootModel?.data!)!{
                    totalItems = totalItems + model.quantity!
                }
              
               
                if rootModel?.data?.count == 0 {

                      Sharedata.shareInfo.cartItemsTotal = 0
                      self.cartBadgeBtn.hideBadge()
                }
                else {
                    //save totals in user defaults
                    Sharedata.shareInfo.cartItemsTotal = totalItems
                    self.cartBadgeBtn.badgeString = "\(totalItems)"
                    self.cartBadgeBtn.showBadge()
                }
                
                
                //Socket Call
                self.requestToSocketGetNotificationList()
                
            }
            else {
                nvMessage.showError(body: error!)
                
            }
        }
        
    }
    
    
}


extension VCHome {
    
    func  setSocketConnection()  {
       
        guard  let userToken = Sharedata.shareInfo.authToken else {
            return
        }
        
        print(Sharedata.shareInfo.authToken!)
        let usertoken = ["token":  userToken]
        //self.ShowNvLoader()
        print(userToken)
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
            if let arr = data as? [[String: Any]]{
                if let txt = arr[0]["text"] as? String{
                    print(txt)
                }
            }
        }
        
    }
    
    func  requestToSocketGetNotificationList() {
        
        self.setSocketConnection()
        //do nat call socket for guest account
        guard  let _ = Sharedata.shareInfo.authToken else {
            return
        }
        
        
        socketClient.on("notificationsList"){(data, ack)in
        
        //MARK:- StopProccessHere
        //self.hideNvloader()
        
      
        let modified = data[0] as AnyObject
        
            if let obj =  Mapper<RootNotificationModel>().map(JSONObject: modified) {
            
            self.myRootNotificationModel = obj
            
                if obj.success == true {
                
                self.notificationList = (self.myRootNotificationModel.data?.notifications)!
                    
                Sharedata.shareInfo.notificationCount = "\(self.myRootNotificationModel.data?.unseenNotificationsCount ?? 0)"
                   
                    if Sharedata.shareInfo.notificationCount == "0" {
                         self.notificationBadgeBtn.badgeString = ""
                    }
                    else {
                         self.notificationBadgeBtn.badgeString = Sharedata.shareInfo.notificationCount
                    }
                
                    self.setBarBtnsByAccountType(cartBadgeBtn: self.cartBadgeBtn )
              
                }
                else {
                    let msg = obj.message
                    nvMessage.showError(body: msg ?? "")
                    Sharedata.shareInfo.notificationCount = ""
                }
            
            }
        
        }
        
        
        socketClient.on("newNotification"){(data , ack )in
        
        self.socketClient.emit("notificationsList")
        
        }
        
        
        socketClient.on("notificationsChanged"){(data, ack)in
        
        self.socketClient.emit("notificationsList")
        }
        socketClient.on(clientEvent: .disconnect){(data , emiterr)in
            print("clientEvent: .disconnect")
        }
        
        
        socketClient.onAny { (event: SocketAnyEvent) -> Void in
            print("Got event: \(event.event), with items: \(event.items!)")
        }
        
        
        
        socketClient.on(clientEvent: .connect){(data, emiterr)in
            self.socketClient.emit("notificationsList")
        }
        
        socketClient.connect()
        
    }
}
