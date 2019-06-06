//
//  UserData.swift
//  Jailamainverte
//
//  Created by Admin on 24/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

class UserData {
    
    private static var instance: UserData? = nil
    
    var _user: User = User(userId: 1, userName: "Francis", userMail: "francis.bg@gmail.com", userPassword: "bgDu13", userImagePath: "test_1", notificationSetting: false)
    var _plantsArray: [Plant] = [/*Plant(newId: Int(Date().timeIntervalSince1970), newName: "Geronimo", newFamily: "Geranium", newPlantImgPath: "plant_0.png", newLastArrosage: Date(), newArrosageCycle: 3, newArrosageHour: Date())*/]
    let _plantsFamily: [String] = ["Aucune", "Rose", "Jacynthe", "Géranium", "Lila"]
    var _wateringsArray: [Watering] = []
    
    
    
    let dayMinString: String = NSLocalizedString("d", comment: "diminutif pour l'unite jour")
    let doneButtonString: String = NSLocalizedString("Done", comment: "boutton done pour les toolbars")
    let cancelButtonString: String = NSLocalizedString("Cancel", comment: "boutton cancel pour les toolbars")
    let selectPictureFromCameraString: String = NSLocalizedString("Camera", comment: "bouton pour prendre une photo avec l'apareil photo")
    let selectPictureFromLibraryString: String = NSLocalizedString("Photo Library", comment: "bouton pour prendre une photo depuis la librairie")
    let wateringSentenceString: String = NSLocalizedString("has watered", comment: "texte dans l'historique des arrosages")
    let wateringToastString: String = NSLocalizedString("thanks you :)", comment: "texte sur le toast d'arrosage")
    let saveUserToastString: String = NSLocalizedString("Profil updated", comment: "texte sur le toast de modif du profil")
   
    private init() {
        //_plantsArray = (count > 5) ? ok : null  >> exemple de ternaire
        UserDefaults.standard.register(defaults: ["ISLOGGED" : false])
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
    
    func addWatering (watering: Watering) {
        _wateringsArray.insert(watering, at: 0)
    }
    
    func updateuser (user: User) {
        _user = user
    }
    
    var isLogged: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "ISLOGGED")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ISLOGGED")
        }
    }
}
