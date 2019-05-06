//
//  Button+Extension.swift
//  User
//
//  Created by CSS on 27/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable var textColour :  Int {
        get {
            return Int()
        }
        set (newValue){
            self.setTitleColor(Color.valueFor(id: newValue), for: .normal)
        }
    }
    
}
