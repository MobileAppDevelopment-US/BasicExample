//
//  Constants.swift
//  BasicExample
//
//  Created by Serik on 30.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import Foundation

open class Constants {
    
    // static let shared = Constants()
    private init() {}
    
    // Key
    static let keyUser: String                      = "keyUser"
    static let keyAccessToken: String               = "keyAccessToken"
    static let notFirstEnter: String                = "keyNotFirstEnter"
    static let keyShowRequestLocation: String       = "keyShowRequestLocation"
    
    // Instagram
    static let apiKey: String                       = "fe97090fe9a38824f88b716847ed4c774df1f916377ca1fdac4cae6aa240b631"
    static let apiUrl: String                       = "https://i.instagram.com/api/v1/"
    static let anonymousCsrfValue: String           = "VH1S5AAAAAG5YncfHQLXFDWMksCe"
    
    // NotificationKey
    static let kGetRemoteConfig: String             = "kGetRemoteConfig"
    static let kStringsUpdatedToFirebase: String    = "kStringsUpdatedToFirebase"
    
    // UserDefaults
    static let isDefaultRealm: String               = "isDefaultRealm"
    static let isShowLoginPertact: String           = "isShowLoginPertactTrackPlus"     // RemoteConfig
    static let isShowLoginInstagram: String         = "isShowLoginInstagramTrackPlus" // RemoteConfig
    
    // Settings links
    static let privacyPolicy: String                = "https://www.trackerpro.org/privacy.html"
    static let termsOfUse: String                   = "https://www.trackerpro.org/terms.html"
    static let aboutSubscriptions: String           = "https://www.trackerpro.org/subscription.html"
    static let supportMail: String                  = "support@instareport.app"
}
