//
//  UIViewController+Extension.swift
//  User
//
//  Created by CSS on 31/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    @objc class var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    @objc class var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell{
    @objc class var identifier: String {
        return String(describing: self)
    }
    
    
}
