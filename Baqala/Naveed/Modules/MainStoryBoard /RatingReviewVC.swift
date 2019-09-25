//
//  RatingReviewVC.swift
//  Baqala
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import UIKit
import PullToRefreshKit
import Cosmos

class RatingReviewVC: UIViewController {

  
    //MARK:- outlets
    
    @IBOutlet weak var tableView: UITableView!
    //for store rating
    @IBOutlet weak var comosRating: CosmosView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var totalReviews: UILabel!
    @IBOutlet weak var storeReviewsLabel: UILabel!
    //MARK:- properties and Structures
    
    var myRootStoreReviewModel = RootStoreReviewModel()
    var myRootProfileModel = RootProfileModel()
    
   
    var nextPage = 1
    var totalPage: Int?
    //MARK:- lifeCycle
    
    //MARK:- base configuration ( on load View)
    //MARK:- actions
  
 
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Rating & Reviews".localized
        
        //navigation setup
        self.setCustomNavigationBar()
        self.setBackButton()
        if myDefaultAccountType == .seller {
            self.setSellerBarBtn()
        }
        //register custom cell
        self.tableView.registerCustomCell(withCellId: "StoreReviewTableViewCell")
        
        //API Call
        requestToFetchUserProfile()
        self.refreshData()
        //load pagination setup on scroll
        self.refreshData()
        
      
    }
    
    func refreshData()  {
        
        let rating = self.myRootProfileModel.data?.averageRating ?? 0
        self.comosRating.rating = Double(rating)
        self.rating.text = setRating(body: rating)
        let totalReviews = self.myRootProfileModel.data?.reviews?.count ?? 0
        let review = "Reviews".localized
        self.totalReviews.text =  "(\(totalReviews)) \(review)"
        self.storeReviewsLabel.text = "Store Reviews".localized
    }
    
    
  
    
    
    
    //MARK:- ws: Web Services Requests
    
    func requestToFetchUserProfile() {
        
        self.showNvLoader()
        //service call
        ProfileManager.shared.getUserProfile { (error, rootModel) in
            
            self.hideNvloader()
            //API Call
            self.requestToFetchStoreReviews()
            
            if error == nil {
                self.myRootProfileModel = rootModel!
                self.refreshData()
                
            }
            else {
                nvMessage.showError(body: error!)
            }
        }
    }
    
    func requestToFetchStoreReviews()  {
        
        self.showNvLoader()
       //default seller store id set in manager
        StoreManager.shared.getStoreReviews(Page: self.nextPage, storeId: nil) { (error, rootModel) in
           
            self.hideNvloader()
            ProgressHUD.dismiss(animated: true)
            
            
            
            if error == nil  {
                if self.nextPage == 1 {
                     self.myRootStoreReviewModel = rootModel!
                }
                else {
                    if let reviewList = rootModel?.data?.storeReviews {
                        self.myRootStoreReviewModel.data?.storeReviews!.append(contentsOf: reviewList)
                    }
                }
                
                self.tableView.reloadData()
            }
            else {
                nvMessage.showError(body: error!)
            }
            
            
            let pagination = rootModel!.data?.pagination
            self.totalPage = pagination?.pages
            
            if pagination!.pages! >= self.nextPage {
                self.nextPage =  (pagination?.next)!
            }
            
            
        }
        
        
        
        
        
        
    }
    

}

   //MARK:- tableView Extension
extension RatingReviewVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myRootStoreReviewModel.data?.storeReviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreReviewTableViewCell") as! StoreReviewTableViewCell
       
        let model = self.myRootStoreReviewModel.data?.storeReviews![indexPath.row]
        cell.setDataBy(model: model!)
        
        return cell
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if (tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height - 20 {
           
            ProgressHUD.present(animated: true)
            
            self.requestToFetchStoreReviews()
           
        }
    }
    
    
}
