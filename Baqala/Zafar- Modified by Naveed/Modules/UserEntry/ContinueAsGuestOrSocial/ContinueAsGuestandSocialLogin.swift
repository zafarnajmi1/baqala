//
//  ContinueAsGuestandSocialLogin.swift
//  Baqala
//
//  Created by Macbook on 30/11/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import  GoogleSignIn
import InstagramLogin
class ContinueAsGuestandSocialLogin: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {

    
    @IBOutlet var btnContinueAsGuest: UIButton!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet weak var orLbl: UILabel!
    @IBOutlet weak var fbLbl: UILabel!
    @IBOutlet weak var googleLbl: UILabel!
    @IBOutlet weak var instaLbl: UILabel!
    
    
    private var myUserRootModel = RootUserLoginModel()
    
    
    var firstName = ""
    var lastName = ""
    var myEmail = ""
    var socialId = ""
    var myGender = ""
    var socialToken = ""
    var socialLoginType : Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        self.setCustomNavigationBar()
        navigationItem.hidesBackButton = true
        
        loadLocalization()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
         //self.addBackButton()
        self.title = "Continue as Guest or Social Login".localized
        self.navigationController?.isNavigationBarHidden =  false
        //self.navigationController?.navigationBar.isHidden = false
    }
    
    
    //MARK: - Base config
    
    fileprivate func loadLocalization() {
       
        self.setViewDirectionByLanguage()
        
        self.btnLogin.setTitle("Login".localized, for: .normal)
        self.btnRegister.setTitle("Register".localized, for: .normal)
        let guestTitle = "Continue As Guest".localized
        self.btnContinueAsGuest.setTitle(guestTitle, for: .normal)
        
        self.fbLbl.text = "Continue With Facebook".localized
        self.googleLbl.text = "Continue Login With Google".localized
        self.instaLbl.text = "Continue login With Instagram".localized
        self.orLbl.text = "OR".localized
        
    }
    
    
    
    
    
    
    @IBAction func BtnLoginAction(_ sender: UIButton) {
      
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        vc.isFromContinueAsGuest = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func BtnRegisterAction(_ sender: UIButton) {
     
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func BtnContinueAsGuestAction(_ sender: UIButton) {
        
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCTabBarHome") as! UITabBarController
        Sharedata.shareInfo.accountType = "guest"
        myDefaultAccountType = .guest
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ContinoueWtihFaceBokAction(_ sender: UIButton) {
        socialLoginType = 1
        moveToFaceBookVC()
    }
    
    @IBAction func ContinoueWtihGmailAction(_ sender: UIButton) {
        socialLoginType = 2
        gmailSocialLogin()
        
    }
    
    @IBAction func ContinoueWithInstagramAction(_ sender: UIButton) {
        socialLoginType = 3
        self.InstaGramLogin()
    }
    
    
    func moveToFaceBookVC() {
        
        
        let loginManger = FBSDKLoginManager()
        loginManger.logOut()
       
        loginManger.logIn(withReadPermissions: ["email", "public_profile"], from: self ){[weak self](loginResult, error)in
            
           if error != nil{
            print(error?.localizedDescription ?? "You are not login somthing wrong")
           }
           else if((loginResult?.isCancelled)!)
           {
           print("cancelled login screen")
        
           }
           else {
            //Validate permission granted
            guard let _ = loginResult?.grantedPermissions.contains("email")  else {
                //Out from Function
                return
            }
            //Validate Current Access Token
            guard let _ = FBSDKAccessToken.current()  else {
                //Out from Function
                return
            }
            
            let params = ["fields":"id, name, first_name, last_name, email, gender, picture.type(large)"]
            
            FBSDKGraphRequest(graphPath: "/me", parameters: params )
                .start(completionHandler: {(connection, result, error)in
                    
                    if(error == nil){
                        
                        let SocialDic = result as! [String: AnyObject]
                        let token = FBSDKAccessToken.current()?.tokenString ??  ""
                        Sharedata.shareInfo.socialToken = token
                        self!.socialToken = token
                        print( Sharedata.shareInfo.socialToken!)
                        Sharedata.shareInfo.LoginType = "facebook"
                        print(SocialDic)
                        self!.firstName = SocialDic["first_name"] as! String
                        self!.lastName = SocialDic["last_name"] as! String
                        
                        Sharedata.shareInfo.name = self!.firstName + self!.lastName
                        Sharedata.shareInfo.Fname = self!.firstName
                        Sharedata.shareInfo.Lname = self!.lastName
                        
                        self!.myEmail = SocialDic["email"] as! String
                        self!.socialId = SocialDic["id"] as! String
                        
                        print(self!.socialId)
                        //API call
                        self?.requestToSoicalLogin()
                    }
                    else{
                        print(error?.localizedDescription ??  "some thing is wrong")
                    }
                })
            }
        }
       
    }
    
    
    func gmailSocialLogin(){
        
        
        let googleLogin = GIDSignIn.sharedInstance()
        googleLogin?.shouldFetchBasicProfile = true
        googleLogin?.scopes = ["profile", "email"]
        googleLogin?.delegate = self
        googleLogin?.signOut()
        googleLogin?.signIn()
        
        
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Swift.Error!) {
       
        if let error = error{
         
            print(error.localizedDescription)
        
        }
        else if(error == nil) {
            
            let googletoken = GIDSignIn.sharedInstance()?.currentUser.authentication.idToken
            Sharedata.shareInfo.socialToken = googletoken
            self.socialToken = googletoken!
            Sharedata.shareInfo.LoginType = "google"
            //var GoogleDic : [String: Any] = ["": ""]
            
            self.myEmail = user.profile.email
            self.socialId = user.userID
            self.firstName = user.profile.name
            self.lastName = user.profile.name
            self.myGender = user.profile.debugDescription
            print(myGender)
            print(self.lastName)
            print(socialId)
            self.requestToSoicalLogin()
        }
    }
    
    
    //MARK:INSTAGRAM INTIGRATION
    var instagramLogin: InstagramLoginViewController!
    var currentAccessTolken : String!
    var dataInstagram : String!
    
    func InstaGramLogin(){
        
        
        
        instagramLogin = InstagramLoginViewController(clientId: instgramCont.clientId, redirectUri: instgramCont.redirectUri)
        instagramLogin.delegate = self
        instagramLogin.scopes = [.all]
        print(instagramLogin)
        
        instagramLogin.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissLoginViewController))
        instagramLogin.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPage))
        
        present(UINavigationController(rootViewController: instagramLogin), animated: true)
        
        
    }
    
    func showAlertView(title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertView, animated: true)
    }
    
    @objc func dismissLoginViewController() {
        instagramLogin.dismiss(animated: true)
    }
    
    @objc func refreshPage() {
        instagramLogin.reloadPage()
    }
    
    
    
    ////
    
    
    func getInstagramUserData(){
        print("1")
        // https://api.instagram.com/v1/users/self/?access_token=ACCESS-TOKEN
        let urlString = "https://api.instagram.com/v1/users/self/?access_token=\(self.currentAccessTolken!)"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error!)")
                return
            }
            print("response = \(response!)")
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            let jsonText = responseString
            
            var dictonary:NSDictionary?
            
            if let data = jsonText?.data(using: String.Encoding.utf8) {
                
                do {
                    dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as! NSDictionary
                    
                    if let myDictionary = dictonary
                    {
                        print(" First name is: \(myDictionary["data"]!)")
                        if let dataData = myDictionary["data"] as? [String:Any]{
                           
                            self.myEmail = dataData["username"]! as! String
                            self.firstName = dataData["full_name"]! as! String
                            self.lastName = dataData["full_name"]! as! String
                            self.socialId = dataData["id"]! as! String
                            self.socialToken = self.currentAccessTolken
                            
                            self.requestToSoicalLogin()
                        }
        
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            
        }
        task.resume()
    }
    
    
   
    
    //MARK:- SocialFunction
    
   
    
    func  requestToSoicalLogin()  {
     
        var params = ["authMethod": ""] as [String: Any]
       
        switch self.socialLoginType {
        case 1:
            params.updateValue("facebook", forKey: "authMethod")
            params.updateValue(self.socialId, forKey: "facebookId")
        case 2:
            params.updateValue("google", forKey: "authMethod")
            params.updateValue(self.socialId, forKey: "googleId")
           
        default:
            params.updateValue("google", forKey: "instagram")
            params.updateValue(self.socialId, forKey: "accessToken")
        }
        
        self.showNvLoader()
      
        UserManager.shared.userSocialLogin(params: params) { (error, rootModel) in
            self.hideNvloader()
            
            if error == nil {
                self.myUserRootModel = rootModel!
                
                //save user data
                self.saveDataByLoginAccountType()
                
                
            }
            else {
               
                let error = error!.lowercased()
               
                if error.contains("user not found") {
                    Sharedata.shareInfo.emailIsVerfied = false
                    self.moveToRegisterUserBySoicalProfile()
                }
                else {
                    nvMessage.showError(title: "Login".localized , body: error)
                }
               
            }
        }
    }
    
    
    
    
    private func  saveDataByLoginAccountType() {
        
        //save authorization token
        
        Sharedata.shareInfo.authToken = myUserRootModel.data?.authorization
        let token = myUserRootModel.data?.authorization
        UserDefaults.standard.set(token, forKey: "userAuthToken")
        
        //handling session login/logout
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
            Sharedata.shareInfo.paypalClientId = myUserRootModel.data?.paypalClientId
            Sharedata.shareInfo.paypalSecretId = myUserRootModel.data?.paypalSecretId
            
        default:
            myDefaultAccountType = .guest
            
        }
        
        //common in account Type
        Sharedata.shareInfo.userLongitude = (myUserRootModel.data?.location![0])!
        Sharedata.shareInfo.userLatitude =  (myUserRootModel.data?.location![1])!
        
        Sharedata.shareInfo.id = myUserRootModel.data?.id
        Sharedata.shareInfo.email = myUserRootModel.data?.email
        
        
        Sharedata.shareInfo.accountType = myUserRootModel.data?.accountType
        Sharedata.shareInfo.usertype = myUserRootModel.data?.userType
        
        Sharedata.shareInfo.userImage = myUserRootModel.data?.image
        Sharedata.shareInfo.address = myUserRootModel.data?.address
        Sharedata.shareInfo.LoginType = "local"
        
        
        // check if user email is -> isEmailVerified
        if (self.myUserRootModel.data?.isEmailVerified)! == true {
            Sharedata.shareInfo.emailIsVerfied = true
            let appdelgate = UIApplication.shared.delegate as? AppDelegate
            appdelgate?.moveToHome()
        }
        else { //navigate to registration
            
            Sharedata.shareInfo.emailIsVerfied = false
            self.moveToRegisterUserBySoicalProfile()
            
        }
        
        
        
    }
    
    func moveToRegisterUserBySoicalProfile(){
        
      
        
        var title: String!
        var authMethod: String!
        
        switch socialLoginType {
        case 1:
            title = "Continue with Facebook".localized
            authMethod = "facebook"
        case 2:
            title = "Continue with Gmail".localized
            authMethod = "google"
        default:
            title = "Continue with Instagram".localized
            authMethod = "instagram"
        }
       let obj = SocialProfileModel(firstName: self.firstName,
                                    lastName: self.lastName,
                                    email: self.myEmail,
                                    socialId: self.socialId,
                                    socialToken: self.socialToken,
                                    myTitle: title,
                                    authMethod: authMethod,
                                    gender: self.myGender)
        
       
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "RegisterSocialVC") as! RegisterSocialVC
    
        vc.myProfile = obj
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
extension ContinueAsGuestandSocialLogin: InstagramLoginViewControllerDelegate {
    
    func instagramLoginDidFinish(accessToken: String?, error: InstagramError?) {
        dismissLoginViewController()
        
        if accessToken != nil {
            
            //  showAlertView(title: "Successfully logged in! 👍", message: accessToken!)
            self.currentAccessTolken = accessToken!
            getInstagramUserData()
        } else {
            showAlertView(title: "\(error!.localizedDescription)", message: "")
        }
    }
}

