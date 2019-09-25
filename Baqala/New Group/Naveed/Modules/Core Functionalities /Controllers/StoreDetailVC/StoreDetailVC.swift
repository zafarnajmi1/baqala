//
//  StoreDetailVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import Segmentio
class StoreDetailVC: UIViewController {
    //MARK:- protocols
    //MARK:- outlets
    

    @IBOutlet weak var tableView: UITableView!
    //MARK:- properties and Structures
    //MARK:- lifeCycle
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.setNavigationBar()
        self.loadSegmentList()
        self.tableView.registerCustomCell(withCellId: "StoreDetailSubmitTableViewCell")
        self.tableView.registerCustomCell(withCellId: "StoreReviewTableViewCell")
        self.tableView.registerCustomHeaderFooterCell(withCellId: "StoreReviewSectionHeader")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.addBackButton()
        self.title = "Store Detail"
    }


}

//MARK:- base configuration ( on load View)
extension StoreDetailVC{
    
    fileprivate func loadSegmentList() {
        var content = [SegmentioItem]()
        let list = ["Store Description", "Store Products"]
        for value in list {
            let Item = SegmentioItem(title: value, image: nil)
            content.append(Item)
        }
     
    }
    
    
}

//MARK:- actions
extension StoreDetailVC {
    
   
}

//MARK:- tableView Extension
extension StoreDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "StoreReviewSectionHeader") as! StoreReviewSectionHeader
        
        
        headerView.mytitle.text = "Store Reviews"
        
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 1.0 : 32
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    
//        return section == 0 ? "":
//    }
//    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 5  //fixme should be dynamic
        default:
           return 0
        }
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoreReviewTableViewCell") as! StoreReviewTableViewCell
            cell.mydetail.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoreDetailSubmitTableViewCell") as! StoreDetailSubmitTableViewCell
            return cell
        }
        
    }
    
    
}
//MARK:- collectionView Extension
//MARK:- ws: Web Services Requests



//MARK:- helpers ( include form Validation and other Methods )
