//
//  PlantTableViewCell.swift
//  Jailamainverte
//
//  Created by Admin on 27/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PlantTableViewCell: UITableViewCell {

    @IBOutlet weak var ui_plant_img: UIImageView!
    @IBOutlet weak var ui_plant_name: UILabel!
    @IBOutlet weak var ui_plant_family: UILabel!
    @IBOutlet weak var ui_plant_next_arrosage: UILabel!
    
    var _plant: Plant?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ui_plant_img.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(plant: Plant) {
        _plant = plant
        ui_plant_name.text = plant._plantName
        ui_plant_family.text = plant._plantFamily
        ui_plant_next_arrosage.text = plant.getNextArrosageDate()
        changePlantImg(plantName: plant._plantImgPath)
    }

    func changePlantImg(plantName: String) {
        if let plantImage = getImage(imageName: plantName) {
            ui_plant_img.image = plantImage
            ui_plant_img.contentMode = UIView.ContentMode.scaleToFill
            ui_plant_img.clipsToBounds = true
        }
    }
    
    @IBAction func waterButtonClicked(_ sender: Any) {
        guard let plant = _plant else {
            return
        }
        
        plant._lastArrosage = Date()
        ui_plant_next_arrosage.text = plant.getNextArrosageDate()
        
        for i in 0..<UserData.getInstance()._plantsArray.count {
            if plant._plantId == UserData.getInstance()._plantsArray[i]._plantId {
                UserData.getInstance()._plantsArray[i] = plant
                _plant = plant
            }
        }
    }
}
