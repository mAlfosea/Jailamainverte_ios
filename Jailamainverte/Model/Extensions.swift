//
//  Extensions.swift
//  Jailamainverte
//
//  Created by Admin on 06/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

extension UIColor {
    struct ThemeColors {
        static var bordeaux: UIColor  { return UIColor(red: 144/255, green: 38/255, blue: 86/255, alpha: 1) }
        static var green: UIColor  { return UIColor(red: 67/255, green: 160/255, blue: 71/255, alpha: 1) }
    }
}

extension UIImageView {
    func createBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    func setImageScaleToFill (image: UIImage) {
        self.image = image
        self.contentMode = UIView.ContentMode.scaleToFill
        self.clipsToBounds = true
    }
}

extension UIAlertAction {
    func createAlertActionImage (imageName: String) {
        let actionImage = UIImage(named: imageName)
        self.setValue(actionImage, forKey: "image")
        self.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
    }
}

extension UITextField {
    func setButtonEnableOn() {
        self.isEnabled = true
        self.becomeFirstResponder()
    }
    func setButtonEnableOff() {
        self.isEnabled = false
        self.resignFirstResponder()
    }
}

extension Date {
    func nearestThirtyMinutes() -> Date {
        let cal = Calendar.current
        let startOfHour = cal.dateInterval(of: .hour, for: self)!.start
        var minutes = self.timeIntervalSince(startOfHour)
        minutes = (minutes / 60).rounded()
        if minutes >= 30 {
            minutes = 30
        } else {
            minutes = 0
        }
        return startOfHour.addingTimeInterval(minutes * 60)
    }
}
