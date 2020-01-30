//
//  AccountManager.swift
//  BasicExample
//
//  Created by Serik on 29.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//


import Foundation

class AccountManager {
    
    public static func getUserId() -> String? {
        return PrefUtils.userId
    }
    
    public static func getToken() -> String? {
        return PrefUtils.accessToken
    }
    
    public static func login(token: String, userId: String){
        PrefUtils.accessToken = token
        PrefUtils.userId = userId
    }
    
    public static func logout(){
        resetToken()
        PrefUtils.accessToken = nil
    }
    
    private static func resetToken(){
        // TODO
    }
}
