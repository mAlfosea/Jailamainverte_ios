//
//  Watering.swift
//  Jailamainverte
//
//  Created by Admin on 04/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

class Watering {
    
    let user: String
    let plant: Plant
    let wateringDate: Date
    
    init(user: String, plant: Plant, wateringDate: Date) {
        self.user = user
        self.plant = plant
        self.wateringDate = wateringDate
    }
}
