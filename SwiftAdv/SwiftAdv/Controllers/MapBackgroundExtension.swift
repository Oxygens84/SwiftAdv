//
//  MapBackgroundExtension.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 07/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit

extension MapViewController {
    
    func beginTracker() {
        mapView.clear()
        locationManager.startUpdatingLocation()
        currentTrack = []
        beginBackgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            guard let beginBackgroundTask = self?.beginBackgroundTask else { return }
            UIApplication.shared.endBackgroundTask(beginBackgroundTask)
            self?.beginBackgroundTask = UIBackgroundTaskIdentifier.invalid
        }
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
            self?.updateLocation()
            let newLatitude = self!.currentCoordinate.latitude
            let newLongitude = self!.currentCoordinate.longitude
            if newLatitude != self!.currentTrack.last?.latitude
                || newLongitude != self!.currentTrack.last?.longitude {
                let point = Track()
                point.configure(id: self!.currentTrack.count + 1,
                                latitude: newLatitude,
                                longitude: newLongitude)
                self!.currentTrack.append(point)
            }
            
            guard
                let startTime = self?.startTime,
                let timeInterval = self?.timeInterval,
                let beginBackgroundTask = self?.beginBackgroundTask
                else {
                    return
            }
            
            let leftSeconds = Date().timeIntervalSince1970 - startTime.timeIntervalSince1970
            if leftSeconds >= timeInterval {
                self?.timer?.invalidate()
                self?.timer = nil
                UIApplication.shared.endBackgroundTask(beginBackgroundTask)
                self?.beginBackgroundTask = UIBackgroundTaskIdentifier.invalid
            }
        }
    }
    
    func stopTracker() {
        locationManager.stopUpdatingLocation()
        if timer != nil && beginBackgroundTask != nil {
            timer!.invalidate()
            timer = nil
            UIApplication.shared.endBackgroundTask(beginBackgroundTask!)
            beginBackgroundTask = UIBackgroundTaskIdentifier.invalid
        }
    }

}
