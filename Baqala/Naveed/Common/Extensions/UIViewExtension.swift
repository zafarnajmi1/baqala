//
//  UIViewExtension.swift
//  Baqala
//
//  Created by apple on 12/4/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func setBorderColor(color: CGColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) )
    {
        self.layer.borderColor = color
        self.layer.borderWidth = 1
    }
    func setLightGrayBorder(color: CGColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5) )
    {
        self.layer.borderColor = color
        self.layer.borderWidth = 1
    }
    
   
    func setCornerRadius(radius: CGFloat) {
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setLightShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2
       
    }
    
  
    
}
