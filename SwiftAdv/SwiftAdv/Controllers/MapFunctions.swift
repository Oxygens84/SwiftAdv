//
//  MapFunctions.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 07/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import GoogleMaps
import CoreLocation
import MapKit

extension MapViewController: CLLocationManagerDelegate {
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.delegate = self
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.startMonitoringSignificantLocationChanges()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        mapView.camera = camera
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.coordinate = location.coordinate
        routePath?.add(location.coordinate)
        route?.path = routePath
        mapView?.camera = GMSCameraPosition.init(target: location.coordinate,   zoom: 17)
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func addMarker() {
        let marker = GMSMarker(position: coordinate)
        marker.icon = GMSMarker.markerImage(with: .green)
        marker.map = mapView
        marker.title = "Map:"
        marker.snippet = "You are here"
        self.marker = marker
    }
    
    func removeMarker() {
        if let marker = marker {
            marker.map = nil
            self.marker = nil
        }
    }

}
