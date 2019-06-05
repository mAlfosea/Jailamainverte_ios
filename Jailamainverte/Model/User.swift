//
//  User.swift
//  Jailamainverte
//
//  Created by Admin on 05/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

class User {
    
    let _userId: Int
    var _userName: String
    var _userMail: String
    var _userPassword: String
    var _userImage: String
    var _notificationSetting: Bool
    
    init(userId: Int, userName: String, userMail: String, userPassword: String, userImagePath: String, notificationSetting: Bool) {
        _userId = userId
        _userName = userName
        _userMail = userMail
        _userPassword = userPassword
        _userImage = userImagePath
        _notificationSetting = notificationSetting
    }
}
