//
//  ViewController.swift
//  Jailamainverte
//
//  Created by Admin on 24/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class AddPlantViewController: UIViewController {

    @IBOutlet weak var ui_plant_img: UIImageView!
    @IBOutlet weak var ui_plant_name_label: UITextField!
    @IBOutlet weak var ui_plant_family_field: UITextField!
    @IBOutlet weak var ui_last_watering_field: UITextField!
    @IBOutlet weak var ui_watering_cycle_field: UITextField!
    @IBOutlet weak var ui_watering_hour_field: UITextField!
    @IBOutlet weak var ui_submit_button: UIButton!
    @IBOutlet weak var ui_change_photo_button: UIButton!
    @IBOutlet weak var ui_select_date_button: UIButton!
    
    var _plantName: String = "kjhk"
    var _plantFamily: String = "kjhk"
    var _lastWatering: String = "kjhk"
    var _wateringCycle: Int = 4
    var _wateringHour: String = "lkjl"
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDatePicker()
        customizeUIElements()
    }
    
    func customizeUIElements () {
        ui_submit_button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        ui_submit_button.layer.cornerRadius = 5
        ui_plant_img.layer.cornerRadius = 5
        ui_change_photo_button.layer.cornerRadius = 5
    }

    @IBAction func addButtonSubmit(_ sender: Any) {
        let plant: Plant = Plant(newName: _plantName, newFamily: _plantFamily, newLastArrosage: _lastWatering, newArrosageCycle: _wateringCycle )
        UserData.getInstance().addPlant(plant: plant)
        
        //navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: "addPlant", sender: self)
    }
    
    @IBAction func changeDateClicked(_ sender: Any) {
        print("JE PASSE BIEN NLA")
        ui_last_watering_field.isSelected = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPlant" {
            let mainTableVC = segue.destination as! MainTableViewController
            mainTableVC.datasUpdated = true
        }
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        ui_last_watering_field.inputAccessoryView = toolbar
        ui_last_watering_field.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        ui_last_watering_field.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}
