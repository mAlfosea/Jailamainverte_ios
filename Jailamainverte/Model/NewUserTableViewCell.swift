//
//  NewUserTableViewCell.swift
//  Jailamainverte
//
//  Created by Admin on 06/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class NewUserTableViewCell: UITableViewCell {

    @IBOutlet weak var ui_addPlantButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ui_addPlantButton.layer.cornerRadius = 5
        ui_addPlantButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
