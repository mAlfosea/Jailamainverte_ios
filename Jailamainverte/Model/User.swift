//
//  User.swift
//  Jailamainverte
//
//  Created by Admin on 05/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    @objc dynamic var _userId: Int = 0
    @objc dynamic var _userName: String = ""
    @objc dynamic var _userMail: String = ""
    @objc dynamic var _userPassword: String = ""
    @objc dynamic var _userImage: String = ""
    
    func createUser (userId: Int, userName: String, userMail: String, userPassword: String, userImagePath: String) {
        _userId = userId
        _userName = userName
        _userMail = userMail
        _userPassword = userPassword
        _userImage = userImagePath
    }
}
