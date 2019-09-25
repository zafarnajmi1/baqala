//
//  NvLoader.swift
//  Baqala
//
//  Created by apple on 1/16/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {
    //MARK:- LodingMessage
    func showNvLoader()
    {
//        self.startAnimating(Constant.NVActivitySize.size, message: Constant.LoadingMessage.MessageFeedback.rawValue, messageFont: UIFont.systemFont(ofSize: 20), type: NVActivityIndicatorType.ballClipRotate, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        ProgressHUD.present(animated: true)
    }
    
    func hideNvloader() {
//        self.stopAnimating()
        ProgressHUD.dismiss(animated: true)
    }
}
