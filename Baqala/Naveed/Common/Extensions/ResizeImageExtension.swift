//
//  ResizeImageExtension.swift
//  Baqala
//
//  Created by apple on 2/28/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

extension UIImage {
    func resizeImage(newHeight: CGFloat = 600) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func getFileSizeInMB ()-> String {
        
        
        let img1Data: NSData  = NSData(data: self.jpegData(compressionQuality: 0.0)!)
        
        let byteCount = img1Data.length// replace with data.count
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(byteCount))
        print(string)
        
        return string
    }
}
