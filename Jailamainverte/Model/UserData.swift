//
//  UserData.swift
//  Jailamainverte
//
//  Created by Admin on 24/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class UserData {
    
    private static var instance: UserData? = nil
    private var _realmManager: RealmManager
    
    private var _user: User?
    private var _plantsArray: Results<Plant>
    private var _wateringsArray: Results<Watering>
   
    private init() {
        //_plantsArray = (count > 5) ? ok : null  >> exemple de ternaire
        UserDefaults.standard.register(defaults: [Values().isLoggedUserDefaultName : false])
        UserDefaults.standard.register(defaults: [Values().wateringNotificationsUserDefaultName : true])
        
        var realmConfig = Realm.Configuration.defaultConfiguration
        realmConfig.deleteRealmIfMigrationNeeded = true
        //print(realmConfig.fileURL as Any)
        Realm.Configuration.defaultConfiguration = realmConfig
        
        _realmManager = RealmManager()
        
        if let user = _realmManager.getUser() {
            _user = user
        }
        _plantsArray = _realmManager.getPlants()
        _wateringsArray = _realmManager.getWaterings()
    }
    
    static func getInstance() -> UserData {
        if instance == nil {
            instance = UserData()
        }
        return instance!
    }
    
    func getPlants () -> Results<Plant> {
        return _plantsArray
    }
    func getSpecificPlant (index : Int) -> Plant {
        return _plantsArray[index]
    }
    func getPlantsCount () -> Int {
        return _plantsArray.count
    }
    func addPlant (plant: Plant) {
        _realmManager.addPlant(plant: plant)
    }
    func updatePlant (oldPlant: Plant, newPlant: Plant) {
        if let tempPlant = getPlants().first(where: { (plant) -> Bool in
            return plant._plantId == oldPlant._plantId
        }) {
            //print ("ancien: \(oldPlant._plantName) - la nouvelle \(newPlant._plantName) - celle que je trouve \(tempPlant._plantName)")
            _realmManager.updatePlant(oldPlant: tempPlant, newPlant: newPlant)
        }
    }
    func waterPlant (plant: Plant) {
        _realmManager.waterPlant (plant: plant)
    }
    func removePlant (index: Int) {
        _realmManager.removePlant(index: index)
    }
    
    
    func addWatering (watering: Watering) {
        _realmManager.addWatering(watering: watering)
    }
    func getWaterings () -> Results<Watering> {
        return _wateringsArray
    }
    func getSpecificWatering (index : Int) -> Watering {
        return _wateringsArray[index]
    }
    func getWateringsCount () -> Int {
        return _wateringsArray.count
    }
    
    
    func updateUser (user: User) {
        
       _user = _realmManager.updateUser(user: user)
       /* if let userTemp = _user {
            userTemp.createUser(userId: user._userId, userName: user._userName, userMail: user._userMail, userPassword: user._userPassword, userImagePath: user._userImage, notificationSetting: user._notificationSetting)
            _user = userTemp
            _realmManager.updateUser(user: userTemp)
        } else {
            _user = user
            _realmManager.updateUser(user: user)
        }*/
    }
    func getUser () -> User? {
        return _user
    }
    
    
    var isLogged: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Values().isLoggedUserDefaultName)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Values().isLoggedUserDefaultName)
        }
    }
    
    var wateringNotifications: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Values().wateringNotificationsUserDefaultName)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Values().wateringNotificationsUserDefaultName)
        }
    }
}
