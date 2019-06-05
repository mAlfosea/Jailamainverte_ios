//
//  ProfileViewController.swift
//  Jailamainverte
//
//  Created by Admin on 05/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var ui_userPhotoImage: UIImageView!
    @IBOutlet weak var ui_userNameField: UITextField!
    @IBOutlet weak var ui_userMailField: UITextField!
    @IBOutlet weak var ui_userPasswordField: UITextField!
    @IBOutlet weak var ui_notificationsSwitch: UISwitch!
    @IBOutlet weak var ui_saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeUI()
        // Do any additional setup after loading the view.
    }
    
    func initializeUI() {
        ui_userPhotoImage.layer.cornerRadius = 20
        ui_saveButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        ui_saveButton.layer.cornerRadius = 5
        
        showInfos()
    }
    
    func showInfos() {
        ui_userPhotoImage.image = getImage(imageName: UserData.getInstance()._user._userImage)
        ui_userNameField.text = UserData.getInstance()._user._userName
        ui_userMailField.text = UserData.getInstance()._user._userMail
        ui_userPasswordField.text = UserData.getInstance()._user._userPassword
        ui_notificationsSwitch.isOn = UserData.getInstance()._user._notificationSetting
    }
    
    @IBAction func changePhotoClicked(_ sender: Any) {
    }
    @IBAction func changeNameButtonClicked(_ sender: Any) {
    }
    @IBAction func changeMailButtonClicked(_ sender: Any) {
    }
    @IBAction func changePasswordButtonClicked(_ sender: Any) {
    }
    @IBAction func changeNotificationsSwitched(_ sender: UISwitch) {
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
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
