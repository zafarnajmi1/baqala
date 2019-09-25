//
//  VCPaymentProfile.swift
//  Baqala
//
//  Created by Macbook on 05/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class VCPaymentProfile: UIViewController {

   
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var secretId: UITextField!
    @IBOutlet weak var lblSecret: UILabel!
    @IBOutlet weak var clientId: UITextField!
    @IBOutlet weak var lblClientId: UILabel!
    @IBOutlet weak var paymentLabelInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWillAppear(false)
        
        loadLocalization()
        clientId.text = Sharedata.shareInfo.paypalClientId ?? ""
        secretId.text = Sharedata.shareInfo.paypalSecretId ?? ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButton()
        setCustomNavigationBar()
        self.title = "Payment Profile".localized
    }

    
    func loadLocalization()  {
        self.paymentLabelInfo.text = "Save your payment profile".localized
        self.lblClientId.text = "Client Id".localized
        self.lblSecret.text = "Secret".localized
        self.saveBtn.setTitle("Save".localized, for: .normal)
    
        self.clientId.placeholder = "Enter Id".localized
        self.secretId.placeholder = "Secret".localized
    
    }
    
    //MARK:- LodingMessage
    func ShowProccess()
    {
        self.startAnimating(Constant.NVActivitySize.size, message: Constant.LoadingMessage.MessageFeedback.rawValue, messageFont: UIFont.systemFont(ofSize: 20), type: NVActivityIndicatorType.ballClipRotate, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        
        if formIsValid(){
             requesToUpdatePaymentProfile()
        }
        
    }
    
    func formIsValid()-> Bool{
     
       
        if (self.clientId.text?.count)! < 3 {
           
            let msg = "Please enter valid PayPal Client ID ".localized
            nvMessage.showError(title: self.title!.localized, body: msg )
            return false
        }
        else  if(self.secretId.text?.count)! < 3 {
            
            let msg = "Please enter valid PayPal Screte ID ".localized
            nvMessage.showError(title: self.title!.localized, body: msg )
           
            return false
        }
        return true
    }
    
    func requesToUpdatePaymentProfile() {
        
        let PaymentDic: [String: Any] =  ["clientId":self.clientId.text!, "secretId":self.secretId.text!]
        
        self.ShowProccess()
        Userhandler.PaymentProfileSeller(param: PaymentDic as NSDictionary, Success: {(response)in
          
            switch(response.success!) {
           
            case true:
                self.stopAnimating()

                self.navigationController?.popViewController(animated: true)
                let msgType = response.message
                let msg = myDefaultLanguage == .en ? msgType?.en : msgType?.ar
                nvMessage.showSuccess(title: self.title!.localized, body: msg ?? "Unknow Success Message")
                Sharedata.shareInfo.paypalClientId = self.clientId.text
                Sharedata.shareInfo.paypalSecretId =  self.secretId.text
                
                break
           
            case false:
                 self.stopAnimating()
                 
                 let msgType = response.message
                 let msg = myDefaultLanguage == .en ? msgType?.en : msgType?.ar
                 nvMessage.showError(title: self.title!.localized, body: msg ?? "Unknown error Message")
                break
            }
            
        }, falioure: {(error)in
            self.stopAnimating()
        
              let msg = error.Message
            nvMessage.showError(title: self.title!, body: msg )
            
        })
    }
}
