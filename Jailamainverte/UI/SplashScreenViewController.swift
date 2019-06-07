//
//  SplashScreenViewController.swift
//  Jailamainverte
//
//  Created by Admin on 04/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var ui_loginButton: UIButton!
    @IBOutlet weak var ui_signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui_loginButton.layer.cornerRadius = 5
        ui_signinButton.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        UserData.getInstance().isLogged = true
        Switcher.updateRootVC()
    }
    
    @IBAction func unwindToSplash(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
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
