//
//  MyOrderListVC.swift
//  Baqala
//
//  Created by apple on 12/5/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import Segmentio
class MyOrderListVC: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var mySegmentView: Segmentio!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- properties and Structures
    
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar()
        self.tableView.registerCustomCell(withCellId: "MyOrderTableViewCell")
        self.loadSegmentList()
   
    }
    override func viewWillAppear(_ animated: Bool) {
        self.addBackButton()
        self.title = "My Orders"
    }
    
    
    
}

//MARK:- actions
//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
extension MyOrderListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTableViewCell") as! MyOrderTableViewCell
        
        cell.indexpath = indexPath
        cell.myVC = self
        
        return cell
    }
    
    
}
//MARK:- collectionView Extension
//MARK:- base configuration ( on load View)
extension MyOrderListVC{
    fileprivate func loadSegmentList() {
        var content = [SegmentioItem]()
        for index in 1...5 {
            let tornadoItem = SegmentioItem(title: "MySection \(index)", image: nil)
            content.append(tornadoItem)
        }
        self.configSemention(content)
        
        self.mySegmentView.selectedSegmentioIndex = 0
        self.mySegmentView.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
        }
    }
}

//MARK:- helpers ( include form Validation and other Methods )
extension MyOrderListVC {
  
    fileprivate func configSemention(_ content: [SegmentioItem]) {
        
        let bottomIndicator = SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 3,
            color: #colorLiteral(red: 0.3019607843, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
        )
        let vLine = SegmentioVerticalSeparatorOptions(ratio: 1, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        let hLine = SegmentioHorizontalSeparatorOptions(type: SegmentioHorizontalSeparatorType.bottom, height: 1, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        
        let myFont = UIFont(name: "Roboto-Medium_1", size: 18)
        
        let segmentStates = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9882352941, alpha: 1),
                titleFont: myFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize),
                titleTextColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            ),
            selectedState: SegmentioState(
                backgroundColor: #colorLiteral(red: 0.007843137255, green: 0.1450980392, blue: 0.168627451, alpha: 1),
                titleFont: myFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize),
                titleTextColor: .white
            ),
            highlightedState: SegmentioState( //Hold tapped
                backgroundColor: #colorLiteral(red: 0.007843137255, green: 0.1450980392, blue: 0.168627451, alpha: 1),
                titleFont: myFont ?? UIFont.systemFont(ofSize: UIFont.systemFontSize),
                titleTextColor:  #colorLiteral(red: 0.3019607843, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
            )
        )
        
        
        let options = SegmentioOptions(
            backgroundColor:  #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9882352941, alpha: 1),
            segmentPosition: .dynamic,
            scrollEnabled: true,
            indicatorOptions: bottomIndicator,
            horizontalSeparatorOptions: hLine,
            verticalSeparatorOptions: vLine,
            imageContentMode: .center,
            labelTextAlignment: .center,
            segmentStates: segmentStates
        )
        
        self.mySegmentView.setup(
            content: content,
            style: SegmentioStyle.onlyLabel,
            options: options
        )
    }
}
