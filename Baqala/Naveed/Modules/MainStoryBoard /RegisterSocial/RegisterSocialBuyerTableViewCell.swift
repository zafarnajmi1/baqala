//
//  RegisterSocialBuyerTableViewCell.swift
//  Baqala
//
//  Created by apple on 2/25/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import UIKit
import GooglePlacePicker
import MapKit
import DLRadioButton

class RegisterSocialBuyerTableViewCell: UITableViewCell {
    //MARK:- outlets
    
    @IBOutlet weak var maleBtn: DLRadioButton! //male
    @IBOutlet weak var femaleBtn: DLRadioButton!
    @IBOutlet weak var lblSelectGender: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var lblAlreadyAccount: UILabel!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
   
    
    //MARK:- Properties
    var controller: UIViewController?
    
     //MARK:-  private
    private var myProfile: SocialProfileModel!
    private var location: CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()
    
    
    var myUserRootModel = RootUserLoginModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.address.delegate = self
        self.maleBtn.isSelected = true //default male selected
        
        self.loadLocalization()
        
    }
    
    
    //MARK: - Base config
    
    fileprivate func loadLocalization() {
        self.femaleBtn.setTitle("Female".localized, for: .normal)
        self.maleBtn.setTitle("Male".localized, for: .normal)
        self.registerBtn.setTitle("Register".localized, for: .normal)
        self.loginBtn.setTitle("Login".localized, for: .normal)
        
        self.lblSelectGender.text = "Select Gender".localized
        self.lblAlreadyAccount.text = "Already have an account?".localized
        
        self.firstName.placeholder = "First Name".localized
        self.lastName.placeholder = "Last Name".localized
        self.email.placeholder = "Enter Your Email".localized
        self.phone.placeholder = "Phone Number".localized
        self.address.placeholder = "Address".localized
      
        
        let txtFields = [firstName, lastName, email, phone, address] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: txtFields)
        self.controller?.setViewDirectionByLanguage()
        
    }
    
    func setData(model : SocialProfileModel)  {
       
        self.myProfile = model
        
        self.firstName.text = model.firstName
        self.lastName.text = model.lastName
        self.email.text = model.email
        
        guard let gender = model.gender else { return }
        
        if gender.lowercased() == "male" {
            self.maleBtn.isSelected = true
        }
        if gender.lowercased() == "female" {
            self.femaleBtn.isSelected = true
        }
        
    }
    
    //MARK:- Login
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToEmailVerification() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VCEmailVerification") as! VCEmailVerification
        vc.email = email.text!
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK:- buyer Register
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        
        self.controller?.view.endEditing(true)
        
        if self.formIsvalid() {
            self.reuquestToCreateUserAcount()
        }
    }
    
    private func reuquestToCreateUserAcount()  {
        
        
        let gender = maleBtn.isSelected == true ? "male" : "female"
        
        
        
        
        let params = [
            "firstName":self.firstName.text!,
            "lastName": self.lastName.text!,
            "phone":self.phone.text!,
            "email":self.email.text!,
            "accountType": "buyer",
            "address": self.address.text!,
            "latitude": location!.latitude,
            "longitude": location!.longitude,
            "gender": gender,
            "accessToken":myProfile.socialToken!,
            "authMethod":myProfile.authMethod!,
            "socialId":myProfile.soicalId!] as  [String:Any]
        
        self.controller?.showNvLoader()
        UserManager.shared.createUserAccountFromSoicalProfile(params: params) { (error, rootModel) in
            
            self.controller?.hideNvloader()
            
            if error == nil {
                
                self.myUserRootModel = rootModel!
                //save user data
                self.saveDataByAccountType()
                
            }
            else {
                let title = "New account request".localized
                nvMessage.showError(title: title, body: error!)
            }
        }
    }
    
    
    private func  saveDataByAccountType() {
        
        //save authorization token
        
        Sharedata.shareInfo.authToken = myUserRootModel.data?.authorization
        let token = myUserRootModel.data?.authorization
        UserDefaults.standard.set(token, forKey: "userAuthToken")
        
        Sharedata.shareInfo.autoLogin = true
        
        //save info by  account type
        
        switch self.myUserRootModel.data?.accountType {
        case "buyer":
            myDefaultAccountType = .buyer
            let firstName = myUserRootModel.data?.firstName ?? "Unkown"
            let lastName = myUserRootModel.data?.lastName ?? "Name"
            Sharedata.shareInfo.name = ("\(firstName) \(lastName)")
            Sharedata.shareInfo.Fname = firstName
            Sharedata.shareInfo.Lname = lastName
            
            
            
            
        case "seller":
            myDefaultAccountType = .seller
            Sharedata.shareInfo.storeNameEn = myUserRootModel.data?.storeName?.en
            Sharedata.shareInfo.storeNameAr = myUserRootModel.data?.storeName?.ar
            Sharedata.shareInfo.storeImage = myUserRootModel.data?.image ?? ""
            
        default:
            myDefaultAccountType = .guest
            
        }
        
        //common in accounts
        Sharedata.shareInfo.userLongitude = (myUserRootModel.data?.location![0])!
        Sharedata.shareInfo.userLatitude =  (myUserRootModel.data?.location![1])!
        
        Sharedata.shareInfo.id = myUserRootModel.data?.id
        Sharedata.shareInfo.email = myUserRootModel.data?.email
     
        
        
        Sharedata.shareInfo.accountType = myUserRootModel.data?.accountType
        Sharedata.shareInfo.usertype = myUserRootModel.data?.userType
        
        Sharedata.shareInfo.userImage = myUserRootModel.data?.image
        Sharedata.shareInfo.address = myUserRootModel.data?.address
        
        Sharedata.shareInfo.emailIsVerfied = myUserRootModel.data?.isEmailVerified
        
        Sharedata.shareInfo.LoginType = "local"
        
        
        //shw success message
        let title = "New account request".localized
        let msg = setDefaultLanguage(body: (myUserRootModel.message)!)
        nvMessage.showSuccess(title: title , body: msg )
      
        delay(bySeconds: 3) {
            let appdelegate = UIApplication.shared.delegate as? AppDelegate
            appdelegate?.moveToHome()
        }
       
        
    }
    
    
    
    
    
    //MARK: - form validation
    private func  formIsvalid() -> Bool {
        
        let title = "Buyer".localized
        
        if (firstName.text?.count)! < 2 {
            let msg = "Please enter valid first name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        if (lastName.text?.count)! < 2 {
            let msg = "Please enter valid last name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        if  isValid(email: email.text!) == false {
            let msg = "Please enter valid email".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if  (phone.text?.count)! < 4{
            let msg = "Please enter valid phone number".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if (address.text?.count)! < 2 {
            let msg = "Please enter valid address".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
       
        return true
    }
    
}


extension RegisterSocialBuyerTableViewCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.address {
            let config = GMSPlacePickerConfig(viewport: nil)
            let placePicker = GMSPlacePickerViewController(config: config)
            placePicker.delegate = self
            UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2914224267, green: 0.7155272365, blue: 0.3309046328, alpha: 1)
            self.controller?.present(placePicker, animated: true, completion: nil)
        }
    }
    
    
}


extension RegisterSocialBuyerTableViewCell: GMSPlacePickerViewControllerDelegate {
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        //in self view
        self.location = place.coordinate
        
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


extension RegisterSocialBuyerTableViewCell: CLLocationManagerDelegate {
    
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
        
        self.location = location?.coordinate
        
        //update user current location in Global
        Sharedata.shareInfo.userLatitude = lat
        Sharedata.shareInfo.userLongitude = long
        
        
        
    }
}
