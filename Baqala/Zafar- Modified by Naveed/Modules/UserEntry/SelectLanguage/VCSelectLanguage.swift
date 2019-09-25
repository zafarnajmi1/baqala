//
//  VCSelectLanguage.swift
//  Baqala
//
//  Created by Macbook on 30/11/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class VCSelectLanguage: UIViewController {

    //MARK: outlets
    
    @IBOutlet weak var savelanguageimage: UIImageView!
    @IBOutlet var BtnArabic: UIButton!
    @IBOutlet var btnEnglish: UIButton!
    @IBOutlet var LblSelectLanguage: UILabel!
    @IBOutlet var LblSaveLanguage: UILabel!
    
    //MARK: Properties
    
    let appdelgate = UIApplication.shared.delegate as? AppDelegate
    
    
    //MARK: Life Cycle
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWillAppear(false)
        
        if Sharedata.shareInfo.isLanguageSaved != nil
            && Sharedata.shareInfo.isLanguageSaved == true {
            savelanguageimage.image  = #imageLiteral(resourceName: "Checkbox-1")
        }
        
        
        
        loadLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButton()
        self.navigationController?.isNavigationBarHidden = true
        BtnArabic.isEnabled = false
        
    }
    
    //MARK: - Base Config
    
    fileprivate func loadLocalization() {
        self.LblSelectLanguage.text = "Select Langauge".localized
        self.LblSaveLanguage.text = "Save this language".localized
    }
   
   
    
   
    
    //MARK: actions
    
    @IBAction func BtnEnglishAction(_ sender: UIButton) {
        //GLOBAL
        myDefaultLanguage = .en
        Sharedata.shareInfo.languageSaved = "en"
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        
        UserDefaults.standard.set("en", forKey: "myDefaultLanguage")
        UserDefaults.standard.synchronize()
        
        self.saveLanguage()
        
        if(Sharedata.shareInfo.email != nil){
               self.navigateToTabBarVC()
        }
        else{
            self.moveToAcountSelectionVC()
        }
        
        
    }
    
    @IBAction func BtnArabicAction(_ sender: UIButton) {
        //GLOBAL
        myDefaultLanguage = .ar
        Sharedata.shareInfo.languageSaved = "ar"
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        
        UserDefaults.standard.set("ar", forKey: "myDefaultLanguage")
        UserDefaults.standard.synchronize()
        
        self.saveLanguage()
        
        if(Sharedata.shareInfo.email != nil){
            self.navigateToTabBarVC()
        }
        else{
            self.moveToAcountSelectionVC()
        }
        
      
    }
    
    @IBAction func btnActionSaveLanguage(_ sender: UIButton) {
        
        
        //uncheked
        if(savelanguageimage.image == #imageLiteral(resourceName: "Check")){
            //checked image
    
            savelanguageimage.image  = #imageLiteral(resourceName: "Checkbox-1")
        }
        else{
            //unchck image
            savelanguageimage.image = #imageLiteral(resourceName: "Check")
        }
    }
    
    
    func saveLanguage() {
        //uncheked
        if(savelanguageimage.image == #imageLiteral(resourceName: "Check")){
            Sharedata.shareInfo.isLanguageSaved = false
        }
        else{
            Sharedata.shareInfo.isLanguageSaved = true
        }
    }
   
    
    //MARK: Helpers
    fileprivate func navigateToTabBarVC() {
    
      
        if Sharedata.shareInfo.isFromSettingVC == true {
           // self.navigationController?.popViewController(animated: true)
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.moveToHome()
        }
        else if Sharedata.shareInfo.autoLogin == true{

            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.moveToHome()
        }
        else {
            let  storydoard = UIStoryboard(name: "Main", bundle: nil)
            let vc =   storydoard.instantiateViewController(withIdentifier: "ContinueAsGuestandSocialLogin") as! ContinueAsGuestandSocialLogin
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    fileprivate func moveToAcountSelectionVC() {
        
       
        
        if Sharedata.shareInfo.isFromSettingVC == true {
           // self.navigationController?.popViewController(animated: true)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.moveToHome()
        }
        else {
            //if account type not selected then navigate to to Chose account type
            let  storydoard = UIStoryboard(name: "Main", bundle: nil)
            let vc =   storydoard.instantiateViewController(withIdentifier: "ContinueAsGuestandSocialLogin") as! ContinueAsGuestandSocialLogin
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
       
     
        
    }
    
}
