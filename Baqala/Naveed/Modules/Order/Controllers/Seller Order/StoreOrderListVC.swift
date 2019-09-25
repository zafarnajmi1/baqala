//
//  StoreOrderListVC.swift
//  Baqala
//
//  Created by apple on 12/4/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import  PullToRefreshKit
import Segmentio


//MARK:- Enums
enum sellerOrderStatus {
    case confirmed
    case shipped
    case completed
}

var sellerOrderSelectedStatus = sellerOrderStatus.confirmed

class StoreOrderListVC: UIViewController {
  
    //MARK:- outlets
    @IBOutlet weak var mySegmentView: Segmentio!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- properties and Structures
    let headerPull = DefaultRefreshHeader.header()
    var myRootModel = RootSellerOrderModel()
   
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWillAppear(false)
       
        self.setCustomNavigationBar()
        self.tableView.registerCustomCell(withCellId: "StoreOrderTableViewCell")
       
        //calling webservice in loadSegmentWebService
        self.loadSegmentList()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButton()
        self.title = "Orders".localized
        self.configureTableViewRefresh(status: "confirmed")
        self.mySegmentView.selectedSegmentioIndex = 0
    }
 
}
//MARK:- base configuration ( on load View)
extension StoreOrderListVC {
    
    fileprivate func configureTableViewRefresh(status: String) {
      
        self.tableView.configRefreshHeader(with: headerPull,container:self) { [weak self] in
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
                sellerOrderSelectedStatus = .confirmed
            case 1:
               
                 self.configureTableViewRefresh(status: "shipped")
                 sellerOrderSelectedStatus = .shipped
            case 2:
                 self.configureTableViewRefresh(status: "completed")
                 sellerOrderSelectedStatus = .completed
            default:
                 print("Selected item: ", segmentIndex)
            }
           
        }
    }
    
}
//MARK:- actions





//MARK:- ws: Web Services Requests
extension StoreOrderListVC {
    
    func requestToFethcMyOrderListBy(status: String )  {
        
        //desable user interacation
        self.mySegmentView.isUserInteractionEnabled = false
        
        OrderManager.shared.fetchSellerOrderListBy(status: status , completion: { (error, rootModel) in
           
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
extension StoreOrderListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myRootModel.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreOrderTableViewCell") as! StoreOrderTableViewCell
        
        cell.myVC = self
        
        let model = self.myRootModel.data![indexPath.row]
        cell.setData(model: model)
       
        cell.myBtnView.on(.touchUpInside) { control, event in
            
            let storyboard = UIStoryboard(name: "Order", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "StoreOrderDetailVC") as! StoreOrderDetailVC
            vc.myDataModel = model
            self.navigationController!.pushViewController(vc, animated: true)
        }
        
        
        return cell
    }
    
    
    
}

