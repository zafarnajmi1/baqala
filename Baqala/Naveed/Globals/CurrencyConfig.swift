//
//  PriceConfig.swift
//  Baqala
//
//  Created by apple on 12/14/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation

import Foundation


//MARK:- Price Currency type handling
enum currencyType:String {
    case usd
    case aed
}
//selected default
var myDefaultCurrency = currencyType.usd

//language String formatters based on selected langauge
func setDefaultCurrency(body : Price)-> String  {
    let result = myDefaultCurrency == .usd ? "$ \(body.usd ?? 0)":"AED \(body.aed ?? 0)"
    return result
}

func setDefaultCurrency(price : Int)-> String  {
    let result = myDefaultCurrency == .usd ? "$ \(price )":"AED \(price)"
    return result
}

//Formatt Floating value
func setPriceWithDecimalPoint (body: Double) -> String {
    let formatted = String(format: "%.2f", body)
    return formatted
}
