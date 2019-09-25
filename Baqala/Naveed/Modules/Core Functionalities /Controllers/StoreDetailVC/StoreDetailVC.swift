//
//  StoreDetailVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import Segmentio
import NVActivityIndicatorView
import  Cosmos
import DropDown


protocol StoreDetailVCDelegate: class {
    func willApper(bool: Bool)

}


class StoreDetailVC: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    
  
    var storeId = ""
    var canUserReview : [storeDetailCanReviewUsers]?
    var storeDetailArray : [storeDetailData]?


 
  
    var myRootStoreReviewModel = RootStoreReviewModel()
    var myRootStoreDetailModel = RootStoreDetailModel()
  

    var canSubmitReview : Bool = false
    
    
    //MARK:- properties and Structures
    var productList = [AnyObject]()
    
    var productrating = 0
    let dropdown = DropDown()
    var selectId = ""
    var delegate: StoreDetailVCDelegate?
 
    
    //MARK:- lifeCycle
  

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.storeId)
        
     
        self.requestToFetchStoreDetail()
        

        self.setCustomNavigationBar()
        self.loadSegmentList()
        
        self.tableView.registerCustomCell(withCellId: "StoreDetailTableViewCell")
        self.tableView.registerCustomCell(withCellId: "StoreDetailSubmitTableViewCell")
        self.tableView.registerCustomCell(withCellId: "StoreReviewTableViewCell")
        self.tableView.registerCustomHeaderFooterCell(withCellId: "StoreReviewSectionHeader")
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButton()
        self.title = "Store Detail".localized
        self.delegate?.willApper(bool: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.delegate?.willApper(bool: false)
    }
    
    
    
    
    //MARK:- SubMitDrowpDownHereCall
    func tabpedSelectProduct(cell: StoreDetailSubmitTableViewCell) {
        Checkdropdown(cell: cell)
        dropdown.show()
    }
    
    func Checkdropdown(cell: StoreDetailSubmitTableViewCell) {
        var singleProduct = [String]()
        
        dropdown.anchorView = cell.btnselectProduct
        for pList in self.productList
        {
            singleProduct.append((pList["productName"] as! String))
        }
        dropdown.dataSource = singleProduct
        
        dropdown.selectionAction = {[unowned self](index: Int, item: String) in
            for pList in self.productList
            {
                if(item == pList["productName"] as! String)
                {
                    self.selectId = (pList["id"] as? String)!
                    print(self.selectId)
                }
            }
            cell.against.text = item
        }
        
        
    }
    
    
    
    
    func requestToFetchStoreDetail()  {
        
        self.showNvLoader()
        
        let latti = Sharedata.shareInfo.userLatitude
        let longi = Sharedata.shareInfo.userLongitude
        let location = [latti, longi] as! [Double]
        
        StoreManager.shared.getStoreDetail(storeId: self.storeId, location: location) { (error, rootModel) in
            
            self.hideNvloader()
            
            if error == nil {
                self.myRootStoreDetailModel = rootModel!
                self.tableView.reloadData()
            }
            else {
                nvMessage.showError(body: error!)
            }
            
        }
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
extension StoreDetailVC: StoreDetailSubmitTableViewCellDelegate {
    func refreshController() {
        self.requestToFetchStoreDetail()
    }
    
    
}

//MARK:- tableView Extension
extension StoreDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "StoreReviewSectionHeader") as! StoreReviewSectionHeader
        
        switch section {
        case 0:
            return nil
        default:
            
            headerView.mytitle.text = "Store Reviews".localized
            return headerView

        }
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        switch section{
        case 0:
        return 0
        default: // Store Review Section Hight
                return 32
            
        }

    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            if self.myRootStoreDetailModel.data == nil {
                return 0 // no data
            }
            if self.myRootStoreDetailModel.data?.canReviewUsers != nil && myDefaultAccountType == .buyer {
                return 2  // store detail and submit review cell
            }
            
            return  1// store detail cell
        case 1:
            let reviews = self.myRootStoreDetailModel.data?.reviews
            if reviews != nil && reviews?.count == 0 {
                  return 1
            }
            return self.myRootStoreDetailModel.data?.reviews?.count ?? 0//
        default:
           return 0
        }
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        switch indexPath.section {
       
        case 1: // section 2 at index > 1
          
            let reviews = self.myRootStoreDetailModel.data?.reviews
            if reviews != nil && reviews?.count == 0 {
               let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.textLabel?.text = "No Reviews".localized
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                return cell
            }
            
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoreReviewTableViewCell") as! StoreReviewTableViewCell
            
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
           // let model = self.myRootStoreReviewModel.data?.storeReviews![indexPath.row]
            let model = self.myRootStoreDetailModel.data?.reviews![indexPath.row]
            cell.setDataBy(model: model!)
            
            
            return cell
            
            
        default: // section 1 at index 0
            
            //block only buyer and cansubmit review if is true
            if  self.myRootStoreDetailModel.data?.canReviewUsers != nil && myDefaultAccountType == .buyer {
                
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "StoreDetailTableViewCell") as! StoreDetailTableViewCell
                    cell.setData(root: self.myRootStoreDetailModel)
                    return cell
                }
                else if indexPath.row == 1 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "StoreDetailSubmitTableViewCell") as! StoreDetailSubmitTableViewCell
                    cell.myVC = self
                    cell.delegate = self
                    cell.storeId = self.storeId
                    cell.setData(root: self.myRootStoreDetailModel)
                   
                    
                    return cell
                }
                
            }
            
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "StoreDetailTableViewCell") as! StoreDetailTableViewCell
                    cell.setData(root: self.myRootStoreDetailModel)
                return cell
            }
          
        }
        return UITableViewCell()
    }
    
   

   
    
}

//MARK:- collectionView Extension
//MARK:- ws: Web Services Requests



//MARK:- helpers ( include form Validation and other Methods )
