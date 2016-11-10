//
//  MenuController.swift
//  SnapKitDrawer
//
//  Created by 聂鑫鑫 on 16/11/10.
//  Copyright © 2016年 ifels. All rights reserved.
//

import Foundation

import UIKit

class MenuController: DPLeftMenuViewController{
    
    let letters = [
        "AAAAAA",
        "BBBBBB",
        "CCCCCC",
        "DDDDDD",
        "EEEEEE",
        "FFFFFF",
        "GGGGGG" ,
        "HHHHHH"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "adfdfdfds"
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCellReuseIdentifier")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letters.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellReuseIdentifier", for: indexPath) as! TableViewCell
        cell.customTextLabel.text = letters[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
