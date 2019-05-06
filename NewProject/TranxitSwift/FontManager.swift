//
//  FontManager.swift
//  Swift_Base
//
//  Created by Ranjith on 10/02/19.
//  Copyright © 2019 Ranjith. All rights reserved.
//

import Foundation
import UIKit

class Fontmanager: UIFont {
    
    class func setFont( _ iPhone7PlusFontSize: CGFloat? = nil,andFontName fontN : String) -> UIFont{
        
        let defaultFontSize : CGFloat = 16
        
        switch Devicedetector().screenType {
            
        case .iPhone4:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize - 3)!
            }
            return UIFont(name: fontN, size: defaultFontSize - 6)!
            
        case .iPhone5:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize - 2)!
            }
            return UIFont(name: fontN, size: defaultFontSize - 3)!
            
        case .iPhone6AndIphone7:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize - 1)!
            }
            return UIFont(name: fontN, size: defaultFontSize - 1)!
            
        case .iPhone6PAndIPhone7P:
            
            return UIFont(name: fontN, size: iPhone7PlusFontSize ?? defaultFontSize)!
        case .iPhoneX:
            
            return UIFont(name: fontN, size: iPhone7PlusFontSize ?? defaultFontSize)!
        
      /*  case .iPhoneXSXR:
            
            return UIFont(name: fontN, size: iPhone7PlusFontSize ?? defaultFontSize)!*/
            
        case .iPhoneOrIPadSmallSizeUnknown:
            
            return UIFont(name: fontN, size: iPhone7PlusFontSize ?? defaultFontSize)!
            
        case .iPadMini:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize + 4)!
            }
            return UIFont(name: fontN, size: defaultFontSize + 4)!
            
        case .iPadPro10Inch:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize + 5)!
            }
            return UIFont(name: fontN, size: defaultFontSize + 5)!
            
        case .iPadPro:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize + 6)!
            }
            return UIFont(name: fontN, size: defaultFontSize + 6)!
            
        case .iPadUnknown:
            
            return UIFont(name: fontN, size: defaultFontSize + 3)!
            
        default:
            
            return UIFont(name: fontN, size: iPhone7PlusFontSize ?? 15)!
        }
    }
}
