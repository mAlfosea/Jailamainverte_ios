//
//  ViewController.swift
//  Jailamainverte
//
//  Created by Admin on 24/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class AddPlantViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ImagePickerDelegate  {
    
    @IBOutlet weak var ui_plant_img: UIImageView!
    @IBOutlet weak var ui_plant_name_label: CheckedTextField!
    @IBOutlet weak var ui_plant_family_field: UITextField!
    @IBOutlet weak var ui_last_watering_field: UITextField!
    @IBOutlet weak var ui_watering_hour_field: UITextField!
    @IBOutlet weak var ui_submit_button: UIButton!
    @IBOutlet weak var ui_delete_button: UIButton!
    @IBOutlet weak var ui_change_photo_button: UIButton!
    @IBOutlet weak var ui_select_date_button: UIButton!
    @IBOutlet weak var ui_watering_cycle_label: UILabel!
    @IBOutlet weak var ui_view_label: UILabel!
    
    var _isAddingPlant: Bool = true
    var _plantToModify: Plant?
    var _plantRowID: Int?
    
    var _plantName: String = ""
    var _plantFamily: String = ""
    var _lastWatering: Date = Date()
    var _wateringCycle: Int = 1
    var _wateringHour: Date = Date()
    
    let datePicker = UIDatePicker()
    let hourPicker = UIDatePicker()
    let familyPicker = UIPickerView()
    
    var _imagePicker: ImagePickerManager?
    var _imageToSave:UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        showFamilyPicker()
        showDatePicker()
        showHourPicker()
        
        familyPicker.delegate = self
        familyPicker.dataSource = self
        ui_plant_name_label.delegate = self
        ui_plant_name_label.addEmptyCheck()
        
        ui_change_photo_button.layer.cornerRadius = 5
        ui_plant_img.layer.cornerRadius = 5
        ui_plant_img.createBorder(color: UIColor.ThemeColors.bordeaux, width: 3)
        
        ui_submit_button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        ui_submit_button.layer.cornerRadius = 5
        
        ui_delete_button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        ui_delete_button.layer.cornerRadius = 5
        
        if _isAddingPlant {
            showAddPlantUI()
        } else {
            showModifyPlantUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func showAddPlantUI () {
        let values = Values()
        ui_view_label.text = values.addPlantTitleString
        ui_submit_button.setTitle(values.addPlantButtonString, for: .normal)
        ui_delete_button.isHidden = true
        
        doneDatePicker()
        doneHourPicker()
        
        _plantFamily = values.plantsFamily[0]
        ui_plant_family_field.text = _plantFamily
        
        ui_watering_cycle_label.text = String(_wateringCycle) + values.dayMinString
    }
    
    func showModifyPlantUI () {
        let values = Values()
        ui_view_label.text = values.modifyPlantTitleString
        ui_submit_button.setTitle(values.modifyPlantButtonString, for: .normal)
        ui_delete_button.isHidden = false
        
        if let plant = _plantToModify {
            
            _plantName = plant._plantName
            _plantFamily = plant._plantFamily
            _wateringCycle = plant._arrosageCycle
            datePicker.date = plant._lastArrosage
            hourPicker.date = plant._cycleHour
            
            doneDatePicker()
            doneHourPicker()
            
            ui_plant_name_label.text = plant._plantName
            
            if let plantImage = getImage(imageName: plant._plantImgPath) {
                ui_plant_img.setImageScaleToFill(image: plantImage)
            }
            ui_plant_family_field.text = plant._plantFamily
            ui_watering_cycle_label.text = String(plant._arrosageCycle) + values.dayMinString
        }
    }
    
    @IBAction func addButtonSubmit(_ sender: Any) {
        var isValid: Bool = true
        if ui_plant_name_label.resolveCheckList() {
            ui_plant_name_label.hideError()
            //ui_mail_error_label.isHidden = true
        } else {
            ui_plant_name_label.showError(border: 2, cornerRadius: 5)
            //ui_mail_error_label.text = Values().textErrorString
            //ui_mail_error_label.isHidden = false
            isValid = false
        }
        
        guard isValid else {
            return
        }
        
        if _isAddingPlant {
            let plantImgName: String = "plant_\(Date().timeIntervalSince1970).png"
            saveImage(imageName: plantImgName, sourceImg: ui_plant_img.image!)
            
            let plant: Plant = Plant()
            plant.createPlant(newId: Int(Date().timeIntervalSince1970), newName: _plantName, newFamily: _plantFamily, newPlantImgPath: plantImgName, newLastArrosage: _lastWatering, newArrosageCycle: _wateringCycle, newArrosageHour: _wateringHour, newDeleted: false)
            
            UserData.getInstance().addPlant(plant: plant)
          
        } else {
            if let plant = _plantToModify {
                let plantImgName: String = plant._plantImgPath
                saveImage(imageName: plantImgName, sourceImg: ui_plant_img.image!)
                
                let plantTemp: Plant = Plant()
                plantTemp.createPlant(newId: plant._plantId, newName: _plantName, newFamily: _plantFamily, newPlantImgPath: plantImgName, newLastArrosage: _lastWatering, newArrosageCycle: _wateringCycle, newArrosageHour: _wateringHour, newDeleted: plant._deleted)
                
                UserData.getInstance().updatePlant(oldPlant: plant, newPlant: plantTemp)
            }
        }
        
        if let tabController = presentingViewController as? UITabBarController,
            let navController = tabController.selectedViewController as? UINavigationController,
            let mainTableVC = navController.topViewController as? MainTableViewController {
            mainTableVC.datasUpdated = true
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if let index = _plantRowID {
            UserData.getInstance().removePlant(index: index)
        }
        
        if let tabController = presentingViewController as? UITabBarController,
            let navController = tabController.selectedViewController as? UINavigationController,
            let mainTableVC = navController.topViewController as? MainTableViewController {
            mainTableVC.datasUpdated = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeFamilylicked(_ sender: Any) {
        ui_plant_family_field.becomeFirstResponder()
    }
    
    @IBAction func changeDateClicked(_ sender: Any) {
        ui_last_watering_field.becomeFirstResponder()
    }
    
    @IBAction func downCycleButtonClicked(_ sender: Any) {
        if _wateringCycle > 1 {
            _wateringCycle -= 1
            ui_watering_cycle_label.text = String(_wateringCycle) + Values().dayMinString
        }
    }
    
    @IBAction func upCycleButtonClicked(_ sender: Any) {
            _wateringCycle += 1
            ui_watering_cycle_label.text = String(_wateringCycle) + Values().dayMinString
    }
    
    @IBAction func changePhotoButtonClicked(_ sender: Any) {
        _imagePicker = ImagePickerManager()
        _imagePicker?.createImagePickerAlert(presenter: self, delegate: self)
    }
    
    func imagePickerDidFinish(image: UIImage) {
        ui_plant_img.setImageScaleToFill(image: image)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nameTemp = ui_plant_name_label.text {
            _plantName = nameTemp
            ui_plant_name_label.resignFirstResponder()
        }
        return true
    }
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: Values().doneButtonString, style: .plain, target: self, action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: Values().cancelButtonString, style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        ui_last_watering_field.inputAccessoryView = toolbar
        ui_last_watering_field.inputView = datePicker
    }
    
    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        //formatter.dateFormat = "dd/MM/yyyy"
        _lastWatering = datePicker.date
        ui_last_watering_field.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    func showHourPicker(){
        hourPicker.datePickerMode = .time
        hourPicker.minuteInterval = 30
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: Values().doneButtonString, style: .plain, target: self, action: #selector(doneHourPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: Values().cancelButtonString, style: .plain, target: self, action: #selector(cancelHourPicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        ui_watering_hour_field.inputAccessoryView = toolbar
        ui_watering_hour_field.inputView = hourPicker
    }
    
    @objc func doneHourPicker(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        _wateringHour = hourPicker.date.nearestThirtyMinutes()
        ui_watering_hour_field.text = formatter.string(from: hourPicker.date.nearestThirtyMinutes())
        self.view.endEditing(true)
    }
    
    @objc func cancelHourPicker(){
        self.view.endEditing(true)
    }
    
    
    func showFamilyPicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: Values().doneButtonString, style: .plain, target: self, action: #selector(doneFamilyPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: Values().cancelButtonString, style: .plain, target: self, action: #selector(cancelFamilyPicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        ui_plant_family_field.inputAccessoryView = toolbar
        ui_plant_family_field.inputView = familyPicker
    }
    
    @objc func doneFamilyPicker(){
        self.view.endEditing(true)
    }
    
    @objc func cancelFamilyPicker(){
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Values().plantsFamily.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Values().plantsFamily[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _plantFamily = Values().plantsFamily[row]
        ui_plant_family_field.text = _plantFamily
    }
}
