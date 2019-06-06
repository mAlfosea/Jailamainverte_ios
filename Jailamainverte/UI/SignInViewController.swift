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
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func changePhotoButtonClicked(_ sender: Any) {
        let changePictureAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePictureFromCamera = UIAlertAction(title: UserData.getInstance().selectPictureFromCameraString, style: .default) { (_) in
            self.callImagePicker(state: true)
        }
        takePictureFromCamera.createAlertActionImage(imageName: "edit")
        changePictureAlert.addAction(takePictureFromCamera)
        
        let takePictureFromLibrary = UIAlertAction(title: UserData.getInstance().selectPictureFromLibraryString, style: .default) { (_) in
            self.callImagePicker(state: false)
        }
        takePictureFromLibrary.createAlertActionImage(imageName: "loupe")
        changePictureAlert.addAction(takePictureFromLibrary)
        
        changePictureAlert.addAction(UIAlertAction(title: UserData.getInstance().cancelButtonString, style: .cancel, handler: nil))
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
    
}
