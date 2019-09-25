//
//  DateFormatConfig.swift
//  Baqala
//
//  Created by apple on 12/28/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit


func setformatDateBy( dateString: String) -> String {
    
    //return if T not found in Date String
    if !dateString.contains("T") {
        return "Split keyword Not Found"
    }
    
    //seprate by T
    let datecomponents = dateString.components(separatedBy: "T")
    let splitDate = datecomponents[0]
    //let splitTime = datecomponents[1]
    
    // API Format
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .iso8601)
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: splitDate)
    
    //New Format
    let newFormate = DateFormatter()
    newFormate.dateFormat = "dd MMM yyyy"
    return newFormate.string(from: date!)
}
