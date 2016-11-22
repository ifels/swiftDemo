//
//  UICircle.swift
//  DrawDemo
//
//  Created by 聂鑫鑫 on 16/11/22.
//  Copyright © 2016年 ifels. All rights reserved.
//


import UIKit
class UICircle:UIView
{
    override func draw(_ rect: CGRect) {
        print("draw.rect = \(rect)")
        drawRingFittingInsideView()
    }
    
    internal func drawRingFittingInsideView()->() {
        print("drawRingFittingInsideView....")
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: 100), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
        
        layer.addSublayer(shapeLayer)
    }
}
