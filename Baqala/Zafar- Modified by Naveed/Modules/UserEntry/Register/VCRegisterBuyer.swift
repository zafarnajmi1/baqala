//
//  VCRegister.swift
//  Baqala
//
//  Created by Macbook on 03/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import DLRadioButton
class VCRegister: UIViewController {
    
    @IBOutlet var SellerAndBuyerSegmentedController: UISegmentedControl!
    @IBOutlet var viewSeller: UIView!
    @IBOutlet var ViewBuyer: UIView!
    @IBOutlet var scrolview: UIScrollView!
    
    
    @IBAction func SegmentedActionToChangeValue(_ sender: UISegmentedControl) {
        
        if(sender.selectedSegmentIndex == 0)
        {

              scrolview.bringSubviewToFront(ViewBuyer)
              scrolview.sendSubviewToBack(viewSeller)
   self.SellerAndBuyerSegmentedController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            let font = UIFont(name: "Roboto-Medium", size: 17)
           SellerAndBuyerSegmentedController.setTitleTextAttributes([NSAttributedString.Key.font: font!],for: .normal)
//               self.SellerAndBuyerSegmentedController.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
//               self.SellerAndBuyerSegmentedController.layer.borderWidth = 1
//            self.SellerAndBuyerSegmentedController.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//             self.SellerAndBuyerSegmentedController.clipsToBounds  = true
            

        }else if(sender.selectedSegmentIndex == 1)
        {
            
            scrolview.bringSubviewToFront(viewSeller)
            scrolview.sendSubviewToBack(ViewBuyer)
            let font = UIFont(name: "Roboto-Medium", size: 17) //Regular
            SellerAndBuyerSegmentedController.setTitleTextAttributes([NSAttributedString.Key.font: font!],for: .normal)
//            self.SellerAndBuyerSegmentedController.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
//            self.SellerAndBuyerSegmentedController.layer.borderWidth = 1
//            self.SellerAndBuyerSegmentedController.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            self.SellerAndBuyerSegmentedController.clipsToBounds  = true
//            self.SellerAndBuyerSegmentedController.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            if(sender.selectedSegmentIndex == 1)
            {
                 self.SellerAndBuyerSegmentedController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            }
            
        }
        
        
    }
    //MARK:- BuyerOutlets
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnBuyer: DLRadioButton!
    @IBOutlet var btnSeller: DLRadioButton!
    @IBOutlet var lblAccountTitle: UILabel!
    @IBOutlet var btnFemale: DLRadioButton!
    @IBOutlet var btnMale: DLRadioButton!
    @IBOutlet var lblAlreadyhaveAcount: UILabel!
    @IBOutlet var BtnRegister: UIButton!
    @IBOutlet var lblSelectGender: UILabel!
    @IBOutlet var poneNumberView: UIView!
    @IBOutlet var ConfirmPasswordView: UIView!
    @IBOutlet var PasswordView: UIView!
    @IBOutlet var EmailView: UIView!
    @IBOutlet var LastNameView: UIView!
    @IBOutlet var FirstNameView: UIView!
    
    //MARK:- SellerOutlets
    
    @IBOutlet var btnLoginSeller: UIButton!
    @IBOutlet var lblAlreadyHaveAccountSeller: UILabel!
    @IBOutlet var btnRegisterSeller: UIButton!
    
    @IBOutlet var ConfirmPasswordSellerView: UIView!
    @IBOutlet var PasswordSellerView: UIView!
    @IBOutlet var AddressSellerView: UIView!
    @IBOutlet var PhoneNumberSellerView: UIView!
    @IBOutlet var EnterYourEmailSellerView: UIView!
    @IBOutlet var SellerStoreNameViews: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentDesign()
        self.EmailView.DesignRegister()
    }
    
    //MARK:- SegmentDEisgn
    func segmentDesign()
    {
        SellerAndBuyerSegmentedController.selectedSegmentIndex = 0
        if( SellerAndBuyerSegmentedController.selectedSegmentIndex == 0)
        {
            scrolview.bringSubviewToFront(ViewBuyer)
            scrolview.sendSubviewToBack(viewSeller)
            let font = UIFont(name: "Roboto-Medium", size: 17)
            SellerAndBuyerSegmentedController.setTitleTextAttributes([NSAttributedString.Key.font: font!],for: .normal)
            SellerAndBuyerSegmentedController.translatesAutoresizingMaskIntoConstraints = false
           self.SellerAndBuyerSegmentedController.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            SellerAndBuyerSegmentedController.layer.borderWidth = 1.5
            SellerAndBuyerSegmentedController.layer.cornerRadius = 0.0
            SellerAndBuyerSegmentedController.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
        }else
        {
            scrolview.bringSubviewToFront(viewSeller)
            scrolview.sendSubviewToBack(ViewBuyer)
            let font = UIFont(name: "Roboto-Medium", size: 17)
            SellerAndBuyerSegmentedController.setTitleTextAttributes([NSAttributedString.Key.font: font!],for: .normal)
            SellerAndBuyerSegmentedController.translatesAutoresizingMaskIntoConstraints = false
            self.SellerAndBuyerSegmentedController.layer.borderWidth = 1
            self.SellerAndBuyerSegmentedController.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.SellerAndBuyerSegmentedController.clipsToBounds  = true
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
           self.addBackButton()
           self.title = "Register"
        
        //MARK:- BuyerDesignFunc
        
        self.EmailView.DesignRegister()
        self.FirstNameView.DesignRegister()
        self.poneNumberView.DesignRegister()
        self.ConfirmPasswordView.DesignRegister()
        self.PasswordView.DesignRegister()
        self.LastNameView.DesignRegister()
        
        //MARK:- SellerDesignFunc
         self.SellerStoreNameViews.DesignRegister()
         self.EnterYourEmailSellerView.DesignRegister()
         self.PhoneNumberSellerView.DesignRegister()
         self.AddressSellerView.DesignRegister()
         self.PasswordSellerView.DesignRegister()
         self.ConfirmPasswordSellerView.DesignRegister()

    }
   
    
    //MARK:- Buyer
    
    @IBAction func BtnRegisterAction(_ sender: UIButton) {
    }
    
    @IBAction func btnLoginAction(_ sender: UIButton) {
    }
   
    

    
    //MARK:- Seller
    
    @IBAction func BtnRegisterSellerAction(_ sender: UIButton) {
    }
    
    @IBAction func BtnLoginSellerAction(_ sender: UIButton) {
    }
}

