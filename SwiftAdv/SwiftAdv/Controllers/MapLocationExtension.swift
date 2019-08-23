//
//  MapLocationExtension.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 07/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import GoogleMaps
import CoreLocation
import MapKit

extension MapViewController: CLLocationManagerDelegate {
    
    func configureMap(_ coordinate: CLLocationCoordinate2D) {
        let position = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        mapView.animate(to: position)
    }
    
    func configureLocationManager() {
        locationManager.location.asObservable().bind{ [weak self] location in
        guard let location = location else {return}
        self?.currentCoordinate = location.coordinate
        self?.routePath?.add(location.coordinate)
        self?.route?.path = self?.routePath
        self?.configureMap(location.coordinate)
        }        
    }
    
    func addMarker() {
        let marker = GMSMarker(position: currentCoordinate)
        marker.icon = GMSMarker.markerImage(with: .green)
        marker.map = mapView
        marker.title = Titles.map.rawValue
        marker.snippet = Messages.userCurrentLocation.rawValue
        self.marker = marker
    }
    
    func removeMarker() {
        if let marker = marker {
            marker.map = nil
            self.marker = nil
        }
    }

    func updateLocation() {
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
    }
    
}
