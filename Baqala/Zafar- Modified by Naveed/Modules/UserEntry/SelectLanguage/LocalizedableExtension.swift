//
//  LocalizaedableExtension.swift
//  Baqala
//
//  Created by Macbook on 12/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation
import UIKit


extension String {
    
    var localized: String {
      
        if let _ = UserDefaults.standard.string(forKey: "myDefaultLanguage") {} else {
            // we set a default, just in case
            UserDefaults.standard.set("en", forKey: "myDefaultLanguage")
            UserDefaults.standard.synchronize()
          
        }
        
        let lang = UserDefaults.standard.string(forKey: "myDefaultLanguage")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
       
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    
   
}

extension UIViewController {
   
    func setViewDirectionByLanguage()  {
         let lang = UserDefaults.standard.string(forKey: "myDefaultLanguage")
        switch lang {
        case "ar":
             UIView.appearance().semanticContentAttribute = .forceRightToLeft //ar
             UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
        default: // .en
             UIView.appearance().semanticContentAttribute = .forceLeftToRight //en
             UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    
    func setTextFieldDirectionByLanguage(textFields: [UITextField])  {
        let lang = UserDefaults.standard.string(forKey: "myDefaultLanguage")
        switch lang {
        case "ar":
            for tf in textFields {
                tf.textAlignment = .right
            }
            UIView.appearance().semanticContentAttribute = .forceRightToLeft //ar
            UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            
        default: // .en
           
            for tf in textFields {
                tf.textAlignment = .left
            }
            
            UIView.appearance().semanticContentAttribute = .forceLeftToRight //en
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    func setTextViewDirectionByLanguage(textViews: [UITextView])  {
        let lang = UserDefaults.standard.string(forKey: "myDefaultLanguage")
        switch lang {
        case "ar":
            for tf in textViews {
                tf.textAlignment = .right
            }
            
            UIView.appearance().semanticContentAttribute = .forceLeftToRight //en
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
        default: // .en
            for tf in textViews {
                tf.textAlignment = .left
            }
            UIView.appearance().semanticContentAttribute = .forceLeftToRight //en
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
}

extension UITableViewCell {
   
    func setViewDirectionByLanguage()  {
        let lang = UserDefaults.standard.string(forKey: "myDefaultLanguage")
        switch lang {
        case "ar":
            UIView.appearance().semanticContentAttribute = .forceRightToLeft //ar
            UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
        default: // .en
            UIView.appearance().semanticContentAttribute = .forceLeftToRight //en
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    
    func setTextFieldDirectionByLanguage(textFields: [UITextField])  {
        let lang = UserDefaults.standard.string(forKey: "myDefaultLanguage")
        switch lang {
        case "ar":
            for tf in textFields {
                tf.textAlignment = .right
            }
        default: // .en
            for tf in textFields {
                tf.textAlignment = .left
            }
        }
    }
    
    func setTextViewDirectionByLanguage(textViews: [UITextView])  {
        let lang = UserDefaults.standard.string(forKey: "myDefaultLanguage")
        switch lang {
        case "ar":
            for tf in textViews {
                tf.textAlignment = .right
            }
        default: // .en
            for tf in textViews {
                tf.textAlignment = .left
            }
        }
    }
}
