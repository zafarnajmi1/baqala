//
//  ViewControllerExtension.swift
//  Baqala
//
//  Created by apple on 12/5/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import MIBadgeButton_Swift
import Segmentio

//MI BadgeExtend
extension MIBadgeButton {
   
    func hideBadge()  {
        self.badgeBackgroundColor = .clear
        self.badgeTextColor = .clear
    }
    func showBadge()  {
        self.badgeBackgroundColor = #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)
        self.badgeTextColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
    }
}



extension UIViewController {
    
    func setbuyerBarBtn(cartBadgeBtn: MIBadgeButton) {

    
        cartBadgeBtn.badgeBackgroundColor = #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)
        cartBadgeBtn.badgeTextColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        
        cartBadgeBtn.verticalMargin = 0
        cartBadgeBtn.horizontalMargin = 0
        cartBadgeBtn.badgeEdgeInsets = UIEdgeInsets(top: 6, left: -10, bottom: 0, right:0)
        cartBadgeBtn.setImage(UIImage(named: "Cart"), for: .normal)
        cartBadgeBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        cartBadgeBtn.addTarget(self, action: #selector(btnCardClick(_:)), for: .touchUpInside)
        
        //Hiding Bade Button
        cartBadgeBtn.badgeBackgroundColor = .clear
        cartBadgeBtn.badgeTextColor = .clear
        
        //Update badgNumber
        if Sharedata.shareInfo.cartItemsTotal != nil {
            cartBadgeBtn.showBadge()
            cartBadgeBtn.badgeString = "\(Sharedata.shareInfo.cartItemsTotal ?? 0)"
            if cartBadgeBtn.badgeString == "0" {
                cartBadgeBtn.hideBadge()
            }
        }
        
        //add button to barButton
        let btnCart = UIBarButtonItem(customView: cartBadgeBtn)
        
    
       let  notificationBadge = MIBadgeButton(type: .custom)
        
        notificationBadge.badgeBackgroundColor = #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)
        notificationBadge.badgeTextColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        
        notificationBadge.verticalMargin = 0
        notificationBadge.horizontalMargin = 0
        notificationBadge.badgeEdgeInsets = UIEdgeInsets(top: 6, left: 28, bottom: 0, right:0)
        
        if Sharedata.shareInfo.notificationCount != nil  {
            
            
            if Sharedata.shareInfo.notificationCount == "0" {
                 notificationBadge.hideBadge()
            }
            else {
                notificationBadge.showBadge()
                notificationBadge.badgeString = "\(Sharedata.shareInfo.notificationCount ?? "0")"
            }
           
            
        }
        
        
     
        notificationBadge.setImage(UIImage(named: "Notification"), for: .normal)
        notificationBadge.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationBadge.addTarget(self, action: #selector(btnNotificationTapped(_:)), for: .touchUpInside)
        
        
        let btnNotification = UIBarButtonItem(customView: notificationBadge)
        
        
        
        //add buttons to navigationsBaR RightBarButtonItems
        self.navigationItem.setRightBarButtonItems([btnCart,btnNotification], animated: true)
        
    }
    
    @objc func btnCardClick (_ sender: Any){
        
        if Sharedata.shareInfo.cartItemsTotal != nil &&  Sharedata.shareInfo.cartItemsTotal == 0 {
            return
        }
     
        let storyBoard = UIStoryboard.init(name: "CheckOut", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "MyCartVC") as! MyCartVC
        self.navigationController?.pushViewController(vc1, animated: true)
        
    }
    
    

    
    func setBarBtnsByAccountType(cartBadgeBtn: MIBadgeButton ) {

        switch myDefaultAccountType {
        case .buyer:
            self.setbuyerBarBtn(cartBadgeBtn: cartBadgeBtn)
        case .seller:
            self.setSellerBarBtn()
        default:
            self.setGuestBarBtn()
            
        }
    }
    
    
    
    
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func confirmationAlert(title: String = "Please Confirm".localized, message: String, completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let options = ["NO".localized, "YES".localized]
        
        for (index, option) in options.enumerated() {
            if index == 0 {
                alertController.addAction(UIAlertAction.init(title: option, style: .cancel, handler: { (action) in
                    completion(index)
                }))
            }
            else {
                alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                    completion(index)
                }))
            }
           
        }
        self.present(alertController, animated: true, completion: nil)
    }
}


extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}



extension UIViewController {
    
    func configSemention(_ content: [SegmentioItem], mySegmentView: Segmentio ) {
        
        let bottomIndicator = SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 3,
            color: #colorLiteral(red: 0.3019607843, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
        )
        let vLine = SegmentioVerticalSeparatorOptions(ratio: 1, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        let hLine = SegmentioHorizontalSeparatorOptions(type: SegmentioHorizontalSeparatorType.bottom, height: 1, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        
        let myFont = UIFont(name: "Roboto-Medium", size: 18)
        
        let segmentStates = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9882352941, alpha: 1),
                titleFont: myFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize),
                titleTextColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            ),
            selectedState: SegmentioState(
                backgroundColor: #colorLiteral(red: 0.007843137255, green: 0.1450980392, blue: 0.168627451, alpha: 1),
                titleFont: myFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize),
                titleTextColor: .white
            ),
            highlightedState: SegmentioState( //Hold tapped
                backgroundColor: #colorLiteral(red: 0.007843137255, green: 0.1450980392, blue: 0.168627451, alpha: 1),
                titleFont: myFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize),
                titleTextColor:  #colorLiteral(red: 0.3019607843, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
            )
        )
        
        
        let options = SegmentioOptions(
            backgroundColor:  #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9882352941, alpha: 1),
            segmentPosition: .dynamic,
            scrollEnabled: true,
            indicatorOptions: bottomIndicator,
            horizontalSeparatorOptions: hLine,
            verticalSeparatorOptions: vLine,
            imageContentMode: .center,
            labelTextAlignment: .center,
            segmentStates: segmentStates
        )
        
        mySegmentView.setup(
            content: content,
            style: SegmentioStyle.onlyLabel,
            options: options
        )
    }
    
    
}
