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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ui_plant_img.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
