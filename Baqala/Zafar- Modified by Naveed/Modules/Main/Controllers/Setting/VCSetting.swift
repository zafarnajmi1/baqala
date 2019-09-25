//
//  VCSetting.swift
//  Baqala
//
//  Created by Macbook on 05/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import DLRadioButton

class VCSetting: UIViewController {
    
    @IBOutlet var passwordView: UIView!
    @IBOutlet var passwordBtnLabel: UILabel!
    @IBOutlet var passwordTitle: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    
    @IBOutlet var LanguageView: UIView!
    @IBOutlet var languageBtnLabel: UILabel!
    @IBOutlet var languageTitle: UILabel!
    @IBOutlet var languageLabel: UILabel!
    
    @IBOutlet var currencyView: UIView!
    @IBOutlet var currencyTitle: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    
    @IBOutlet weak var aedBtn: DLRadioButton!
    @IBOutlet weak var usdBtn: DLRadioButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadLocalization()
      
        viewWillAppear(true)
      
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        self.loadLocalization()
       
        self.setCustomNavigationBar()
        self.setBackButton()
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Setting".localized
        
        reloadSetting()
        
    }
    
   
    //MARK: - Base Config
    func loadLocalization()  {
        
        self.passwordTitle.text = "Password".localized
        self.passwordLabel.text = "Change Password".localized
        self.passwordBtnLabel.text  = "Change".localized
        
        self.languageTitle.text = "Language".localized
        self.languageLabel.text = "Change Language".localized
        self.languageBtnLabel.text  = "Change".localized
       
        self.currencyTitle.text = "Currency".localized
        self.currencyLabel.text = "Select Currency".localized
        
        self.setViewDirectionByLanguage()
        
        
    }
    
    
    
    fileprivate func reloadSetting() {
      
        Sharedata.shareInfo.isFromSettingVC = true
        //currency handling
        if myDefaultCurrency == .aed {
            self.aedBtn.isSelected = true
        }
        else {
            self.usdBtn.isSelected = true
        }
        //account type handling
        if(myDefaultAccountType == .guest){
            passwordView.isHidden = true
            passwordView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        else{
            passwordView.isHidden = false
        }
        
        
        self.currencyView.setLightShadow()
        self.passwordView.setLightShadow()
        self.LanguageView.setLightShadow()
        
    }

    @IBAction func currencyBtnAEDTapped(_ sender: DLRadioButton) {
          myDefaultCurrency = .aed
        
    }
    
    @IBAction func currencyBtnUSDTapped(_ sender: DLRadioButton) {
        myDefaultCurrency = .usd
        
    }
   

    @IBAction func btnChangePaswordAction(_ sender: UIButton) {
        
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCChangePasword") as! VCChangePasword
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func BtnChnageLanguageAction(_ sender: UIButton) {
        
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCSelectLanguage") as! VCSelectLanguage
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
