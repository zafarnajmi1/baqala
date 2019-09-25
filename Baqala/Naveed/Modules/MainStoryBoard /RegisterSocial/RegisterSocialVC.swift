//
//  RegisterSocialVC.swift
//  Baqala
//
//  Created by apple on 2/25/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import UIKit

class RegisterSocialVC: UIViewController {
    
    
    //MARK:- OutLets
    @IBOutlet var mySegmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
     //MARK:-  shared properties
    var myProfile: SocialProfileModel?
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCustomSegmentControll()
        self.setCustomNavigationBar()
        self.setBackButton()
        
        self.title = myProfile?.myTitle ?? "Register".localized
        
    }
    
    
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    
    
    
}


extension RegisterSocialVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.mySegmentControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterSocialBuyerTableViewCell" ) as! RegisterSocialBuyerTableViewCell
            
            cell.controller = self
            cell.setData(model: myProfile!)
            
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterSocialSellerTableViewCell" ) as! RegisterSocialSellerTableViewCell
            
            cell.controller = self
            cell.setData(model: myProfile!)
            return cell
        }
    }
    
    
}



//MARK:- Helpers
extension RegisterSocialVC {
    
    fileprivate func setCustomSegmentControll() {
        
        self.mySegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        let font = UIFont(name: "Roboto-Medium", size: 17)
        mySegmentControl.setTitleTextAttributes([NSAttributedString.Key.font: font!],for: .normal)
        
        self.mySegmentControl.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        self.mySegmentControl.layer.borderWidth = 1.5
        self.mySegmentControl.layer.cornerRadius = 0.0
        self.mySegmentControl.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        mySegmentControl.setTitle("Buyer".localized, forSegmentAt: 0)
        mySegmentControl.setTitle("Seller".localized, forSegmentAt: 1)
    }
}



class SocialProfileModel {
    var firstName: String?
    var lastName: String?
    var email: String?
    var soicalId: String?
    var socialToken: String?
    var gender: String?
    var myTitle: String?
    var authMethod: String?
    
    init(firstName: String, lastName: String , email: String, socialId: String, socialToken: String, myTitle: String, authMethod: String , gender: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.soicalId = socialId
        self.socialToken = socialToken
        self.myTitle = myTitle
        self.gender = gender
        self.authMethod = authMethod
    }
}
