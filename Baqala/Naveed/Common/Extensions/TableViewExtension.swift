//
//  TableViewExtension.swift
//  Delivigo
//
//  Created by Muhammad Naveed on 10/2/18.
//  Copyright © 2018 Muhammad Naveed. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCustomCell( withCellId: String) {
        let nib = UINib(nibName: withCellId, bundle: nil)
        self.register(nib, forCellReuseIdentifier: withCellId)
    }
    func registerCustomHeaderFooterCell( withCellId: String) {
        let nib = UINib(nibName: withCellId, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: withCellId)
    }

}
extension UICollectionView {
    func registerCustomCell( withCellId: String) {
        let nib = UINib(nibName: withCellId, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: withCellId)
    }
}
