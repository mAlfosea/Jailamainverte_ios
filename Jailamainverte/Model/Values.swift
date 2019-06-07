//
//  Values.swift
//  Jailamainverte
//
//  Created by Admin on 07/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

class Values {
    
    let plantsFamily: [String] = ["Aucune", "Rose", "Jacynthe", "Géranium", "Lila"]
    
    let dayMinString: String = NSLocalizedString("d", comment: "diminutif pour l'unite jour")
    let doneButtonString: String = NSLocalizedString("Done", comment: "boutton done pour les toolbars")
    let cancelButtonString: String = NSLocalizedString("Cancel", comment: "boutton cancel pour les toolbars")
    let selectPictureFromCameraString: String = NSLocalizedString("Camera", comment: "bouton pour prendre une photo avec l'appareil photo")
    let selectPictureFromLibraryString: String = NSLocalizedString("Photo Library", comment: "bouton pour prendre une photo depuis la librairie")
    let wateringSentenceString: String = NSLocalizedString("has watered", comment: "texte dans l'historique des arrosages")
    let wateringToastString: String = NSLocalizedString("thank you :)", comment: "texte sur le toast d'arrosage")
    let saveUserToastString: String = NSLocalizedString("Profil updated", comment: "texte sur le toast de modif du profil")
    
    let isLoggedUserDefaultName: String = "ISLOGGED"
    
}
