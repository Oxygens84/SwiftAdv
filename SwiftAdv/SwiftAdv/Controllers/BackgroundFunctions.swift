//
//  BackgroundViewController.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 07/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit

extension MapViewController {
    
    func beginTracker() {
        currentTrack = []
        beginBackgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            guard let beginBackgroundTask = self?.beginBackgroundTask else { return }
            UIApplication.shared.endBackgroundTask(beginBackgroundTask)
            self?.beginBackgroundTask = UIBackgroundTaskIdentifier.invalid
        }
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            
            self?.locationManager?.requestLocation()
            let point = Track()
            point.configure(id: self!.currentTrack.count + 1,
                            latitude: self!.coordinate.latitude,
                            longitude: self!.coordinate.longitude)
            self!.currentTrack.append(point)
            
            print("\( self!.currentTrack)")
            
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
        if timer != nil && beginBackgroundTask != nil {
            timer!.invalidate()
            timer = nil
            UIApplication.shared.endBackgroundTask(beginBackgroundTask!)
            beginBackgroundTask = UIBackgroundTaskIdentifier.invalid
        }
    }

}
