//
//  ItemCtrlView.swift
//  mdx-audio
//
//  Created by ifels on 2016/11/22.
//  Copyright © 2016年 ifels. All rights reserved.
//

import Foundation

import UIKit
class CustomView:UIView {
    
    var centerPoint: CGPoint!
    var strokeColor: UIColor!
    var raidus: CGFloat!
    var extraLineWidth: CGFloat!
    var smallRadius: CGFloat!
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        centerPoint = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        strokeColor = UIColor(hexString: "#fc9b28")!
        raidus = 40
        extraLineWidth = 50
        smallRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        print("draw.rect = \(rect)")
        drawCircles(rect)
        drawLines(rect)
    }
    
    func setCenterPoint(_ center: CGPoint) -> () {
        self.centerPoint = center
        setNeedsDisplay()
    }
    
    internal func drawCircles(_ rect: CGRect) {
        print("centerPoint = \(centerPoint)")
        var arcCenter = CGPoint(x: centerPoint.x, y: centerPoint.y)
        let smallCircle = UIBezierPath(arcCenter: arcCenter, radius: smallRadius, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let smallLayer = CAShapeLayer()
        smallLayer.path = smallCircle.cgPath
        smallLayer.fillColor = strokeColor.cgColor
        smallLayer.strokeColor = strokeColor.cgColor
        smallLayer.lineWidth = 1.5
        layer.addSublayer(smallLayer)
        
        let bigCircle = UIBezierPath(arcCenter: arcCenter, radius: self.raidus, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let bigLayer = CAShapeLayer()
        bigLayer.path = bigCircle.cgPath
        bigLayer.fillColor = UIColor.clear.cgColor
        bigLayer.strokeColor = UIColor.white.cgColor
        bigLayer.lineWidth = 1.5
        layer.addSublayer(bigLayer)
        
        arcCenter = CGPoint(x: centerPoint.x - raidus, y: centerPoint.y)
        let leftSideCircle = UIBezierPath(arcCenter: arcCenter, radius: CGFloat(2), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let leftSlideLayer = CAShapeLayer()
        leftSlideLayer.path = leftSideCircle.cgPath
        leftSlideLayer.fillColor = UIColor.white.cgColor
        leftSlideLayer.strokeColor = UIColor.white.cgColor
        leftSlideLayer.lineWidth = 1.5
        layer.addSublayer(leftSlideLayer)
        
        arcCenter = CGPoint(x: centerPoint.x + raidus, y: centerPoint.y)
        let rightSideCircle = UIBezierPath(arcCenter: arcCenter, radius: CGFloat(2), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let rightSideLayer = CAShapeLayer()
        rightSideLayer.path = rightSideCircle.cgPath
        rightSideLayer.fillColor = UIColor.white.cgColor
        rightSideLayer.strokeColor = UIColor.white.cgColor
        rightSideLayer.lineWidth = 1.5
        layer.addSublayer(rightSideLayer)
        
        arcCenter = CGPoint(x: centerPoint.x - raidus - extraLineWidth, y: centerPoint.y)
        let leftCircle = UIBezierPath(arcCenter: arcCenter, radius: smallRadius, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let leftLayer = CAShapeLayer()
        leftLayer.path = leftCircle.cgPath
        leftLayer.fillColor = strokeColor.cgColor
        leftLayer.strokeColor = strokeColor.cgColor
        leftLayer.lineWidth = 1.5
        layer.addSublayer(leftLayer)
        
        arcCenter = CGPoint(x: centerPoint.x + raidus + extraLineWidth, y: centerPoint.y)
        let rightCircle = UIBezierPath(arcCenter: arcCenter, radius: smallRadius, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        let rightLayer = CAShapeLayer()
        rightLayer.path = rightCircle.cgPath
        rightLayer.fillColor = strokeColor.cgColor
        rightLayer.strokeColor = strokeColor.cgColor
        rightLayer.lineWidth = 1.5
        layer.addSublayer(rightLayer)
    }
    
    internal func drawLines(_ rect: CGRect) {
        let lineWidth = raidus + extraLineWidth - smallRadius
        let path = UIBezierPath()
        var entPoint = CGPoint(x:centerPoint.x + lineWidth, y: centerPoint.y)
        path.lineWidth = 1
        path.move(to: self.centerPoint)
        path.addLine(to: entPoint)
        
        entPoint = CGPoint(x:centerPoint.x - lineWidth, y: centerPoint.y)
        path.move(to: self.centerPoint)
        path.addLine(to: entPoint)
        strokeColor.set()
        
        path.close()
        path.stroke()
        path.fill()
        
        entPoint = CGPoint(x:centerPoint.x, y: centerPoint.y + rect.height)
        path.move(to: self.centerPoint)
        path.lineWidth = 0.6
        path.addLine(to: entPoint)
        
        path.close()
        path.stroke()
        path.fill()
    }
}
