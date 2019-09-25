//
//  LanguageConfig.swift
//  Baqala
//
//  Created by apple on 12/14/18.
//  Copyright © 2018 My Technology. All rights reserved.

import Foundation


//MARK:- lanaguage handling
enum languageType:String {
    case en
    case ar
}
//selected default
var myDefaultLanguage = languageType.en

//language String formatters based on selected langauge
func setDefaultSelectedLanguage(body : Title)-> String  {
    let emptyValue = "Missing Title : \(myDefaultLanguage)"
    var result = myDefaultLanguage == .en ? body.en: body.ar
    result = result == "" ? emptyValue: result
    return result ?? emptyValue
}

func setDefaultSelectedLanguage(body : Message)-> String  {
    let emptyValue = "Missing Title : \(myDefaultLanguage)"
    var result = myDefaultLanguage == .en ? body.en: body.ar
    result = result == "" ? emptyValue: result
    return result ?? emptyValue
}
