//
//  ViewController.swift
//  DrawDemo
//
//  Created by 聂鑫鑫 on 16/11/22.
//  Copyright © 2016年 ifels. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func setupViews(){
        self.view.backgroundColor = UIColor(hexString: "#000000")!
        let customView1 = CustomView(frame: view.frame)
        let customView2 = CustomView(frame: view.frame)
        self.view.addSubview(customView1)
        self.view.addSubview(customView2)
        
        customView1.snp.makeConstraints{make in
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        customView2.snp.makeConstraints{make in
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        print("view.center = \(view.center)")
        
        var center = CGPoint(x: view.center.x - CGFloat(50), y: view.center.y-CGFloat(100))
        customView1.setCenterPoint(center)
        
        center = CGPoint(x: view.center.x + CGFloat(50), y: view.center.y + CGFloat(80))
        customView2.setCenterPoint(center)
        
    }

}

