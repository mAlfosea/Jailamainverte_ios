//
//  WateringHistoryTableViewCell.swift
//  Jailamainverte
//
//  Created by Admin on 04/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class WateringHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var ui_plantImage: UIImageView!
    @IBOutlet weak var ui_historyLabel: UILabel!
    @IBOutlet weak var ui_dateLabel: UILabel!
    
    var _watering: Watering?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        ui_plantImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(watering: Watering) {
        _watering = watering
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let date:String = formatter.string(from: watering.wateringDate!)
        
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        let hour:String = formatter.string(from: watering.wateringDate!)
        
        if  let user = UserData.getInstance().getUser(),
            let image = getImage(imageName: user._userImage) {
            ui_plantImage.setImageScaleToFill(image: image)
            ui_plantImage.createBorder(color: UIColor.ThemeColors.green, width: 3)
        }
        
        ui_historyLabel.text = watering.user + " \(Values().wateringSentenceString) \(watering.plant!._plantName)"
        ui_dateLabel.text = "\(hour)\n\(date)"
        
    }

}
