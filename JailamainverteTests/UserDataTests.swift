//
//  JailamainverteTests.swift
//  JailamainverteTests
//
//  Created by Admin on 29/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import XCTest
@testable import Jailamainverte

class UserDataTests: XCTestCase {
    
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserDataInit () {
        XCTAssertEqual(UserData.getInstance()._plantsArray.count, 0)
    }
    
    func testAddPlant () {
        var plant = Plant(newName: "", newFamily: "", newLastArrosage: Date(), newArrosageCycle: 1, newArrosageHour: Date())
        UserData.getInstance().addPlant(plant: plant)
        XCTAssertEqual(UserData.getInstance()._plantsArray.count, 1)
    }

}
