//
//  ViewController.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 05/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import MapKit
import RealmSwift

class MapViewController: UIViewController {

    var currentCoordinate = CLLocationCoordinate2D(latitude: 37.33172861, longitude: -122.03068446)
    var locationManager: CLLocationManager = CLLocationManager()
    var marker: GMSMarker?
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    
    var timer: Timer?
    var startTime: Date?
    let timeInterval: TimeInterval = 180
    var beginBackgroundTask: UIBackgroundTaskIdentifier?

    var currentTrack: [Track] = []
    var track: Results<Track>!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBAction func goTo(_ sender: Any) {
        locationManager.requestLocation()
        configureMap(currentCoordinate)
        addMarker()
    }
    
    @IBAction func startTracking(_ sender: Any) {
        if timer == nil {
            beginTracker()
        }
    }
    
    @IBAction func stopTracking(_ sender: Any) {
        if timer != nil {
            stopTracker()
            let realm = try! Realm()
            try! realm.write(){
                realm.deleteAll()
                for point in currentTrack {
                    realm.add(point)
                }
            }
        }
    }    
    
    @IBAction func playTracking(_ sender: Any) {
        if timer != nil {
            let alertController = UIAlertController(title: Titles.warning.rawValue,
                                                    message: Messages.stopTracking.rawValue,
                                                    preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: Titles.ok.rawValue,
                                              style: .default){ (action) in
                print(LogMessages.activeTrackingError.rawValue)
            }
            alertController.addAction(confirmAction)
            present(alertController, animated: true, completion: nil)
        } else {
            locationManager.stopUpdatingLocation()
            mapView.clear()
            updateLocation()
            
            let realm = try! Realm()
            track = realm.objects(Track.self)
            print(track ?? LogMessages.noData.rawValue)
            for point in track {
                self.currentCoordinate.latitude = point.latitude
                self.currentCoordinate.longitude = point.longitude
                configureMap(self.currentCoordinate)
                routePath?.add(self.currentCoordinate)
                route?.path = routePath
            }
        }
    }
    
    @IBAction func toggleMarker(_ sender: Any) {
        if marker == nil {
            addMarker()
        } else {
            removeMarker()
        }
    }    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
    }
    
}
