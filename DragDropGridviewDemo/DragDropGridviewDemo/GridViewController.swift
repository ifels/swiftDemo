//
//  ViewController.swift
//  DragDropGridviewDemo
//
//  Created by 聂鑫鑫 on 16/11/16.
//  Copyright © 2016年 ifels. All rights reserved.
//

import UIKit


import UIKit
import SnapKit

class GridViewController: UIViewController {
    
    let itemWidth:CGFloat = 150
    
    var gridView : ReorderableGridView?
    var itemCount: Int = 0
    
    var borderColor: UIColor?
    var bgColor: UIColor?
    var bottomColor: UIColor?
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.backgroundColor = UIColor(hexString: "#373a50")!
        
        initData()
        setupViews()
    }
    
    func initData(){
        borderColor = RGBColor(233, g: 233, b: 233)
        bgColor = RGBColor(242, g: 242, b: 242)
        bottomColor = RGBColor(65, g: 65, b: 65)
    }
    
    // MARK: Grid View
    func setupViews () {
        print("PatternsController.setupViews...")
        
        var origin = view.frame.origin
        var size = view.frame.size
        origin.y = origin.y + 30
        size.height = size.height - 60
        
        let frame = CGRect(origin: origin, size: size)
        gridView = ReorderableGridView(frame: frame, itemWidth: itemWidth, verticalPadding: 20)
        view.addSubview(gridView!)
        
        for i in 0..<4 {
            gridView!.addReorderableView(itemView(i))
        }
    }
    
    func itemView (_ index: Int) -> ReorderableView {
        let w : CGFloat = itemWidth
        let h : CGFloat = 80
        
        let view = ReorderableView (x: 0, y: 0, w: w, h: h)
        view.layer.borderColor = borderColor?.cgColor
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        let topView = UIView(x: 0, y: 0, w: view.w, h: 50)
        view.addSubview(topView)
        
        let itemLabel = UILabel (frame: topView.frame)
        itemLabel.center = topView.center
        itemLabel.font = UIFont.HelveticaNeue(.Thin, size: 20)
        itemLabel.textAlignment = NSTextAlignment.center
        itemLabel.textColor = bottomColor
        itemLabel.text = "\(index)"
        itemLabel.layer.masksToBounds = true
        topView.addSubview(itemLabel)
        
        let sepLayer = CALayer ()
        sepLayer.frame = CGRect (x: 0, y: topView.bottom, width: topView.w, height: 1)
        sepLayer.backgroundColor = borderColor?.cgColor
        topView.layer.addSublayer(sepLayer)
        
        let bottomView = UIView(frame: CGRect(x: 0, y: topView.bottom, width: view.w, height: view.h-topView.h))
        let bottomLayer = CALayer ()
        bottomLayer.frame = CGRect (x: 0, y: bottomView.h-5, width: bottomView.w, height: 5)
        bottomLayer.backgroundColor = bottomColor?.cgColor
        bottomView.layer.addSublayer(bottomLayer)
        bottomView.layer.masksToBounds = true
        view.addSubview(bottomView)
        
        return view
    }
    
    
    // MARK: Interface Rotation
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        gridView?.setW(h, h: w)
        gridView?.invalidateLayout()
    }
    
    // MARK: Utils
    func randomColor () -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func RGBColor(_ r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor (red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    func RGBAColor (_ r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor (red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let grid = gridView {
            grid.invalidateLayout()
        }
    }
}

