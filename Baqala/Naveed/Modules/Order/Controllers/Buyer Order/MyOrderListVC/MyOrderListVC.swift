//
//  MyOrderListVC.swift
//  Baqala
//
//  Created by apple on 12/5/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import Segmentio
import PullToRefreshKit

class MyOrderListVC: UIViewController {

    //MARK:- outlets
   
    @IBOutlet weak var mySegmentView: Segmentio!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- properties and Structures
     fileprivate var myRootModel = RootOrderListModel()
   
 
    //MARK:- lifeCycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        viewWillAppear(false)
      
       
        
      
      
   
    }
    override func viewWillAppear(_ animated: Bool) {

        self.title = "My Orders".localized
        self.setCustomNavigationBar()
        self.setBackButton()
        
        self.tableView.registerCustomCell(withCellId: "MyOrderTableViewCell")
        
        self.configureTableViewRefresh(status: "confirmed")
        self.mySegmentView.selectedSegmentioIndex = 0
        self.loadSegmentList()
    }
    
    
    
   //MARK:- actions
    


    //MARK:- base configuration ( on load View)

    fileprivate func configureTableViewRefresh(status: String) {
        let header = DefaultRefreshHeader.header()
        self.tableView.configRefreshHeader(with: header,container:self) { [weak self] in
            //call your function to update table View
            self?.requestToFethcMyOrderListBy(status: status)
            
        }
        delay(bySeconds: 0.2, closure: {
            self.tableView.switchRefreshHeader(to: .refreshing)
        })
        
    }
    
    
    fileprivate func loadSegmentList() {
        
        let titleList = ["Confirmed".localized,
                         "Shipped".localized,
                         "Completed".localized]
        
        var content = [SegmentioItem]()
        
        for title in titleList {
            let tornadoItem = SegmentioItem(title: title , image: nil)
            content.append(tornadoItem)
        }
        configSemention(content, mySegmentView: self.mySegmentView )
        // call webservice on load 0 index
        //self.mySegmentView.selectedSegmentioIndex = 0
        //self.configureTableViewRefresh(status: "confirmed")
        
        self.mySegmentView.valueDidChange = { segmentio, segmentIndex in
            
            switch segmentIndex {
            case 0:
                self.configureTableViewRefresh(status: "confirmed")
                myOrderSelectedStatus = .confirmed
            case 1:
                
                self.configureTableViewRefresh(status: "shipped")
                myOrderSelectedStatus = .shipped
            case 2:
                self.configureTableViewRefresh(status: "completed")
                myOrderSelectedStatus = .completed
            default:
                print("Selected item: ", segmentIndex)
            }
            
        }
    }


    //MARK:- ws: Web Services Requests
    
    func requestToFethcMyOrderListBy(status: String )  {
        
        //desable user interacation
        self.mySegmentView.isUserInteractionEnabled = false
        
        OrderManager.shared.fetchListBy(status: status , completion: { (error, rootModel) in
            
            if error == nil {
               
                self.myRootModel = rootModel!
                self.tableView.reloadData()
                self.tableView.switchRefreshHeader(to: .normal(.success, 0.0))
                
                if rootModel?.data?.count == 0 {
                    nvMessage.showError(body: appConstant.noMoreData)
                }
            }
            else{
                nvMessage.showError(body: error!)
                self.tableView.switchRefreshHeader(to: .normal(.failure, 0.0))
            }
            
            delay(bySeconds: 0.5, closure: {
                //enable user interacation
                self.mySegmentView.isUserInteractionEnabled = true
            })
        })
    }
    
    
}

//MARK:- tableView Extension

extension MyOrderListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myRootModel.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTableViewCell") as! MyOrderTableViewCell
    
        cell.myVC = self
        cell.setData(model: self.myRootModel, index: indexPath.row)

        return cell
    }
    
    
}





//MARK:- helpers ( include form Validation and other Methods )
