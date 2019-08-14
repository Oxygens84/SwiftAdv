//
//  AuthViewController.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 14/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func login(_ sender: Any) {
        if checkAuthData(loginField.text!, passwordField.text!){
            UserDefaults.standard.set(true, forKey: Keys.isLogin.rawValue)
            performSegue(withIdentifier: SeguesId.goToDashboard.rawValue, sender: nil)
        } else {
            performAlert(message: Messages.loginFailed.rawValue)
        }        
    }
    
    @IBAction func signup(_ sender: Any) {
        if checkSignUpData(loginField.text!, passwordField.text!){
            UserDefaults.standard.set(false, forKey: Keys.isLogin.rawValue)
            performSegue(withIdentifier: SeguesId.goToDashboard.rawValue, sender: nil)
        } else {
            performAlert(message: Messages.signUpFailed.rawValue)
        }
    }
    
    @IBAction func logOut(_ segue: UIStoryboardSegue){
        cleanFields()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAuthView()
    }
    
}
