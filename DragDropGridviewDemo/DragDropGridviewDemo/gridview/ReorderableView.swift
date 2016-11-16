//
//  ReorderableView.swift
//  mdx-audio
//
//  Created by ifels on 2016/11/14.
//  Copyright © 2016年 ifels. All rights reserved.
//

import Foundation
import UIKit


class ReorderableView: UIView, UIGestureRecognizerDelegate {
    // MARK: Properties
    var delegate: Reorderable! = nil
    var pan: UIPanGestureRecognizer?
    var gridPosition: GridPosition?
    
    let animationDuration: TimeInterval = 0.2
    let reorderModeScale: CGFloat = 1.1
    let reorderModeAlpha: CGFloat = 0.6
    
    var isReordering : Bool = false {
        didSet {
            if isReordering {
                startReorderMode()
            } else {
                endReorderMode()
            }
        }
    }
    
    
    // MARK: Lifecycle
    convenience init (x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init (frame: CGRect (x: x, y: y, width: w, height: h))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let doubleTap = UITapGestureRecognizer (target: self, action: #selector(ReorderableView.doubleTapped(_:)))
        doubleTap.numberOfTapsRequired = 1
        doubleTap.numberOfTouchesRequired = 1
        doubleTap.delegate = self
        
        self.addGestureRecognizer(doubleTap)
        
        
        let longPress = UILongPressGestureRecognizer (target: self, action: #selector(ReorderableView.longPressed(_:)))
        longPress.numberOfTouchesRequired = 1
        longPress.delegate = self
        
        self.addGestureRecognizer(longPress)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Animations
    func startReorderMode () {
        addPan()
        superview?.bringSubview(toFront: self)
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.alpha = self.reorderModeAlpha
            self.setScale(self.reorderModeScale, y: self.reorderModeScale, z: self.reorderModeScale)
        })
    }
    
    func endReorderMode () {
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.alpha = 1
            self.setScale(1, y: 1, z: 1)
        }, completion: { finished -> Void in
            self.removePan()
        })
    }
    
    // MARK: Gestures
    func addPan () {
        pan = UIPanGestureRecognizer (target: self, action: #selector(ReorderableView.pan(_:)))
        self.addGestureRecognizer(pan!)
    }
    
    func removePan () {
        self.removeGestureRecognizer(pan!)
    }
    
    func longPressed (_ gesture: UITapGestureRecognizer) {
        if isReordering { return } else { isReordering = true }
        delegate?.didReorderStartedForView(self)
    }
    
    func doubleTapped (_ gesture: UITapGestureRecognizer) {
        isReordering = !isReordering
        
        if isReordering {
            delegate?.didReorderStartedForView(self)
        }
    }
    
    func pan (_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended:
            isReordering = false
            delegate.didReorderEndForView(self, pan: pan!)
            
        case .changed:
            delegate.didReorderedView(self, pan: pan!)
            
        default:
            return
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
