//
//  ProfileViewController.swift
//  Jailamainverte
//
//  Created by Admin on 05/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var ui_userPhotoImage: UIImageView!
    @IBOutlet weak var ui_userNameField: UITextField!
    @IBOutlet weak var ui_userMailField: UITextField!
    @IBOutlet weak var ui_userPasswordField: UITextField!
    @IBOutlet weak var ui_notificationsSwitch: UISwitch!
    @IBOutlet weak var ui_saveButton: UIButton!
    @IBOutlet weak var ui_logoutButton: UIButton!
    
    var _userName: String?
    var _userMail: String?
    var _userPassword: String?
    var _userPhotoPath: String?
    var _userNotification: Bool?
    
    var _imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeUI()
        // Do any additional setup after loading the view.
    }
    
    func initializeUI() {
        ui_userPhotoImage.layer.cornerRadius = 20
        ui_saveButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        ui_saveButton.layer.cornerRadius = 5
        ui_logoutButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        ui_logoutButton.layer.cornerRadius = 5
        ui_userPhotoImage.createBorder(color: UIColor.ThemeColors.bordeaux, width: 3)
        
        ui_userNameField.delegate = self
        ui_userMailField.delegate = self
        ui_userPasswordField.delegate = self
        
        showInfos()
    }
    
    func showInfos() {
        guard let user = UserData.getInstance().getUser() else { return }
        
        _userName = user._userName
        _userMail = user._userMail
        _userPassword = user._userPassword
        _userPhotoPath = user._userImage
        _userNotification = user._notificationSetting
        
        ui_userPhotoImage.image = getImage(imageName: user._userImage)
        ui_userNameField.text = user._userName
        ui_userMailField.text = user._userMail
        ui_userPasswordField.text = user._userPassword
        ui_notificationsSwitch.isOn = user._notificationSetting
    }
    
    @IBAction func changePhotoClicked(_ sender: Any) {
        let changePictureAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePictureFromCamera = UIAlertAction(title: Values().selectPictureFromCameraString, style: .default) { (_) in
            self.callImagePicker(state: true)
        }
        takePictureFromCamera.createAlertActionImage(imageName: "camera")
        changePictureAlert.addAction(takePictureFromCamera)
        
        let takePictureFromLibrary = UIAlertAction(title: Values().selectPictureFromLibraryString, style: .default) { (_) in
            self.callImagePicker(state: false)
        }
        takePictureFromLibrary.createAlertActionImage(imageName: "picture")
        changePictureAlert.addAction(takePictureFromLibrary)
        
        changePictureAlert.addAction(UIAlertAction(title: Values().cancelButtonString, style: .cancel, handler: nil))
        changePictureAlert.view.tintColor = UIColor.black
        
        present(changePictureAlert, animated: true, completion: nil)
    }
    
    func callImagePicker(state: Bool) {
        _imagePicker = UIImagePickerController()
        _imagePicker.delegate = self
        
        if state {
            if UIImagePickerController.isSourceTypeAvailable(.camera)  {
                _imagePicker.allowsEditing = true
                _imagePicker.sourceType = .camera
            }
        } else {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)  {
                _imagePicker.allowsEditing = true
                _imagePicker.sourceType = .photoLibrary
            }
        }
        present(_imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        _imagePicker.dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage {
            ui_userPhotoImage.setImageScaleToFill(image: image)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        _imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeNameButtonClicked(_ sender: Any) {
        ui_userNameField.setButtonEnableOn()
    }
    @IBAction func changeMailButtonClicked(_ sender: Any) {
        ui_userMailField.setButtonEnableOn()
    }
    @IBAction func changePasswordButtonClicked(_ sender: Any) {
        ui_userPasswordField.setButtonEnableOn()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ui_userNameField {
            _userName = textField.text
        } else if textField == ui_userMailField {
            _userMail = textField.text
        } else {
            _userPassword = textField.text
        }
        textField.setButtonEnableOff()
        return true
    }
    @IBAction func changeNotificationsSwitched(_ sender: UISwitch) {
        _userNotification = ui_notificationsSwitch.isOn
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        let userImgName: String = "user_photo.png"
        saveImage(imageName: userImgName, sourceImg: ui_userPhotoImage.image!)
        
        let realm = try! Realm()
        try! realm.write {
            if let user = UserData.getInstance().getUser() {
                user.createUser(userId: user._userId, userName: _userName!, userMail: _userMail!, userPassword: _userPassword!, userImagePath: userImgName, notificationSetting: _userNotification!)
            } else {
                let newUser = User()
                newUser.createUser(userId: Int(Date().timeIntervalSince1970), userName: _userName!, userMail: _userMail!, userPassword: _userPassword!, userImagePath: userImgName, notificationSetting: _userNotification!)
                UserData.getInstance().updateUser(user: newUser)
                realm.add(newUser)
            }
        }
        
        Toast.show(message: Values().saveUserToastString, controller: self)
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        UserData.getInstance().isLogged = false
        Switcher.updateRootVC()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
