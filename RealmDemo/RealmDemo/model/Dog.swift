//
//  Dog.swift
//  LearningSnapKit
//
//  Created by 聂鑫鑫 on 16/11/14.
//  Copyright © 2016年 melorriaga. All rights reserved.
//

import Foundation
import RealmSwift

class Dog: Object {
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var age = 0
    
    override static func primaryKey() ->String?{
        return "id"
    }
}

