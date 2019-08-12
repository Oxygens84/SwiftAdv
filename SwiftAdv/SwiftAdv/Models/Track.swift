//
//  Track.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 11/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import RealmSwift

class Track: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    
    func configure(id: Int, latitude: Double, longitude: Double){
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }
}
