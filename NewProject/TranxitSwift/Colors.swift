//
//  Colors.swift
//  User
//
//  Created by imac on 12/22/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import UIKit

enum Color : Int {
    
    case primary = 1
    case secondary = 2
    
    case buttonBg = 3
    
    case textColor = 4
    case labeltextColor = 5
    case buttonTextColor = 6
    
    case imageColor = 7
    
    static func valueFor(id : Int)->UIColor?{
        
        switch id {
        case self.primary.rawValue:
            return .primary
            
        case self.secondary.rawValue:
            return .secondary
            
        case self.buttonBg.rawValue:
            return .buttonBg
            
        case self.textColor.rawValue:
            return .textColor
        
        case self.labeltextColor.rawValue:
            return .labelTextColor
            
        case self.buttonTextColor.rawValue:
            return .buttonTextColor
        case self.imageColor.rawValue:
            return .imageTintColor
            
        default:
            return nil
        }
        
        
    }
    
    
}
func systemBlackColor()->UIColor{
    if #available(iOS 13.0, *) {
               return UIColor.systemBackground
           } else {
               return UIColor.black// Fallback on earlier versions
           }
}

extension UIColor {
    
    // Primary Color
    static var primary : UIColor {
        return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1) //UIColor(red: 149/255, green: 117/255, blue: 205/255, alpha: 1)
    }
    
    // Secondary Color
    static var secondary : UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //UIColor(red: 238/255, green: 98/255, blue: 145/255, alpha: 1)
    }
    
    // Secondary Color
    static var textColor : UIColor {
        if #available(iOS 13.0, *) {
                   return UIColor.systemBackground
               } else {
                   return UIColor.black// Fallback on earlier versions
               }
        //return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //UIColor(red: 238/255, green: 98/255, blue: 145/255, alpha: 1)
    }
    
    // Secondary Color
    static var buttonBg : UIColor {
        systemBlackColor()//UIColor(red: 38/255, green: 118/255, blue: 188/255, alpha: 1)
    }
    
    static var labelTextColor : UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) //UIColor(red: 38/255, green: 118/255, blue: 188/255, alpha: 1)
    }
    
    static var buttonTextColor : UIColor {
        return UIColor.systemBlue //UIColor(red: 38/255, green: 118/255, blue: 188/255, alpha: 1)
    }
    
    static var imageTintColor : UIColor {
        return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) //UIColor(red: 38/255, green: 118/255, blue: 188/255, alpha: 1)
    }
    
    func UInt()->UInt32{
        
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            
            var colorAsUInt : UInt32 = 0
            
            colorAsUInt += UInt32(red * 255.0) << 16 +
                UInt32(green * 255.0) << 8 +
                UInt32(blue * 255.0)
            return colorAsUInt
            
            // colorAsUInt == 0xCC6699 // true
            
        }
        
        return 0xCC6699
    }
}
