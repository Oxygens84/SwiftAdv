//
//  Dictionaries.swift
//  SwiftAdv
//
//  Created by Oxana Lobysheva on 14/08/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

enum SeguesId: String {
    case goToDashboard = "goToDashboard"
}

enum Messages: String {
    case loginFailed = "Invalid login or password"
    case signUpFailed = "Invalid login or password for registration"
    case stopTracking = "Stop current tracking activity, please"
    case userCurrentLocation = "You are here"
    case newMessage = "You have a message"
}

enum LogMessages: String {
    case activeTrackingError = "Error. User tried to play track while tracking is on"
    case noData = "Warning. No data available"
}

enum Titles: String {
    case warning = "WARNING"
    case error = "ERROR"
    case ok = "OK"
    case map = "MAP:"
    case notification = "NOTIFICATION CENTER"
}

enum Keys: String {
    case isLogin = "isLogin"
}
