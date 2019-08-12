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

    var coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    var marker: GMSMarker?
    var locationManager: CLLocationManager?
    
    var timer: Timer?
    var startTime: Date?
    let timeInterval: TimeInterval = 180
    var beginBackgroundTask: UIBackgroundTaskIdentifier?

    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    
    var currentTrack: [Track] = []
    var track: Results<Track>!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBAction func goTo(_ sender: Any) {
        locationManager?.requestLocation()
        configureMap()
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
            let alertController = UIAlertController(title: "Warning!", message: "Stop current tracking activity", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: .default){ (action) in
                print("Error. Tracking is on")
            }
            alertController.addAction(confirmAction)
            present(alertController, animated: true, completion: nil)
        } else {
            let realm = try! Realm()
            self.track = realm.objects(Track.self)
            print(self.track ?? "no data")
        }
    }
    
    
    @IBAction func toggleMarker(_ sender: Any) {
        if marker == nil {
            addMarker()
        } else {
            removeMarker()
        }
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        locationManager?.requestLocation()
    }

    @IBAction func updateLocation(_ sender: Any) {
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        locationManager?.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
    }
    
}
