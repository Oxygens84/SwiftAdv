//
//  AuthViewController.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 14/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit
import AVFoundation
import SAMKeychain
import Photos

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
    
    @IBAction func takeSelfie(_ sender: Any) {
        //.photoLibrary
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {return}
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAuthView()
        configureAuthBindings()
    }
    
}
