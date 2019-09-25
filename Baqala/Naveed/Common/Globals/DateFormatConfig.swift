//
//  DateFormatConfig.swift
//  Baqala
//
//  Created by apple on 12/28/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit


func setDateFormatBy( dateString: String) -> String {
    
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

func setTimefromatBy( date: String ) -> String {
    if date == "" {
        return ""
    }
    
    let dateformetter = DateFormatter()
    dateformetter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    dateformetter.timeZone = (NSTimeZone(name: "UTC")! as TimeZone)
    let date = dateformetter.date(from: date)
    
    let outputFormeter = DateFormatter()
    outputFormeter.dateFormat = "hh:mm a"
    
    return  outputFormeter.string(from: date!)
}


 func setTimeAgoFormatBy(dateString: String) -> String {
    
    if dateString == "" {
        return ""
    }
    
    let dateFormetter = DateFormatter()
    dateFormetter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    
    dateFormetter.timeZone = (NSTimeZone(name: "UTC")! as TimeZone)
    let date = dateFormetter.date(from: dateString)
    
    print(date!)
    let miliseconds = date?.timeIntervalSince1970
    print(miliseconds!)
    return  fromateTimeby(TimeInMilliSeconds: Double(miliseconds!))
}


func fromateTimeby(TimeInMilliSeconds : Double) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(TimeInMilliSeconds))
    let currentDate = Date()
    let second = currentDate.secondsInBetweenDate(date)
    let minutes : Int = Int(second/60)
    let hours : Int = Int(second/3600)
    let days  : Int = Int(second/(3600 * 24))
    
    if (days > 0 && days < 31)
    {
       
        return String(days) + " days ago".localized
    }
    
    if(hours > 0 && hours < 25)
    {
        return String(hours) + " hours ago".localized
    }
    if(minutes > 0 && minutes < 60)
    {
        return String(minutes) + " minutes ago".localized
    }
    
    if(second > 5 && second < 60)
    {
        let sec : Int = Int(round(second))
        return String(sec) + " second ago".localized
    }
    if(second <= 5)
    {
        return "just now".localized;
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "dd MMM yyyy"
    return dateFormatter.string(from: date)
}
