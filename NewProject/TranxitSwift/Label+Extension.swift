//
//  Label+Extension.swift
//  User
//
//  Created by CSS on 27/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    @IBInspectable var textColour :  Int {
        get {
            return Int()
        }
        set (newValue){
            self.textColor = {
                
                if let color = Color.valueFor(id: newValue){
                    return color
                } else {
                    return self.textColor
                }
                
            }()
        }
    }
    
}
