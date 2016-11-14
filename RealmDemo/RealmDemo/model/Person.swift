//
//  Person.swift
//  LearningSnapKit
//
//  Created by 聂鑫鑫 on 16/11/14.
//  Copyright © 2016年 melorriaga. All rights reserved.
//

import Foundation
import RealmSwift


class Person: Object {
    dynamic var name = ""
    let dogs = List<Dog>()
    
    dynamic var id = UUID().uuidString
    
    override static func primaryKey() ->String?{
        return "id"
    }
    
    //    func IncrementaID() -> Int {
    //        let realm = try! Realm()
    //        let RetNext: NSArray = Array(realm.objects(Person).sorted("id"))
    //        let last = RetNext.lastObject
    //        if RetNext.count > 0 {
    //            let valor = last?.valueForKey("id") as? Int
    //            return valor! + 1
    //        } else {
    //            return 1
    //        }
    //    }
}
