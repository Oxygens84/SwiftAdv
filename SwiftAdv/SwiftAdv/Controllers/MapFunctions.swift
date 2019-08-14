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
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func configureMap(_ coordinate: CLLocationCoordinate2D) {
        let position = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        mapView.animate(to: position)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.currentCoordinate = location.coordinate
        routePath?.add(location.coordinate)
        route?.path = routePath
        configureMap(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error)
    }
    
    func addMarker() {
        let marker = GMSMarker(position: currentCoordinate)
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

    func currentLocation() {
        locationManager.requestLocation()
    }
    
    func updateLocation() {
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
    }
    
}
