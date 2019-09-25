//
//  PriceConfig.swift
//  Baqala
//
//  Created by apple on 12/14/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation



//MARK:- Price Currency type handling
enum currencyType:String {
    case usd
    case aed
}
//selected default
var myDefaultCurrency = currencyType.aed

//language String formatters based on selected langauge
func setDefaultCurrency(body : Price)-> String  {
    let result = myDefaultCurrency == .usd ? setDefaultCurrency(price: body.usd ?? 0):setDefaultCurrency(price: body.aed ?? 0)
    return result
}

func setDefaultCurrency(price : Float)-> String  {
    let formatted = String(format: "%.1f", price)
    let result = myDefaultCurrency == .usd ? "$ \(formatted )":"AED \(formatted)"
    
    return result
}

func setDefaultCurrency(price : Double)-> String  {
    let formatted = String(format: "%.1f", price)
    let result = myDefaultCurrency == .usd ? "$ \(formatted )":"AED \(formatted)"
    
    return result
}

//Formatt Floating value
func setPriceWithDecimalPoint (body: Double) -> String {
    let formatted = String(format: "%.2f", body)
    return formatted
}

// float config

func setRating (body: Float) -> String {
    let formatted = String(format: "%.1f", body)
    return formatted
}
