//
//  PrefUtils.swift
//  BasicExample
//
//  Created by Serik on 28.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import Foundation

class PrefUtils {
    
    private static let userDefaults = UserDefaults.standard
    
    private static let USER_ID = "USER_ID"
    
    public static var accessToken : String? {
        get { return userDefaults.string(forKey: Constants.keyAccessToken) }
        set { userDefaults.setValue(newValue, forKey: Constants.keyAccessToken) }
    }
    
    public static var userId : String? {
        get { return userDefaults.string(forKey: USER_ID) }
        set { userDefaults.setValue(newValue, forKey: USER_ID) }
    }
    
    
}
