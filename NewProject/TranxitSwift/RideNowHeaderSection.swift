//
//  RideNowHeaderSection.swift
//  User
//
//  Created by CSS on 08/05/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class RideNowHeaderSection: UIView {

    @IBOutlet weak var buttonApply: UIButton!
    
    var onClickCouponApply : (()->())?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
 
    @IBAction func ButtonApplyAction(_ sender: Any) {
        self.onClickCouponApply?()
    }
    
}
