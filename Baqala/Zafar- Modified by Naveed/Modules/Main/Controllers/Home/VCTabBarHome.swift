//
//  VCTabBarHome.swift
//  Baqala
//
//  Created by Macbook on 04/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

class VCTabBarHome: UITabBarController,UITabBarControllerDelegate {
    var UItabbarItem = UITabBarItem()
    var AccoutnType = ""
    
    var  minusHeight = 0
    
    var hasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewDirectionByLanguage()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden =  true
        DesignSelectedTabBarBackGroundColor()
      
        
    }
    
    func DesignSelectedTabBarBackGroundColor()
    {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)], for: .selected)
         UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor(red: 23/255, green: 8/255, blue: 8/255, alpha: 1.0)], for: .normal)
        
      
        UItabbarItem = self.tabBar.items![0]
        let selectedImage1 = UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal)
        let UnselectedImage1 = UIImage(named: "Home-Selected")?.withRenderingMode(.alwaysOriginal)
        UItabbarItem.image = UnselectedImage1
        UItabbarItem.selectedImage = selectedImage1
        UItabbarItem.title = "Home".localized

        
       
        UItabbarItem = self.tabBar.items![1]
        let selectedImage2 = UIImage(named: "Categories-Selected")?.withRenderingMode(.alwaysOriginal)
        let UnselectedImage2 = UIImage(named: "Categories")?.withRenderingMode(.alwaysOriginal)
        UItabbarItem.image = UnselectedImage2
        UItabbarItem.selectedImage = selectedImage2
        UItabbarItem.title = "Categories".localized
       
        UItabbarItem = self.tabBar.items![2]
        let selectedImage3 = UIImage(named: "Store-Selected")?.withRenderingMode(.alwaysOriginal)
        let UnselectedImage3 = UIImage(named: "Stores")?.withRenderingMode(.alwaysOriginal)
        UItabbarItem.image = UnselectedImage3
        UItabbarItem.selectedImage = selectedImage3
        UItabbarItem.title = "Stores".localized
       
        let selectedImage4 = UIImage(named: "Menu-Selected")?.withRenderingMode(.alwaysOriginal)
        let UnselectedImage4 = UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal)
        UItabbarItem = self.tabBar.items![3]
        UItabbarItem.image = UnselectedImage4
        UItabbarItem.selectedImage = selectedImage4
        UItabbarItem.title = "Menu".localized
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       // self.selectedIndex = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        
        if(hasTopNotch){
            minusHeight = Int(30.0)
        }
        
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: #colorLiteral(red: 8.392983727e-05, green: 0.1435147822, blue: 0.1679419279, alpha: 1) , size: tabBarItemSize, minusHeight: CGFloat(minusHeight))
    }
    

    
    
    
}
