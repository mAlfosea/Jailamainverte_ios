//
//  Plant.swift
//  Jailamainverte
//
//  Created by Admin on 24/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

class Plant {
    
    var _plantName: String
    var _plantFamily: String
    var _lastArrosage: String
    var _arrosageCycle: Int
    
    init (newName: String, newFamily: String, newLastArrosage: String, newArrosageCycle: Int) {
        _plantName = newName
        _plantFamily = newFamily
        _lastArrosage = newLastArrosage
        _arrosageCycle = newArrosageCycle
    }
}
