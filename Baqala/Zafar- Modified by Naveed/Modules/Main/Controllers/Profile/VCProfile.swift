//
//  VCProfile.swift
//  Baqala
//
//  Created by Macbook on 05/12/2018.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import AlamofireImage


protocol VCProfileDelegate: class {
    func refreshUserData(user: ProfileDataModel)
}


class VCProfile: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
   
   
    //MARK:- properties and Structures
    var delegate:VCProfileDelegate?
    var myRootProfile = RootProfileModel()
    
    //MARK:- lifeCycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWillAppear(true)
       
        self.requestToFetchUserProfile()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        self.setViewDirectionByLanguage()
        self.title = "Profile".localized
        self.setCustomNavigationBar()
        self.setEditBarButton()
        self.setBackButton()
      
      
       
    }
    

    
    func setEditBarButton(){
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "Edit"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(btnEditProfile(_:)), for: .touchUpInside)
        let barBtn = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([barBtn], animated: true)
        
    }
    
    
    //MARK:- actions
    
    @objc func btnEditProfile (_ sender: Any){
      
        if self.myRootProfile.data == nil {
            nvMessage.showError(body: appConstant.noMoreData)
            return
        }
    
        let  storydoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   storydoard.instantiateViewController(withIdentifier: "VCEditProfile") as! VCEditProfile
        vc.delegate = self
        vc.myProfileDataModel = self.myRootProfile.data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- ws: Web Services Requests
    
    func requestToFetchUserProfile() {
        
        self.showNvLoader()
        //service call
        ProfileManager.shared.getUserProfile { (error, rootModel) in
          
            self.hideNvloader()
            
            if error == nil {
                self.myRootProfile = rootModel!
                
                self.delegate?.refreshUserData(user: self.myRootProfile.data!)
                self.tableView.reloadData()
            }
            else {
                nvMessage.showError(body: error!)
            }
        }
    }
  
    
    

    
}



//MARK:- tableView Extension

extension VCProfile: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.myRootProfile.data == nil {
             return 0
        }
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VCProfileTableViewCell") as! VCProfileTableViewCell
        cell.setData(model: self.myRootProfile.data!)
        return cell
    }
    
    
}


//MARK:- helpers ( include form Validation and other Methods )

extension VCProfile: VCEditProfileDelegate {
    func refreshProfile() {
       self.requestToFetchUserProfile()
    }
    
    
}
