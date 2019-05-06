//
//  NavigationItem+Exxtension.swift
//  User
//
//  Created by CSS on 27/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    
    func leftBarButton(completion : (()->())?){
        self.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .done, target: self, action: #selector(backButton))
        backCompletion = completion
    }
    
    @IBAction func backButton(){
         //UIViewController().popOrDismiss(animation: true)
        print("Called")
        backCompletion?()
    }
}
