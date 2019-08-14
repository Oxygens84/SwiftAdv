//
//  AppDelegate.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 05/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var keys: NSDictionary?
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            let apiKey = dict["apiKey"] as! String
            GMSServices.provideAPIKey(apiKey)
        }

        let cache = URLCache(
            memoryCapacity: 0,
            diskCapacity: 0,
            diskPath: nil)
        URLCache.shared = cache
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        let imageView = UIImageView(frame: self.window!.bounds)
        imageView.tag = 666
        imageView.image = UIImage(named: "background")
        UIApplication.shared.keyWindow?.subviews.last?.addSubview(imageView)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let imageView : UIImageView = UIApplication.shared.keyWindow?.subviews.last?.viewWithTag(666) as? UIImageView {
            imageView.removeFromSuperview()
        }
    }
    
}

