//
//  LocationManager.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 18/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let instance = LocationManager()
    let locationManager = CLLocationManager()
    let location: Variable<CLLocation?> = Variable(nil)
    
    private override init(){
        super.init()
        configureLocationManager()
    }
    
    func configureLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.location.value = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error)
    }
    
    func start(){
        locationManager.startUpdatingLocation()
    }
    
    func stop(){
        locationManager.stopUpdatingLocation()
    }
    
    func getCurrentLocation(){
        locationManager.requestLocation()
    }
    
}
