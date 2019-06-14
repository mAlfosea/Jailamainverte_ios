//
//  Plant.swift
//  Jailamainverte
//
//  Created by Admin on 24/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class Plant: Object {
    override static func primaryKey() -> String? {
        return "_plantId"
    }
    
    @objc dynamic var _plantId: Int = 0
    @objc dynamic var _plantName: String = ""
    @objc dynamic var _plantFamily: String = ""
    @objc dynamic var _plantImgPath: String = ""
    @objc dynamic var _lastArrosage: Date = Date()
    @objc dynamic var _cycleHour: Date = Date()
    @objc dynamic var _arrosageCycle: Int = 0
    
    
    
    func createPlant (newId: Int, newName: String, newFamily: String, newPlantImgPath: String, newLastArrosage: Date, newArrosageCycle: Int, newArrosageHour: Date) {
        _plantId = newId
        _plantName = newName
        _plantFamily = newFamily
        _plantImgPath = newPlantImgPath
        _lastArrosage = newLastArrosage
        _arrosageCycle = newArrosageCycle
        _cycleHour = newArrosageHour
    }
    
    func getNextArrosageDate () -> String {
        var dateComponent = DateComponents()
        dateComponent.day = _arrosageCycle
        
        var nextArrosageString: String = "NONE"
        
        if let nextArrosage = Calendar.current.date(byAdding: dateComponent, to: _lastArrosage) {
            
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .short
            formatter.doesRelativeDateFormatting = true
            formatter.locale = Locale.current
            
            //formatter.dateFormat = "EEEE"
            nextArrosageString = formatter.string(from: nextArrosage)
            
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            
            nextArrosageString += ": \(formatter.string(from: _cycleHour))"
        }
        
        return nextArrosageString
    }
}
