//
//  DistanceConfig.swift
//  Baqala
//
//  Created by apple on 12/14/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation



//Formatt Floating value
func setDistancInKm (body: Double) -> String {
//    if body == 0.0 || body == 0 {
//        return ""
//    }
    let formatted = String(format: "%.1f Km", body)
    return formatted
}

func setInStock(available: Int ) -> String {
    let label =  "In Stock:".localized
    return "\(label) \(available)"
}
