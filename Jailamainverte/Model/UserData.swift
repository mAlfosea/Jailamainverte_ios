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
    var _plantsArray: [Plant] = [Plant(newId: Int(Date().timeIntervalSince1970), newName: "Geronimo", newFamily: "Geranium", newPlantImgPath: "plant_0.png", newLastArrosage: Date(), newArrosageCycle: 3, newArrosageHour: Date())]
    let _plantsFamily: [String] = ["Aucune", "Rose", "Jacynthe", "Géranium", "Lila"]
    
    let dayMinString: String = NSLocalizedString("d", comment: "diminutif pour l'unite jour")
    let doneButtonString: String = NSLocalizedString("Done", comment: "boutton done pour les toolbars")
    let cancelButtonString: String = NSLocalizedString("Cancel", comment: "boutton cancel pour les toolbars")
    let selectPictureFromCameraString: String = NSLocalizedString("Camera", comment: "bouton pour prendre une photo avec l'apareil photo")
    let selectPictureFromLibraryString: String = NSLocalizedString("Photo Library", comment: "bouton pour prendre une photo depuis la librairie")
   
    private init() {
        //_plantsArray = (count > 5) ? ok : null  >> exemple de ternaire
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
