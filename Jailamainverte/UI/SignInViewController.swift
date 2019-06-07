//
//  SignInViewController.swift
//  Jailamainverte
//
//  Created by Admin on 06/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import RealmSwift

class SignInViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var ui_userImage: UIImageView!
    @IBOutlet weak var ui_userMailField: UITextField!
    @IBOutlet weak var ui_userPasswordField: UITextField!
    @IBOutlet weak var ui_userPasswordConfirmField: UITextField!
    @IBOutlet weak var ui_userNickname: UITextField!
    @IBOutlet weak var ui_signButton: UIButton!
    
    var _imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeUI()
    }
    
    func initializeUI() {
        ui_userImage.createBorder(color: UIColor.ThemeColors.bordeaux, width: 3)
        ui_userImage.layer.cornerRadius = 20
        ui_signButton.layer.cornerRadius = 5
        ui_signButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        ui_userMailField.delegate = self
        ui_userPasswordField.delegate = self
        ui_userPasswordConfirmField.delegate = self
        ui_userNickname.delegate = self
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signButtonClicked(_ sender: Any) {
        let userImgName: String = "user_photo.png"
        saveImage(imageName: userImgName, sourceImg: ui_userImage.image!)
        
        let realm = try! Realm()
        try! realm.write {
            if let user = UserData.getInstance().getUser() {
                user.createUser(userId: user._userId, userName: ui_userNickname.text!, userMail: ui_userMailField.text!, userPassword: ui_userPasswordField.text!, userImagePath: userImgName, notificationSetting: true)
            } else {
                let newUser = User()
                newUser.createUser(userId: Int(Date().timeIntervalSince1970), userName: ui_userNickname.text!, userMail: ui_userMailField.text!, userPassword: ui_userPasswordField.text!, userImagePath: userImgName, notificationSetting: true)
                UserData.getInstance().updateUser(user: newUser)
                realm.add(newUser)
            }
            UserData.getInstance().isLogged = true
            Switcher.updateRootVC()
        }
        
        //dismiss(animated: true, completion: nil)
    }
    @IBAction func changePhotoButtonClicked(_ sender: Any) {
        let changePictureAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePictureFromCamera = UIAlertAction(title: Values().selectPictureFromCameraString, style: .default) { (_) in
            self.callImagePicker(state: true)
        }
        takePictureFromCamera.createAlertActionImage(imageName: "edit")
        changePictureAlert.addAction(takePictureFromCamera)
        
        let takePictureFromLibrary = UIAlertAction(title: Values().selectPictureFromLibraryString, style: .default) { (_) in
            self.callImagePicker(state: false)
        }
        takePictureFromLibrary.createAlertActionImage(imageName: "loupe")
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
            ui_userImage.setImageScaleToFill(image: image)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        _imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       /* if textField == ui_userNameField {
            _userName = textField.text
        } else if textField == ui_userMailField {
            _userMail = textField.text
        } else {
            _userPassword = textField.text
        }*/
        textField.setButtonEnableOff()
        return true
    }
    
}
