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
func setDefaultLanguage(body : Title)-> String  {
   
    let defaultEn = body.en
   
    var myTitle = myDefaultLanguage == .en ? body.en: body.ar
   
     //if arabic is empty then show english title
    myTitle = myTitle == "" ? defaultEn: myTitle
    
    return myTitle ?? ""
}

func setDefaultLanguage(body : Message)-> String  {
    
    let defaultEn = body.en
  
    var myMessage = myDefaultLanguage == .en ? body.en: body.ar
   //if arabic is empty then show english title
    myMessage = myMessage == "" ? defaultEn: myMessage

    return myMessage ?? ""
}
//language String formatters based on selected langauge
func setDefaultLanguage(body : ProductName)-> String  {
    
    let defaultEn = body.en
    
    var myTitle = myDefaultLanguage == .en ? body.en: body.ar
    
    //if arabic is empty then show english title
    myTitle = myTitle == "" ? defaultEn: myTitle
    
    return myTitle ?? ""
}

//language String formatters based on selected langauge
func setDefaultLanguage(body : StoreName)-> String  {
    
    let defaultEn = body.en
    
    var myTitle = myDefaultLanguage == .en ? body.en: body.ar
    
    //if arabic is empty then show english title
    myTitle = myTitle == "" ? defaultEn: myTitle
    
    return myTitle ?? ""
}

//language String formatters based on selected langauge
func setDefaultLanguage(body : StoreUpdateMessage)-> String  {
    
    let defaultEn = body.en
    
    var myTitle = myDefaultLanguage == .en ? body.en: body.ar
    
    //if arabic is empty then show english title
    myTitle = myTitle == "" ? defaultEn: myTitle
    
    return myTitle ?? ""
}

//language String formatters based on selected langauge
func setDefaultLanguage(body : userProfileMessage)-> String  {
    
    let defaultEn = body.en
    
    var myTitle = myDefaultLanguage == .en ? body.en: body.ar
    
    //if arabic is empty then show english title
    myTitle = myTitle == "" ? defaultEn: myTitle
    
    return myTitle ?? ""
}

func setDefaultLanguage(body : userProfileStoreName)-> String  {
    
    let defaultEn = body.en
    
    var myTitle = myDefaultLanguage == .en ? body.en: body.ar
    
    //if arabic is empty then show english title
    myTitle = myTitle == "" ? defaultEn: myTitle
    
    return myTitle ?? ""
}
