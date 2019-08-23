//
//  AuthExtension.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 14/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit
import RealmSwift
import SAMKeychain
import RxCocoa
import RxSwift

extension AuthViewController {

    func configureAuthView(){
        passwordField.isSecureTextEntry = true
        loginField.autocorrectionType = .no
        SAMKeychain.setAccessibilityType(kSecAttrAccessibleWhenUnlocked)
    }
    
    func configureAuthBindings(){
        Observable
            .combineLatest(loginField.rx.text, passwordField.rx.text)
            .map{ login, password in
                return !(login ?? "").isEmpty && (password ?? "").count >= 6
            }
            .bind{ [weak loginButton, signupButton] inputFilled in
                loginButton?.isEnabled = inputFilled
                signupButton?.isEnabled = inputFilled
                if inputFilled {
                    loginButton?.backgroundColor = UIColor.purple
                    signupButton?.backgroundColor = UIColor.purple
                } else {
                    loginButton?.backgroundColor = UIColor.darkGray
                    signupButton?.backgroundColor = UIColor.darkGray
                }
                
        }
    }
    
    func checkAuthData(_ userLogin: String, _ userPassword: String) -> Bool{
        let realm = try! Realm()
        let user = User()
        user.configure(login: userLogin, password: userPassword)
        guard let realmUser = realm.object(ofType: User.self, forPrimaryKey: userLogin) else {
            return false
        }
        if userLogin == realmUser.login && userPassword == realmUser.password {
            return true
        }
        return false
    }
    
    func checkSignUpData(_ userLogin: String, _ userPassword: String) -> Bool{
        if userLogin != "" && userPassword != "" {
            let realm = try! Realm()
            print("RealmDataBase =  \(Realm.Configuration.defaultConfiguration.fileURL as Any)")
            let user = User()
            user.configure(login: userLogin, password: userPassword)
            try! realm.write {
                if realm.object(ofType: User.self, forPrimaryKey: userLogin) != nil {
                    realm.add(user, update: .modified)
                } else {
                    realm.add(user)
                }
            }
            return true
        }
        return false
    }
    
    func performAlert(message: String){
        let alert = UIAlertController(
            title: Titles.error.rawValue,
            message: message,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Titles.ok.rawValue, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func cleanFields(){
        loginField.text = ""
        passwordField.text = ""
    }
    
    func saveAuthData(){
        UserDefaults.standard.set(true, forKey: Keys.isLogin.rawValue)
        SAMKeychain.setPassword(loginField.text!, forService: "login", account: "Demo")
        SAMKeychain.setPassword(passwordField.text!, forService: "password", account: "Demo")
    }
    
    func deleteAuthData(){
        UserDefaults.standard.set(false, forKey: Keys.isLogin.rawValue)
        SAMKeychain.deletePassword(forService: "login", account: "Demo")
        SAMKeychain.deletePassword(forService: "password", account: "Demo")
    }
}
