//
//  CheckedTextField.swift
//  Jailamainverte
//
//  Created by Admin on 20/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class CheckedTextField : UITextField {
    private var checkList: [(String) -> Bool] = []
    
    func addEmptyCheck () {
        checkList.append { (text) -> Bool in
            return !text.isEmpty
        }
    }
    
    func resolveCheckList () -> Bool {
        guard let value = self.text else {
            return false
        }
        
        var isValid = true
        var checkIndex: Int = 0
        
        while checkIndex < checkList.count && isValid {
            let check = checkList[checkIndex]
            if check(value) == false {
                isValid = false
            }
            checkIndex += 1
        }
        return isValid
    }
}
