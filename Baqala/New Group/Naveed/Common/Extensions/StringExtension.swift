//
//  StringExtension.swift
//  Baqala
//
//  Created by apple on 12/17/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func stringToColor(strValue: String , color: UIColor) -> NSAttributedString {
//        var main_string = "Hello World"
//        var string_to_color = "World"
        
        let range = (self as NSString).range(of: strValue)
        let attributedString = NSMutableAttributedString(string:self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    
    

}
