//
//  VCTabRegister.swift
//  Baqala
//
//  Created by Macbook on 07/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class VCTabRegister: ButtonBarPagerTabStripViewController {
    /*settings.style.buttonBarBackgroundColor = .clear
     settings.style.buttonBarItemBackgroundColor = .clear
     settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.8196078431, green: 0.1254901961, blue: 0.1725490196, alpha: 1)
     
     settings.style.buttonBarItemFont = UIFont(name: "OpenSans-semibold", size: 15)!
     
     settings.style.selectedBarHeight = 4
     settings.style.buttonBarMinimumLineSpacing = 0.1
     settings.style.buttonBarItemTitleColor = .clear
     settings.style.selectedBarBackgroundColor = .clear
     settings.style.buttonBarBackgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1);
     settings.style.buttonBarItemsShouldFillAvailiableWidth = true
     settings.style.buttonBarLeftContentInset = 0
     settings.style.buttonBarRightContentInset = 0
     
     
     //
     //        settings.style.buttonBarBackgroundColor = .clear
     //        settings.style.buttonBarItemBackgroundColor = .clear
     //        settings.style.buttonBarItemTitleColor = self.btnTapSelectColor
     //        settings.style.buttonBarItemFont = UIFont(name: "Raleway-Medium", size: 15)! //.boldSystemFont(ofSize: 16)
     //
     //        settings.style.buttonBarMinimumLineSpacing = 0
     //        settings.style.buttonBarItemTitleColor = UIColor.darkGray
     //        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
     //        settings.style.buttonBarLeftContentInset = 5
     //        settings.style.buttonBarRightContentInset = 5
     
     
     
     changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
     guard changeCurrentIndex == true else { return }
     //            oldCell?.label.textColor = #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1)
     //            newCell?.label.textColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)
     //
     
     oldCell?.label.textColor = UIColor.darkGray
     oldCell?.backgroundColor = .white
     
     newCell?.label.textColor = .white
     newCell?.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.003921568627, blue: 0.2039215686, alpha: 1)
     
     
     }
     
     collectionViewPager.layer.borderWidth = 1
     collectionViewPager.layer.borderColor = UIColor.init(red: 247, green: 247, blue: 247, alpha: 1).cgColor
     super.viewDidLoad()
     //fetchProductInfo(storeid, isRefresh: false)
     }*/
    @IBOutlet var RegisterCollectionView: ButtonBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /*settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = #colorLiteral(red: 0.007843137255, green: 0.1450980392, blue: 0.168627451, alpha: 1)
        settings.style.buttonBarItemFont = UIFont(name: "Roboto-Regular", size: 17)!
        //settings.style.selectedBarHeight = 0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .red
        settings.style.selectedBarBackgroundColor = UIColor.red
        settings.style.buttonBarBackgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0*/
        
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.007843137255, green: 0.1450980392, blue: 0.168627451, alpha: 1)
        
        settings.style.buttonBarItemFont = UIFont(name: "Roboto-Regular", size: 17)!
        
        settings.style.selectedBarHeight = 4
        settings.style.buttonBarMinimumLineSpacing = 0.6
        settings.style.buttonBarItemTitleColor = .clear
        settings.style.selectedBarBackgroundColor = .clear
        settings.style.buttonBarBackgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1);
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = #colorLiteral(red: 0.007843137255, green: 0.1450980392, blue: 0.168627451, alpha: 1)
            newCell?.label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        }
        }
    

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Register"
        setCustomNavigationBar()
        setBackButton()
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VCRegister")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VCRegisterSeller")
        return [child_1,child_2]
    }
    
}
