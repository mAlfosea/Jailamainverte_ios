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
    func updateUser(user: User) {
        let realm = try! Realm()
        try! realm.write {
            if let userTemp = UserData.getInstance().getUser() {
                userTemp.createUser(userId: user._userId, userName: user._userName, userMail: user._userMail, userPassword: user._userPassword, userImagePath: user._userImage, notificationSetting: user._notificationSetting)
                UserData.getInstance().updateUser(user: userTemp)
                realm.add(userTemp)
            } else {
                UserData.getInstance().updateUser(user: user)
                realm.add(user)
            }
        }
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
        let plant = UserData.getInstance().getPlants().first(where: { (oldplant) -> Bool in
            return true
        })
        print("je dois avoir: \(oldPlant) et j'ai \(newPlant)")
        
        let realm = try! Realm()
        try! realm.write {
            plant?._plantId = newPlant._plantId
            plant?._plantName = newPlant._plantName
            plant?._plantFamily = newPlant._plantFamily
            plant?._plantImgPath = newPlant._plantImgPath
            plant?._lastArrosage = newPlant._lastArrosage
            plant?._cycleHour = newPlant._cycleHour
            plant?._arrosageCycle = newPlant._arrosageCycle
        }
    }
    func removePlant (index: Int) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(UserData.getInstance().getSpecificPlant(index: index))
        }
    }
}
