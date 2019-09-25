//
//  DistanceConfig.swift
//  Baqala
//
//  Created by apple on 12/14/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation


func setDistancInKm(distance: Int ) -> String {
   return "\(distance) Km"
}

//Formatt Floating value
func setDistancInKm (body: Double) -> String {
    let formatted = String(format: "%.2f Km", body)
    return formatted
}

func setInStock(available: Int ) -> String {
    return "in Stock: \(available)"
}
