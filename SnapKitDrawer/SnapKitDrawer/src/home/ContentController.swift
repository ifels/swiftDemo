//
//  SlideContentController.swift
//  SnapKitDrawer
//
//  Created by 聂鑫鑫 on 16/11/10.
//  Copyright © 2016年 ifels. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


class ContentController: DPContentViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    
    func setViews() {
        title = "Learning SnapKit"
        
        view.backgroundColor = .white
        
        let box = UIView()
        box.backgroundColor = .cyan
        
        let header = UIImageView()
        header.image = UIImage(named: "fractal")
        
        let logo = UIImageView()
        logo.image = UIImage(named: "CABJ")
        logo.contentMode = .scaleAspectFit
        
        let button = UIButton()
        button.setTitle("Go To TableView", for: .normal)
        button.backgroundColor = .red
        
        view.addSubview(box)
        view.addSubview(header)
        view.addSubview(logo)
        view.addSubview(button)
        
        box.snp.makeConstraints { make in
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(10)
            make.right.equalTo(view).offset(-10)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
        }
        
        header.snp.makeConstraints { make in
            make.height.equalTo(box.snp.height).dividedBy(4)
            make.top.equalTo(box.snp.top)
            make.right.equalTo(box.snp.right)
            make.left.equalTo(box.snp.left)
        }
        
        logo.snp.makeConstraints { make in
            make.height.equalTo(header.snp.height)
            make.center.equalTo(header.snp.center)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.right.equalTo(box.snp.right)
            make.bottom.equalTo(box.snp.bottom)
            make.left.equalTo(box.snp.left)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
