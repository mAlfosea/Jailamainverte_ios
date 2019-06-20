//
//  SignInViewController.swift
//  Jailamainverte
//
//  Created by Admin on 06/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var ui_userImage: UIImageView!
    @IBOutlet weak var ui_userMailField: CheckedTextField!
    @IBOutlet weak var ui_userPasswordField: CheckedTextField!
    @IBOutlet weak var ui_userPasswordConfirmField: CheckedTextField!
    @IBOutlet weak var ui_userNickname: CheckedTextField!
    @IBOutlet weak var ui_signButton: UIButton!
    
    @IBOutlet weak var ui_mail_error_label: UILabel!
    @IBOutlet weak var ui_password_error_label: UILabel!
    @IBOutlet weak var ui_nickname_error_label: UILabel!
    
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
        ui_userMailField.addEmptyCheck()
        ui_mail_error_label.isHidden = true
        
        ui_userPasswordField.delegate = self
        ui_userPasswordField.addEmptyCheck()
        ui_password_error_label.isHidden = true
        
        ui_userPasswordConfirmField.delegate = self
        ui_userPasswordConfirmField.addEmptyCheck()
        
        ui_userNickname.delegate = self
        ui_userNickname.addEmptyCheck()
        ui_nickname_error_label.isHidden = true
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signButtonClicked(_ sender: Any) {
        var isValid: Bool = true
        
        if ui_userNickname.resolveCheckList() {
            ui_userNickname.hideError()
            ui_nickname_error_label.isHidden = true
        } else {
            ui_userNickname.showError(border: 2, cornerRadius: 5)
            ui_nickname_error_label.text = Values().textErrorString
            ui_nickname_error_label.isHidden = false
            isValid = false
        }
        
        if ui_userMailField.resolveCheckList() {
            ui_userMailField.hideError()
            ui_mail_error_label.isHidden = true
        } else {
            ui_userMailField.showError(border: 2, cornerRadius: 5)
            ui_mail_error_label.text = Values().textErrorString
            ui_mail_error_label.isHidden = false
            isValid = false
        }
        
        if ui_userPasswordField.resolveCheckList() {
            ui_userPasswordField.hideError()
            ui_password_error_label.isHidden = true
        } else {
            ui_userPasswordField.showError(border: 2, cornerRadius: 5)
            ui_password_error_label.text = Values().textErrorString
            ui_password_error_label.isHidden = false
            isValid = false
        }
        
        if ui_userPasswordConfirmField.resolveCheckList() {
            ui_userPasswordConfirmField.hideError()
            ui_password_error_label.isHidden = true
        } else {
            ui_userPasswordConfirmField.showError(border: 2, cornerRadius: 5)
            ui_password_error_label.text = Values().textErrorString
            ui_password_error_label.isHidden = false
            isValid = false
        }
        
        if isValid {
            let userImgName: String = "user_photo.png"
            saveImage(imageName: userImgName, sourceImg: ui_userImage.image!)
            
            if let user = UserData.getInstance().getUser() {
                let userTemp: User = User()
                userTemp.createUser(userId: user._userId, userName: ui_userNickname.text!, userMail: ui_userMailField.text!, userPassword: ui_userPasswordField.text!, userImagePath: userImgName)
                
                UserData.getInstance().updateUser(user: userTemp)
                
            } else {
                let userTemp = User()
                userTemp.createUser(userId: Int(Date().timeIntervalSince1970), userName: ui_userNickname.text!, userMail: ui_userMailField.text!, userPassword: ui_userPasswordField.text!, userImagePath: userImgName)
                
                UserData.getInstance().updateUser(user: userTemp)
            }
            
            UserData.getInstance().isLogged = true
            Switcher.updateRootVC()

            //dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func changePhotoButtonClicked(_ sender: Any) {
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
        textField.resignFirstResponder()
        return true
    }
    
}
