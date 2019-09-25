//
//  AdvanceSearcTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/11/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import RangeSeekSlider
import DLRadioButton

class AdvanceSearcTableViewCell: UITableViewCell {
    //MARK:- protocols
    //MARK:- outlets
    @IBOutlet weak var perKgBtn: DLRadioButton!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    @IBOutlet weak var maxValueRangeSlider: UILabel!
    @IBOutlet weak var addressView: UIView!
    //MARK:- properties and Structures
    //MARK:- lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.perKgBtn.isSelected = true
        self.addressView.setLightShadow()
    }
    
    
    //MARK:- base configuration ( on load View)
    //MARK:- actions
    @IBAction func subCategoryBtnTapped(_ sender: Any) {
           nvMessage.showSuccess(body: "subCategoryBtnTapped")
    }
    @IBAction func categoryBtnTapped(_ sender: Any) {
        nvMessage.showSuccess(body: "categoryBtnTapped")
    }
    
    @IBAction func neartoFarBtnTapped(_ sender: Any) {
        nvMessage.showSuccess(body: "neartoFarBtnTapped")
    }
    
    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
        radioButton.deselectOtherButtons()
        for(_, button)  in radioButton.selectedButtons().enumerated() {
            print(button.tag)
            nvMessage.showSuccess(body: "Button Index\(button.tag)")
            
        }
        
        
    }
    
    //MARK:- ws: Web Services Requests
    //MARK:- tableView Extension
    //MARK:- collectionView Extension
    //MARK:- helpers ( include form Validation and other Methods )

   
    
}
