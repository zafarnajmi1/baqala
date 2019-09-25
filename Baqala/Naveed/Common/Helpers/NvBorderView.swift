//
//  NvBorderView.swift
//  Baqala
//
//  Created by apple on 2/4/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation

@IBDesignable
class NvBorderView: UIView{
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        
        didSet{
            
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
    }
    
}
