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
    var _plantImgPath: String
    var _lastArrosage: Date
    var _cycleHour: Date
    var _arrosageCycle: Int
    
    init (newName: String, newFamily: String, newPlantImgPath: String, newLastArrosage: Date, newArrosageCycle: Int, newArrosageHour: Date) {
        _plantName = newName
        _plantFamily = newFamily
        _plantImgPath = newPlantImgPath
        _lastArrosage = newLastArrosage
        _arrosageCycle = newArrosageCycle
        _cycleHour = newArrosageHour
    }
}
