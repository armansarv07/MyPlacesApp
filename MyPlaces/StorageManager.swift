//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Arman on 08.10.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import RealmSwift

let realm = try! Realm()


class StorageManager{
    static func saveObject(_ place: Place){
        print("Realm is located at:", realm.configuration.fileURL!)
        try! realm.write{
            realm.add(place)
        }
    }
    
    static func deleteObject(_ place: Place){
        try! realm.write{
            realm.delete(place)
        }
    }
}
