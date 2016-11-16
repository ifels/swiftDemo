//
//  ViewController.swift
//  RealmDemo
//
//  Created by 聂鑫鑫 on 16/11/14.
//  Copyright © 2016年 ifels. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testRealm()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func testRealm(){
        print("testRealm...")
        do {
            try FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
        } catch {}
        
        // Realms are used to group data together
        let realm = try! Realm() // Create realm pointing to default file
        print("testRealm2...")
        
        // Set & read properties
        let dog1 = Dog()
        dog1.name = "dog1"
        dog1.age = 9
        
        let dog2 = Dog()
        dog2.name = "dog2"
        dog2.age = 10
        
        let dog3 = Dog()
        dog3.name = "dog3"
        dog3.age = 11
        
        let dog4 = Dog()
        dog4.name = "dog4"
        dog4.age = 5
        
        // Link objects
        let person = Person()
        person.name = "Tim"
        person.dogs.append(dog1)
        person.dogs.append(dog2)
        
        let person2 = Person()
        person2.name = "Tom"
        person2.dogs.append(dog3)
        person2.dogs.append(dog4)
        
        try! realm.write {
            realm.add(person)
            realm.add(person2)
        }
        
        let result = realm.objects(Person.self)
        let dogs = result.first?.dogs
        if dogs != nil {
            print("dogs.size = \(dogs!.count)")
            for d in dogs!{
                print("d.name = \(d.name)")
            }
        }
        
        // Multi-threading
        //DispatchQueue.global().async {
        var personalResults = realm.objects(Person.self).sorted(byProperty: "name", ascending: true)
        print("Number of personals \(personalResults.count)")
        
        var dp : Person?
        for p in personalResults {
            print("p.id = \(p.id)")
            dp = p
        }
        
        var dogResults = realm.objects(Dog.self).filter(NSPredicate(format: "age >= 5"))
        print("Number of dogs \(dogResults.count)")
        
        //}
        
        try! realm.write {
            if dp != nil {
                realm.delete(dp!)
            }
        }
        
        personalResults = realm.objects(Person.self)
        print("2. Number of personals \(personalResults.count)")
        dogResults = realm.objects(Dog.self).filter(NSPredicate(format: "age >= 5"))
        print("2. Number of dogs \(dogResults.count)")
    }
    
}

