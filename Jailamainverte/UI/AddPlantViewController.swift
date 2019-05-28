//
//  ViewController.swift
//  Jailamainverte
//
//  Created by Admin on 24/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class AddPlantViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate  {
    
    @IBOutlet weak var ui_plant_img: UIImageView!
    @IBOutlet weak var ui_plant_name_label: UITextField!
    @IBOutlet weak var ui_plant_family_field: UITextField!
    @IBOutlet weak var ui_last_watering_field: UITextField!
    @IBOutlet weak var ui_watering_hour_field: UITextField!
    @IBOutlet weak var ui_submit_button: UIButton!
    @IBOutlet weak var ui_change_photo_button: UIButton!
    @IBOutlet weak var ui_select_date_button: UIButton!
    @IBOutlet weak var ui_watering_cycle_label: UILabel!
    
    var _plantName: String = ""
    var _plantFamily: String = ""
    var _lastWatering: Date = Date()
    var _wateringCycle: Int = 1
    var _wateringHour: Date = Date()
    
    let datePicker = UIDatePicker()
    let hourPicker = UIDatePicker()
    let familyPicker = UIPickerView()
    let pickerData = ["Rose", "Jacynthe", "Géranium", "Lila"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUIElements()
    }
    
    func customizeUIElements () {
        showFamilyPicker()
        showDatePicker()
        showHourPicker()
        
        doneDatePicker()
        doneHourPicker()
        
        familyPicker.delegate = self
        familyPicker.dataSource = self
        
        ui_plant_name_label.delegate = self
        ui_watering_cycle_label.text = String(_wateringCycle) + "j"
        ui_submit_button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        ui_submit_button.layer.cornerRadius = 5
        ui_plant_img.layer.cornerRadius = 5
        ui_change_photo_button.layer.cornerRadius = 5
    }
    
    @IBAction func addButtonSubmit(_ sender: Any) {
        let plant: Plant = Plant(newName: _plantName, newFamily: _plantFamily, newLastArrosage: _lastWatering, newArrosageCycle: _wateringCycle, newArrosageHour: _wateringHour)
        UserData.getInstance().addPlant(plant: plant)
        
        if let navController = presentingViewController as? UINavigationController,
            let mainTableVC = navController.topViewController as? MainTableViewController {
            mainTableVC.datasUpdated = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeDateClicked(_ sender: Any) {
        ui_last_watering_field.isEnabled = true
        ui_last_watering_field.becomeFirstResponder()
    }
    
    @IBAction func downCycleButtonClicked(_ sender: Any) {
        if _wateringCycle > 1 {
            _wateringCycle -= 1
            ui_watering_cycle_label.text = String(_wateringCycle) + "j"
        }
    }
    
    @IBAction func upCycleButtonClicked(_ sender: Any) {
            _wateringCycle += 1
            ui_watering_cycle_label.text = String(_wateringCycle) + "j"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nameTemp = ui_plant_name_label.text {
            _plantName = nameTemp
            ui_plant_name_label.resignFirstResponder()
        }
        return true
    }
    
    
    
    func showDatePicker(){
        datePicker.datePickerMode = .dateAndTime
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        ui_last_watering_field.inputAccessoryView = toolbar
        ui_last_watering_field.inputView = datePicker
    }
    
    @objc func doneDatePicker(){
        
        ui_last_watering_field.isEnabled = false
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        _lastWatering = datePicker.date
        ui_last_watering_field.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        ui_last_watering_field.isEnabled = false
        
        self.view.endEditing(true)
    }
    
    
    
    func showHourPicker(){
        hourPicker.datePickerMode = .time
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneHourPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelHourPicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        ui_watering_hour_field.inputAccessoryView = toolbar
        ui_watering_hour_field.inputView = hourPicker
    }
    
    @objc func doneHourPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:00"
        _wateringHour = hourPicker.date
        ui_watering_hour_field.text = formatter.string(from: hourPicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelHourPicker(){
        self.view.endEditing(true)
    }
    
    
    func showFamilyPicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneFamilyPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelFamilyPicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        ui_plant_family_field.inputAccessoryView = toolbar
        ui_plant_family_field.inputView = familyPicker
    }
    
    @objc func doneFamilyPicker(){
        ui_plant_family_field.isEnabled = false
        self.view.endEditing(true)
    }
    
    @objc func cancelFamilyPicker(){
        ui_plant_family_field.isEnabled = false
        
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _plantFamily = pickerData[row]
        ui_plant_family_field.text = _plantFamily
    }
}
