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
    var _plantsArray: [Plant] = [/*Plant(newName: "Geronimo", newFamily: "Geranium", newLastArrosage: Date.init(timeIntervalSinceReferenceDate: 86400.0), newArrosageCycle: 3, newArrosageHour: Date.init(timeIntervalSinceReferenceDate: 86400.0)),
                        Plant(newName: "Bobby", newFamily: "Lila", newLastArrosage: nil, newArrosageCycle: 3, newArrosageHour: nil),
                        Plant(newName: "Billy", newFamily: "Rose", newLastArrosage: nil, newArrosageCycle: 3, newArrosageHour: nil),
                        Plant(newName: "Steven", newFamily: "Jacynthe", newLastArrosage: nil, newArrosageCycle: 3, newArrosageHour: nil),
                        Plant(newName: "Jack", newFamily: "Mauvaise Herbe", newLastArrosage: nil, newArrosageCycle: 3, newArrosageHour: nil)*/]
    
    private init() {
        //_plantsArray = (count > 5) ? ok : null 
    }
    
    static func getInstance() -> UserData {
        if instance == nil {
            instance = UserData()
        }
        return instance!
    }
    
    func addPlant (plant: Plant) {
        _plantsArray.append(plant)
    }
}
