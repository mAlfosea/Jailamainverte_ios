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
    
    private var _user: User?
    private var _plantsArray: Results<Plant>
    private var _wateringsArray: [Watering] = []
   
    private init() {
        //_plantsArray = (count > 5) ? ok : null  >> exemple de ternaire
        UserDefaults.standard.register(defaults: [Values().isLoggedUserDefaultName : false])
        
        var realmConfig = Realm.Configuration.defaultConfiguration
        realmConfig.deleteRealmIfMigrationNeeded = true
        print(realmConfig.fileURL as Any)
        Realm.Configuration.defaultConfiguration = realmConfig
        
        if let user = RealmManager().getUser() {
            _user = user
        }
        _plantsArray = RealmManager().getPlants()
        
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
    
    
    func addWatering (watering: Watering) {
        _wateringsArray.insert(watering, at: 0)
    }
    func getWaterings () -> [Watering] {
        return _wateringsArray
    }
    func getSpecificWatering (index : Int) -> Watering {
        return _wateringsArray[index]
    }
    func getWateringsCount () -> Int {
        return _wateringsArray.count
    }
    
    
    func updateUser (user: User) {
        _user = user
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
}
