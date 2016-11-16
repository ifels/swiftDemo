//
//  UIViewExtension.swift
//  mdx-audio
//
//  Created by ifels on 2016/11/14.
//  Copyright © 2016年 ifels. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    // MARK: Frame Extensions
    var x: CGFloat {
        return self.frame.origin.x
    }
    
    var y: CGFloat {
        return self.frame.origin.y
    }
    
    var w: CGFloat {
        return self.frame.size.width
    }
    
    var h: CGFloat {
        return self.frame.size.height
    }
    
    
    var left: CGFloat {
        return self.x
    }
    
    var right: CGFloat {
        return self.x + self.w
    }
    
    var top: CGFloat {
        return self.y
    }
    
    var bottom: CGFloat {
        return self.y + self.h
    }
    
    
    func setX (_ x: CGFloat) {
        self.frame = CGRect (x: x, y: self.y, width: self.w, height: self.h)
    }
    
    func setY (_ y: CGFloat) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.frame = CGRect (x: self.x, y: y, width: self.w, height: self.h)
        })
    }
    
    func setX (_ x: CGFloat, y: CGFloat) {
        self.frame = CGRect (x: x, y: y, width: self.w, height: self.h)
    }
    
    
    func setW (_ w: CGFloat) {
        self.frame = CGRect (x: self.x, y: self.y, width: w, height: self.h)
    }
    
    func setH (_ h: CGFloat) {
        self.frame = CGRect (x: self.x, y: self.y, width: self.w, height: h)
    }
    
    func setW (_ w: CGFloat, h: CGFloat) {
        self.frame = CGRect (x: self.x, y: self.y, width: w, height: h)
    }
    
    func setSize (_ size: CGSize) {
        self.frame = CGRect (x: self.x, y: self.y, width: size.width, height: size.height)
    }
    
    func setPosition (_ position: CGPoint) {
        if (frame.origin == position) {
            return
        }
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.frame = CGRect (x: position.x, y: position.y, width: self.w, height: self.h)
        })
    }
    
    
    func leftWithOffset (_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    func rightWithOffset (_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    func topWithOffset (_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    func botttomWithOffset (_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    
    func setScale (_ x: CGFloat, y: CGFloat, z: CGFloat) {
        self.transform = CGAffineTransform(scaleX: x, y: y)
    }
    
    convenience init (x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init (frame: CGRect (x: x, y: y, width: w, height: h))
    }
}
