//
//  DPLeftMenuViewController.swift
//  DPSlideMenuKitDemo
//
//  Created by Hongli Yu on 8/17/16.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit
import Foundation

// MARK: Extension
extension String {
    var localized: String {
        return NSLocalizedString(self,
                                 tableName: nil,
                                 bundle: Bundle.main,
                                 value: "",
                                 comment: "")
    }
}


open class DPLeftMenuViewController: UITableViewController {
    
    var drawerControllerWillOpen:(()->Void)? {
        set(drawerControllerWillOpen) {
            if let aDrawerControllerWillOpen = drawerControllerWillOpen {
                self.drawerControllerWillOpenStored = aDrawerControllerWillOpen
            }
        }
        get {
            return self.drawerControllerWillOpenStored
        }
    }
    fileprivate var drawerControllerWillOpenStored:(()->Void)?
    
    var drawerControllerDidOpen:(()->Void)? {
        set(drawerControllerDidOpen) {
            if let aDrawerControllerDidOpen = drawerControllerDidOpen {
                self.drawerControllerDidOpenStored = aDrawerControllerDidOpen
            }
        }
        get {
            return self.drawerControllerDidOpenStored
        }
    }
    fileprivate var drawerControllerDidOpenStored:(()->Void)?
    
    var drawerControllerWillClose:(()->Void)? {
        set(drawerControllerWillClose) {
            if let aDrawerControllerWillClose = drawerControllerWillClose {
                self.drawerControllerWillCloseStored = aDrawerControllerWillClose
            }
        }
        get {
            return self.drawerControllerWillCloseStored
        }
    }
    fileprivate var drawerControllerWillCloseStored:(()->Void)?
    
    var drawerControllerDidClose:(()->Void)? {
        set(drawerControllerDidClose) {
            if let aDrawerControllerDidClose = drawerControllerDidClose {
                self.drawerControllerDidCloseStored = aDrawerControllerDidClose
            }
        }
        get {
            return self.drawerControllerDidCloseStored
        }
    }
    fileprivate var drawerControllerDidCloseStored:(()->Void)?
    
    weak var drawer: DPDrawerViewController?
    fileprivate(set) open var slideMenuModels: [DPSlideMenuModel]?
    fileprivate(set) open var lastRow: Int = 0
    fileprivate(set) open var configuredInStoryboard: Bool = false
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?,
                  bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawerControllerWillOpen = {
            [weak self] in
            if let this = self {
                this.view.isUserInteractionEnabled = false
            }
        }
        
        self.drawerControllerDidOpen = {
            [weak self] in
            if let this = self {
                this.view.isUserInteractionEnabled = true
            }
        }
        
        self.drawerControllerWillClose = {
            [weak self] in
            if let this = self {
                this.view.isUserInteractionEnabled = false
            }
        }
        
        self.drawerControllerDidClose = {
            [weak self] in
            if let this = self {
                this.view.isUserInteractionEnabled = true
            }
        }
        
    }
    
    override open var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
