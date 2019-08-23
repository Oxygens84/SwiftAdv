//
//  AuthViewController.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 14/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit
import SAMKeychain

class AuthViewController: UIViewController {

    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func login(_ sender: Any) {
        if checkAuthData(loginField.text!, passwordField.text!){
            saveAuthData()
            performSegue(withIdentifier: SeguesId.goToDashboard.rawValue, sender: nil)
        } else {
            performAlert(message: Messages.loginFailed.rawValue)
        }        
    }
    
    @IBAction func signup(_ sender: Any) {
        if checkSignUpData(loginField.text!, passwordField.text!){
            saveAuthData()
            performSegue(withIdentifier: SeguesId.goToDashboard.rawValue, sender: nil)
        } else {
            performAlert(message: Messages.signUpFailed.rawValue)
        }
    }
    
    @IBAction func logOut(_ segue: UIStoryboardSegue){
        cleanFields()
        deleteAuthData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAuthView()
        configureAuthBindings()
    }
    
}
