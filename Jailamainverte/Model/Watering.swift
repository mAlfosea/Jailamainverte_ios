//
//  Watering.swift
//  Jailamainverte
//
//  Created by Admin on 04/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class Watering: Object {
    
    @objc dynamic var user: String = ""
    @objc dynamic var plant: Plant?
    @objc dynamic var wateringDate: Date?
    
    func createWatering (user: String, plant: Plant, wateringDate: Date) {
        self.user = user
        self.plant = plant
        self.wateringDate = wateringDate
    }
}
