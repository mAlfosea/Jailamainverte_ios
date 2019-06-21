//
//  ImagePickerManager.swift
//  Jailamainverte
//
//  Created by Admin on 21/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

protocol ImagePickerDelegate: class {
    func imagePickerDidFinish (image: UIImage)
}

class ImagePickerManager : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var _presenter: UIViewController?
    weak var _delegate: ImagePickerDelegate?
    var _imagePicker: UIImagePickerController!
    var _imageToSave:UIImage? = nil
    var _imagePickerAlert: UIAlertController?
    
    func createImagePickerAlert(presenter:UIViewController, delegate:ImagePickerDelegate) {
        _presenter = presenter
        _delegate = delegate
        
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
        
        if let presenterTemp = _presenter {
            presenterTemp.present(changePictureAlert, animated: true, completion: nil)
        }
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
        if let presenter = _presenter {
            presenter.present(_imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        _imagePicker.dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage {
            //ui_plant_img.setImageScaleToFill(image: image)
            _delegate?.imagePickerDidFinish(image: image)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        _imagePicker.dismiss(animated: true, completion: nil)
    }
}
