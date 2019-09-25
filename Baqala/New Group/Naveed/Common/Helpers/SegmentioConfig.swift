//
//  SegmentioConfig.swift
//  Baqala
//
//  Created by apple on 12/7/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import Segmentio


extension Segmentio {
    
     func configSementio(_ content: [SegmentioItem]) {
        
        let bottomIndicator = SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 3,
            color: #colorLiteral(red: 0.3019607843, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
        )
        let vLine = SegmentioVerticalSeparatorOptions(ratio: 1, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        let hLine = SegmentioHorizontalSeparatorOptions(type: SegmentioHorizontalSeparatorType.bottom, height: 1, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        
        let myFontRegular = UIFont(name: "Roboto-Regular", size: 16)
        let myFontMedium = UIFont(name: "Roboto-Medium", size: 16)
        
        let segmentStates = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9882352941, alpha: 1),
                titleFont: myFontRegular ?? UIFont.systemFont(ofSize: UIFont.systemFontSize),
                titleTextColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            ),
            selectedState: SegmentioState(
                backgroundColor: #colorLiteral(red: 0.007843137255, green: 0.1450980392, blue: 0.168627451, alpha: 1),
                titleFont: myFontMedium ?? UIFont.systemFont(ofSize: UIFont.systemFontSize),
                titleTextColor: .white
            ),
            highlightedState: SegmentioState( //Hold tapped
                backgroundColor: #colorLiteral(red: 0.007843137255, green: 0.1450980392, blue: 0.168627451, alpha: 1),
                titleFont: myFontMedium ?? UIFont.systemFont(ofSize: UIFont.systemFontSize),
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
        
        self.setup(
            content: content,
            style: SegmentioStyle.onlyLabel,
            options: options
        )
    }
}
