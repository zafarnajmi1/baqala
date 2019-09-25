//
//  VCContactUs.swift
//  Baqala
//
//  Created by Macbook on 05/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import DropDown
import  NVActivityIndicatorView
class VCContactUs: UIViewController {

     //MARK:- outlets
    
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var yourCommentsLabel: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var lblemailAddress: UILabel!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var help: UITextField!
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet var commentsTv: KMPlaceholderTextView!
    @IBOutlet var commentsTvPlaceHolder: UILabel!
    @IBOutlet var emailView: UIView!
    @IBOutlet var dropDownBtn: UIButton!
    
     //MARK:- Properties
    
    let dropdown = DropDown()
    
    
     //MARK:- life cycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadLocalization()
        
        viewWillAppear(false)
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButton()
        setCustomNavigationBar()
        self.title = "Contact Us".localized
        self.emailView.setLightGrayBorder()
        self.dropDownBtn.ButtonDesign()
        setupHelpDropDown()
        
        commentsTv.delegate = self
    }

     //MARK:-  base config
    func loadLocalization() {
 
        self.sendBtn.setTitle("Send".localized, for: .normal)
        
        self.firstNameLabel.text = "First Name".localized
        self.lastNameLabel.text = "Last Name".localized
        self.lblemailAddress.text = "Email Address".localized
        self.yourCommentsLabel.text = "Your Comments".localized
        self.helpLabel.text = "What can we help you with?".localized
        
        self.firstName.placeholder = "First Name".localized
        self.lastName.placeholder = "Last Name".localized
        self.email.placeholder = "Email Address".localized
        self.help.placeholder = "App Feed Back".localized
        let tfs = [firstName, lastName, email, help] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
    
        self.commentsTvPlaceHolder.text = "Enter text here".localized
        let tvs = [commentsTv] as [UITextView]
        self.setTextViewDirectionByLanguage(textViews: tvs)
        
        self.setViewDirectionByLanguage()
    }
    
    
    
    func setupHelpDropDown(){
        dropdown.anchorView = dropDownBtn
        dropdown.bottomOffset = CGPoint(x: 0, y: dropDownBtn.bounds.height)
        
        dropdown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            
            cell.optionLabel.textAlignment = .center
            
        }
 
        dropdown.dataSource = ["App Feed Back".localized,"Complaint".localized]
        dropdown.selectionAction = {[unowned self](index: Int, item: String) in
            self.help.text = item
        }
    }
    
    //MARK:-  actions
    @IBAction func DropdownAction(_ sender: UIButton) {
        dropdown.show()
    }
    

    @IBAction func btnSendAction(_ sender: UIButton) {
       //API Call
        self.view.endEditing(true)
        
        if isValidContactUsForm(){
        submitFormRequest()
        
        }
    }
    
    func isValidContactUsForm()->Bool{
        
        let title = self.title ?? "Contact Us".localized
        
        if(self.firstName.text! == ""){
            let msg =  "Please enter valid first name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        else if(self.lastName.text! == ""){
            
            let msg =  "Please enter valid last name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        else if(self.help.text! == ""){
              let message = "Please select subject".localized
             nvMessage.showError(title: title, body: message)

            return false
        }
        else if isValid(email: self.email.text!) == false{
              let message = "Please enter valid email address".localized
             nvMessage.showError(title: title, body: message)

            return false
        }
        return true
        
    }
    
     //MARK:-  API Request
    func submitFormRequest() {
        
        let fullName = "\(self.firstName.text!) \(self.lastName.text!)"
       
        let  ConactDic : [String: Any] = ["subject":self.help.text!,
                                          "email": self.email.text!,
                                          "name": fullName,
                                          "message": self.commentsTv.text!]
     
        self.showNvLoader()
        
        Userhandler.ContactUsUser(param: ConactDic as NSDictionary, Success: {(response)in
            self.hideNvloader()
            
            switch(response.success!) {
                
            case true:
                
              
                let resp = response
              
                let msg = myDefaultLanguage == .en ? resp.message?.en: resp.message?.ar
                nvMessage.showSuccess(title: self.title!.localized, body: msg ?? "Unkown" )
                self.navigationController?.popViewController(animated: true)
          
            case false:
                
                let resp = response
                let msg = myDefaultLanguage == .en ? resp.message?.en: resp.message?.ar
                nvMessage.showError(title: self.title!.localized, body: msg ?? "Unkown" )
                
             
              
            }
            
        }, falioure: {(error)in
             self.hideNvloader()
             nvMessage.showError(body: error.Message )
            
        })
        
    }
}

extension VCContactUs: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        commentsTvPlaceHolder.isHidden = true
       return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentsTv.text.count == 0 {
            commentsTvPlaceHolder.isHidden = false
        }
        
    }

  
    
}
