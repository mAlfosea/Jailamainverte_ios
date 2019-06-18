//
//  PlantTableViewCell.swift
//  Jailamainverte
//
//  Created by Admin on 27/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

protocol PlantCellDelegate: class {
    func wateringWasDone(forPlant plant:Plant)
}

class PlantTableViewCell: UITableViewCell {

    @IBOutlet weak var ui_plant_img: UIImageView!
    @IBOutlet weak var ui_plant_name: UILabel!
    @IBOutlet weak var ui_plant_family: UILabel!
    @IBOutlet weak var ui_plant_next_arrosage_bbackground: UIView!
    @IBOutlet weak var ui_plant_next_arrosage: UILabel!
    
    weak var delegate:PlantCellDelegate?
    var _plant: Plant?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ui_plant_img.layer.cornerRadius = 10
        ui_plant_next_arrosage_bbackground.layer.cornerRadius = 5
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
            ui_plant_img.setImageScaleToFill(image: plantImage)
            ui_plant_img.createBorder(color: UIColor.ThemeColors.bordeaux, width: 3)
        }
    }
    
    @IBAction func waterButtonClicked(_ sender: Any) {
        guard let plant = _plant else {
            return
        }
        
        UserData.getInstance().waterPlant(plant: plant)
        
        ui_plant_next_arrosage.text = plant.getNextArrosageDate()
        
        /*_plant = UserData.getInstance().getPlants().first(where: { (plant) -> Bool in
            return true
        })*/
        
        /*for i in 0..<UserData.getInstance().getPlantsCount() {
            if plant._plantId == UserData.getInstance()._plantsArray[i]._plantId {
                UserData.getInstance()._plantsArray[i] = plant
                _plant = plant
            }
        }*/
        
        if let user = UserData.getInstance().getUser() {
            let watering : Watering = Watering()
            watering.createWatering(user: user._userName, plant: plant, wateringDate: plant._lastArrosage)
            UserData.getInstance().addWatering(watering: watering)
        }
        
        delegate?.wateringWasDone(forPlant: plant)
    }
}
