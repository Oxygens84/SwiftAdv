//
//  User.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 14/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import RealmSwift

class User: Object {
    
    //@objc dynamic var id: Int = -1
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""
    
    func configure(login: String, password: String){
        self.login = login
        self.password = password
    }
    
    override class func primaryKey() -> String? {
        return "login"
    }
}
