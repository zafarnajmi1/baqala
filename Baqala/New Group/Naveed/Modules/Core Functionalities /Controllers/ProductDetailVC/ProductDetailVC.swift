//
//  ProductDetailVC.swift
//  Baqala
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit

//ProductDetailTableViewCell
class ProductDetailVC: UIViewController {
    //MARK:- outlets
    @IBOutlet weak var tableView:UITableView!
    
    
    //MARK:- properties and Structures
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.registerCustomCell(withCellId: "ProductDetailTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.addBackButton()
        self.title = "Product detail"
    }
    


}
//MARK:- protocols


//MARK:- base configuration ( on load View)
//MARK:- actions
//MARK:- ws: Web Services Requests
//MARK:- tableView Extension
extension ProductDetailVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell") as! ProductDetailTableViewCell
        return cell
    }
    
    
}
//MARK:- collectionView Extension
//MARK:- helpers ( include form Validation and other Methods )
