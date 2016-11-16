//
//  UIFontExtension.swift
//  mdx-audio
//
//  Created by ifels on 2016/11/13.
//  Copyright © 2016年 ifels. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum FontType: String {
        case Regular = "Regular"
        case Bold = "Bold"
        case Light = "Light"
        case UltraLight = "UltraLight"
        case Italic = "Italic"
        case Thin = "Thin"
    }
    
    enum FontName: String {
        case HelveticaNeue = "HelveticaNeue"
        case Helvetica = "Helvetica"
        case Futura = "Futura"
        case Menlo = "Menlo"
    }
    
    class func Font (_ name: FontName, type: FontType, size: CGFloat) -> UIFont {
        return UIFont (name: name.rawValue + "-" + type.rawValue, size: size)!
    }
    
    class func HelveticaNeue (_ type: FontType, size: CGFloat) -> UIFont {
        return Font(.HelveticaNeue, type: type, size: size)
    }
}
