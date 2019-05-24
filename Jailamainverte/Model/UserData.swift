//
//  UserData.swift
//  Jailamainverte
//
//  Created by Admin on 24/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

class UserData {
    
    private static var instance: UserData? = nil
    var _plantsArray = [Plant(newName: "Geronimo", newFamily: "Geranium", newLastArrosage: "Mardi", newArrosageCycle: 3),
                        Plant(newName: "Bobby", newFamily: "Lila", newLastArrosage: "Mardi", newArrosageCycle: 3),
                        Plant(newName: "Billy", newFamily: "Rose", newLastArrosage: "Mardi", newArrosageCycle: 3),
                        Plant(newName: "Steven", newFamily: "Jacynthe", newLastArrosage: "Mardi", newArrosageCycle: 3),
                        Plant(newName: "Jack", newFamily: "Mauvaise Herbe", newLastArrosage: "Mardi", newArrosageCycle: 3)]
    
    private init() {
        //_plantsArray = (count > 5) ? ok : null 
    }
    
    static func getInstance() -> UserData {
        if instance == nil {
            instance = UserData()
        }
        return instance!
    }
    
    
}
