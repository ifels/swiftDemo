//
//  ViewController.swift
//  SnapKitDrawer
//
//  Created by 聂鑫鑫 on 16/11/10.
//  Copyright © 2016年 ifels. All rights reserved.
//

import UIKit

class HomeController: DPDrawerViewController {
    
    var drawerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        initDrawer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func initDrawer(){
    
        // 1. get the drawer
        // embed in storyboard
        let drawer: DPDrawerViewController = self
        
        // not embed in storyboard? add it manually
        // let drawer: DPDrawerViewController? = self.storyboard?.instantiateViewController(withIdentifier: "DPDrawerViewController") as? DPDrawerViewController
        //  self.addChildViewController(drawer!)
        //  self.view.addSubview(drawer!.view)
        
        // 2. create the first view controller
        let homeViewController: ContentController? = ContentController();
        
        // 4. create leftMenuViewController with DPSlideMenuModel array, then reset the drawer
       //let leftMenuViewController: DPLeftMenuViewController = DPLeftMenuViewController(slideMenuModels: slideMenuModels, storyboard: self.storyboard)
        let menuController: MenuController = MenuController()
        drawer.reset(leftViewController: menuController,
                      centerViewController: homeViewController)
    
    }

}

