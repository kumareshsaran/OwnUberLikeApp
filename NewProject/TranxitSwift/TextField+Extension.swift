//
//  TextField+Extension.swift
//  User
//
//  Created by CSS on 27/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

var border : CALayer?
extension UITextField {
    
    @IBInspectable var underLine : Bool {
        
        
        get {
            return Bool()
        }
        set(newValue) {
            
            //            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditings), name: NSNotification.Name.UITextFieldTextDidEndEditing, object: self)
            //
            //            NotificationCenter.default.addObserver(self, selector: #selector(textFieldBeginEditings), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: self)
            
            if newValue {
                return self.layer.addSublayer(underLineCALayer())
            }else{
                self.layer.addSublayer(border!)
            }
            
        }
    }
    
    func underLineCALayer()->CALayer{
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: 1.5)
        border.borderWidth = width
        //self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        return border
        
    }
    
    /*   @IBAction func textFieldDidEndEditings(){
     let layer = CALayer()
     border = layer
     let width = CGFloat(1.0)
     border?.borderColor = UIColor.darkGray.cgColor
     
     border?.borderWidth = width
     
     self.layer.masksToBounds = true
     border?.frame = CGRect(x: 0, y: self.frame.size.height , width:  self.frame.size.width, height: self.frame.size.height)
     underLine = true
     }
     @IBAction func textFieldBeginEditings(){
     let layer = CALayer()
     border = layer
     let width = CGFloat(1.0)
     border?.borderColor = UIColor.darkGray.cgColor
     
     border?.borderWidth = width
     
     self.layer.masksToBounds = true
     border?.frame = CGRect(x: 0, y: self.frame.size.height , width:  self.frame.size.width, height: self.frame.size.height)
     underLine = true
     }*/
    
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
