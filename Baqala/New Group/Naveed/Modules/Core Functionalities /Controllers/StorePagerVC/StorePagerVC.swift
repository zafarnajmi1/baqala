//
//  StorePagerViewController.swift
//  Baqala
//
//  Created by apple on 12/7/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import THSegmentedPager
import Segmentio

class StorePagerVC: THSegmentedPager, THSegmentedPageViewControllerDelegate {

      @IBOutlet weak var mySegment: Segmentio!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageControl.sectionTitles = ["1", "2"]
        self.configSegments()
        self.loadSegmentList()
        self.addBackButton()
        self.title = "selected Store Name"
    }
//    override func viewWillAppear(_ animated: Bool) {
//        self.addBackButton()
//        self.title = "selected Store Name"
//    }


    

}
extension StorePagerVC {
    
    func configSegments() {
        
        setupSegmentControllers()
        
        self.pageControl.segmentWidthStyle = .fixed
        self.pageControl.segmentEdgeInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        self.pageControl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.pageControl.borderType = HMSegmentedControlBorderType(rawValue: 0)
        
        self.pageControl.selectionIndicatorHeight = 2
        self.pageControl.isVerticalDividerEnabled = false
        
        self.pageControl.selectionIndicatorColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        
        self.pageControl.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.init(name: "Roboto-Medium", size: 14)!,
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        ]
        self.pageControl.selectedTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.init(name: "Roboto-Medium", size: 14)!,
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0)
        ]
       
      
        
    }
    
    fileprivate func setupSegmentControllers() {
     
        let pageTitle = ["StoreListVC","Food"]
        let pagesId = ["StoreDetailVC", "ProductListVC"]
        
        self.setupPagesFromStoryboard(withIdentifiers: pagesId)
        
        let sortVc = self.pages[0] as! StoreDetailVC
        sortVc.title = pageTitle[0].capitalized
        
        let foodVc = self.pages[1] as! ProductListVC
        foodVc.title = pageTitle[1].capitalized
        
      
        
        
        pageControl.indexChangeBlock = { index in
            print("Page selected \(index)")
            self.mySegment.selectedSegmentioIndex = index
        }
    }

}


//MARK:- base configuration ( on load View)
extension StorePagerVC{
    
    fileprivate func loadSegmentList() {
        var content = [SegmentioItem]()
        let list = ["Store Description", "Store Products"]
        for value in list {
            let Item = SegmentioItem(title: value, image: nil)
            content.append(Item)
        }
        self.mySegment.configSementio(content)
        self.segmentDidTapped()
    }
    
    
}

//MARK:- actions
extension StorePagerVC {
    
    fileprivate func segmentDidTapped() {
        
        self.mySegment.selectedSegmentioIndex = 0
        self.mySegment.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
        }
    }
}
