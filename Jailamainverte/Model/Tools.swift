//
//  Tools.swift
//  Jailamainverte
//
//  Created by Admin on 03/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

func getImage (imageName: String) -> UIImage? {
    
    let fileManager = FileManager.default
    let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
    if fileManager.fileExists(atPath: imagePath){
        return UIImage(contentsOfFile: imagePath)
    } else {
        return UIImage(named: "plantCard_plant_img")
    }
}

func saveImage (imageName: String, sourceImg: UIImage) {
    
    let fileManager = FileManager.default
    let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
    let image = sourceImg
    let data = image.pngData()
    fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
}
