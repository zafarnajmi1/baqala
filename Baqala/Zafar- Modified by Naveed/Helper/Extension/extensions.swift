//
//  extensions.swift
//  Baqala
//
//  Created by Macbook on 30/11/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//
import UIKit
import Foundation
import MIBadgeButton_Swift

extension UIViewController {
    func hideNavigationBar(animated: Bool = false) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func showNavigationBar(animated: Bool = false) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    public func setCustomNavigationBar(){
        
        let navColor = UIColor(red: 77/255, green: 184/255, blue: 84/255, alpha: 1.0)
        let color: UIColor = navColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 20)! , NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
    }
    
}
extension UIViewController {
    func displayNavigationBarActivityIndicator() {
        let indicator = UIActivityIndicatorView(style: .white)
        indicator.startAnimating()
        navigationItem.titleView = indicator
    }
    
    func dismissNavigationdaBarActivityIndicator() {
        navigationItem.titleView = nil
    }
    
    func setBackButton(){
        
        navigationItem.hidesBackButton = true
        var backImage: UIImage = #imageLiteral(resourceName: "BackArrow")
        if myDefaultLanguage == .ar {
            backImage = #imageLiteral(resourceName: "BackArrowArabic")
        }
        
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(onBackButtonClciked))
        navigationItem.leftBarButtonItem  = backButton
        
    }
    
    @objc func onBackButtonClciked(){
        navigationController?.popViewController(animated: true)
    }
    
}




extension UIViewController
{
    open func DissmissVc(completion: (()->Void)? ){
        dismiss(animated: true, completion: nil)
}
    
}

extension UIView
{
    func setLightGrayBorder(){
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = 1
    }
    
    
    
    func makeRoundedView() {
        
            let radius = self.frame.width/2.0
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
        
    
    
}

extension UICollectionView
{
    func  adjustDesign(width: CGFloat)   {
        
        let collectionViewSize = self.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewSize.itemSize.width = width
        
    }
    
}

extension UIImageView
{
    func setCircle() {
        
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func setRoundidCornerWithBorder() {
        
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.3098039216, green: 0.4156862745, blue: 0.431372549, alpha: 1)
        self.layer.masksToBounds = true
    }
    
}
extension UIButton
{
    
    func ButtonDesign()
    {
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = 1
    }
}
extension UITextView
{
    
    func TextViewDesign()
    {
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = 1
    }
}
extension UIViewController
{
    
    func addNavigationButton() {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "Cart"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(btnCardClick(_:)), for: .touchUpInside)
        let btnCart = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "Notification"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(btnNotificationTapped(_:)), for: .touchUpInside)
        let btnNotification = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.setRightBarButtonItems([btnCart,btnNotification], animated: true)
        
    }
    
    @IBAction func advanceSearchBtn (_ sender: Any){
        let storyBoard = UIStoryboard.init(name: "Core", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "AdvanceSearchVC") as! AdvanceSearchVC
        self.navigationController?.pushViewController(vc1, animated: true)
        
    }
    
  
    @objc func btnNotificationTapped (_ sender: Any)
    {
        let storyBoard = UIStoryboard.init(name: "Core", bundle: nil)
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
    
    
    
    //MARK:- GuestLogin
    func setGuestBarBtn()
    {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "Guest"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(btnLoginGuesttaped(_:)), for: .touchUpInside)
        let btnCart = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .custom)
        //btn2.setImage(UIImage(named: "Notification"), for: .normal)
        btn2.setTitle("Login".localized, for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(btnLoginGuesttaped(_:)), for: .touchUpInside)
        let btnNotification = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.setRightBarButtonItems([btnNotification,btnCart], animated: true)
        
    }
    
    func setSellerBarBtn(){

        
        let  notificationBadge = MIBadgeButton(type: .custom)
        
        notificationBadge.badgeBackgroundColor = #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)
        notificationBadge.badgeTextColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        
        notificationBadge.verticalMargin = 0
        notificationBadge.horizontalMargin = 0
        notificationBadge.badgeEdgeInsets = UIEdgeInsets(top: 6, left: 28, bottom: 0, right:0)
        
        if Sharedata.shareInfo.notificationCount != nil  {
            
            
            if Sharedata.shareInfo.notificationCount == "0" {
                notificationBadge.hideBadge()
            }
            else {
                notificationBadge.showBadge()
                notificationBadge.badgeString = "\(Sharedata.shareInfo.notificationCount ?? "0")"
            }
            
            
        }
        
        
        
        notificationBadge.setImage(UIImage(named: "Notification"), for: .normal)
        notificationBadge.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        notificationBadge.addTarget(self, action: #selector(btnNotificationTapped(_:)), for: .touchUpInside)
        
        
        let btnNotification = UIBarButtonItem(customView: notificationBadge)
        
        
        
        //add buttons to navigationsBaR RightBarButtonItems
        self.navigationItem.setRightBarButtonItems([btnNotification], animated: true)
        
    }
    
    
    
    
    @objc func btnLoginGuesttaped (_ sender: Any)
    {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
    
    
    
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}


extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize, minusHeight: CGFloat) -> UIImage {
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: (size.height - minusHeight))
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
extension UITableView {
    
    @IBInspectable
    var isEmptyRowsHidden: Bool {
        get {
            return tableFooterView != nil
        }
        set {
            if newValue {
                tableFooterView = UIView(frame: .zero)
            } else {
                tableFooterView = nil
            }
        }
    }
}

