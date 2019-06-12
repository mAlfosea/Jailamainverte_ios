//
//  RealmManager.swift
//  Jailamainverte
//
//  Created by Admin on 11/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    func getUser() -> User? {
        let realm = try! Realm()
        let user = realm.objects(User.self)
        if user.count != 0 {
            return user[0]
        } else {
            return nil
        }
    }
    func updateUser(user: User) -> User {
        let realm = try! Realm()
        var resultUser: User = User()
        try! realm.write {
            if let userTemp = UserData.getInstance().getUser() {
                userTemp.createUser(userId: user._userId, userName: user._userName, userMail: user._userMail, userPassword: user._userPassword, userImagePath: user._userImage, notificationSetting: user._notificationSetting)
                //UserData.getInstance() = userTemp
                resultUser = userTemp
            } else {
                realm.add(user)
                resultUser = user
            }
        }
        return resultUser
    }
    
    func addPlant(plant: Plant) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(plant)
        }
    }
    func getPlants() -> Results<Plant> {
        let realm = try! Realm()
        return realm.objects(Plant.self)
    }
    func updatePlant(oldPlant: Plant, newPlant: Plant) {
        let realm = try! Realm()
        try! realm.write {
            oldPlant._plantId = newPlant._plantId
            oldPlant._plantName = newPlant._plantName
            oldPlant._plantFamily = newPlant._plantFamily
            oldPlant._plantImgPath = newPlant._plantImgPath
            oldPlant._lastArrosage = newPlant._lastArrosage
            oldPlant._cycleHour = newPlant._cycleHour
            oldPlant._arrosageCycle = newPlant._arrosageCycle
        }
    }
    func waterPlant (plant: Plant) {
        let realm = try! Realm()
        try! realm.write {
            plant._lastArrosage = Date()
        }
    }
    func removePlant (index: Int) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(UserData.getInstance().getSpecificPlant(index: index))
        }
    }
    
    
    func addWatering(watering: Watering) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(watering)
        }
    }
    func getWaterings() -> Results<Watering> {
        let realm = try! Realm()
        return realm.objects(Watering.self).sorted(byKeyPath: "wateringDate", ascending: false)
    }
}
