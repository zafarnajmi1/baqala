//
//  CartConfig.swift
//  Baqala
//
//  Created by apple on 1/16/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation
import MIBadgeButton_Swift

extension UIViewController {
    
    func refresh(cartBadgeBtn: MIBadgeButton) {
        //Update badgNumber
        if Sharedata.shareInfo.cartItemsTotal != nil && Sharedata.shareInfo.cartItemsTotal ?? 0 > 0 {
            cartBadgeBtn.showBadge()
            cartBadgeBtn.badgeString = "\(Sharedata.shareInfo.cartItemsTotal ?? 0)"
        }
        else {
            cartBadgeBtn.hideBadge()
        }
    }
}