extension Date {
    
    func years(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.year], from: sinceDate, to: self).year
    }
    
    func months(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: sinceDate, to: self).month
    }
    
    func days(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }
    
    func hours(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.hour], from: sinceDate, to: self).hour
    }
    
    func minutes(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.minute], from: sinceDate, to: self).minute
    }
    
    func seconds(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.second], from: sinceDate, to: self).second
    }
    
}
extension Date {
    
    public static let minutesInAWeek = 24 * 60 * 7
    
    /// EZSE: Initializes Date from string and format
    public init?(fromString string: String, format: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let date = formatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
    
    /// EZSE: Initializes Date from string returned from an http response, according to several RFCs / ISO
    public init?(httpDateString: String) {
        if let rfc1123 = Date(fromString: httpDateString, format: "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz") {
            self = rfc1123
            return
        }
        if let rfc850 = Date(fromString: httpDateString, format: "EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z") {
            self = rfc850
            return
        }
        if let asctime = Date(fromString: httpDateString, format: "EEE MMM d HH':'mm':'ss yyyy") {
            self = asctime
            return
        }
        if let iso8601DateOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd") {
            self = iso8601DateOnly
            return
        }
        if let iso8601DateHrMinOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mmxxxxx") {
            self = iso8601DateHrMinOnly
            return
        }
        if let iso8601DateHrMinSecOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mm:ssxxxxx") {
            self = iso8601DateHrMinSecOnly
            return
        }
        if let iso8601DateHrMinSecMs = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mm:ss.SSSxxxxx") {
            self = iso8601DateHrMinSecMs
            return
        }
        //self.init()
        return nil
    }
    
    /// EZSE: Converts Date to String
    public func toString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    
    /// EZSE: Converts Date to String, with format
    public func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /// EZSE: Calculates how many days passed from now to date
    public func daysInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/86400)
        return diff
    }
    
    /// EZSE: Calculates how many hours passed from now to date
    public func hoursInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/3600)
        return diff
    }
    
    /// EZSE: Calculates how many minutes passed from now to date
    public func minutesInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/60)
        return diff
    }
    
    /// EZSE: Calculates how many seconds passed from now to date
    public func secondsInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff)
        return diff
    }
    
    /// EZSE: Easy creation of time passed String. Can be Years, Months, days, hours, minutes or seconds
    public func timePassed() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: self, to: date, options: [])
        var str: String
        
        if components.year! >= 1 {
            components.year == 1 ? (str = "year") : (str = "years")
            return "\(components.year!) \(str) ago"
        } else if components.month! >= 1 {
            components.month == 1 ? (str = "month") : (str = "months")
            return "\(components.month!) \(str) ago"
        } else if components.day! >= 1 {
            components.day == 1 ? (str = "day") : (str = "days")
            return "\(components.day!) \(str) ago"
        } else if components.hour! >= 1 {
            components.hour == 1 ? (str = "hour") : (str = "hours")
            return "\(components.hour!) \(str) ago"
        } else if components.minute! >= 1 {
            components.minute == 1 ? (str = "minute") : (str = "minutes")
            return "\(components.minute!) \(str) ago"
        } else if components.second == 0 {
            return "Just now"
        } else {
            return "\(components.second!) seconds ago"
        }
    }
    
    /// EZSE: Check if date is in future.
    public var isFuture: Bool {
        return self > Date()
    }
    
    /// EZSE: Check if date is in past.
    public var isPast: Bool {
        return self < Date()
    }
    
    // EZSE: Check date if it is today
    public var isToday: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: self) == format.string(from: Date())
    }
    
    /// EZSE: Check date if it is yesterday
    public var isYesterday: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        return format.string(from: self) == format.string(from: yesterDay!)
    }
    
    /// EZSE: Check date if it is tomorrow
    public var isTomorrow: Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        return format.string(from: self) == format.string(from: tomorrow!)
    }
    
    /// EZSE: Check date if it is within this month.
    public var isThisMonth: Bool {
        let today = Date()
        return self.month == today.month && self.year == today.year
    }
    
    /// EZSE: Check date if it is within this week.
    public var isThisWeek: Bool {
        return self.minutesInBetweenDate(Date()) <= Double(Date.minutesInAWeek)
    }
    
    /// EZSE: Get the era from the date
    public var era: Int {
        return Calendar.current.component(Calendar.Component.era, from: self)
    }
    
    /// EZSE : Get the year from the date
    public var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    /// EZSE : Get the month from the date
    public var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    /// EZSE : Get the weekday from the date
    public var weekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    // EZSE : Get the month from the date
    public var monthAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    // EZSE : Get the day from the date
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// EZSE: Get the hours from date
    public var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// EZSE: Get the minute from date
    public var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    /// EZSE: Get the second from the date
    public var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    /// EZSE : Gets the nano second from the date
    public var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    
    #if os(iOS) || os(tvOS)
    
    /// EZSE : Gets the international standard(ISO8601) representation of date
    @available(iOS 10.0, *)
    @available(tvOS 10.0, *)
    public var iso8601: String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }
    
    #endif
}

//extension UIImageView {
//    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
//        contentMode = mode
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() {
//                self.image = image
//            }
//            }.resume()
//    }
//    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
//}
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error!)")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
