//
//  AppDelegate.swift
//  BasicExample
//
//  Created by Serik on 21.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Fabric
import Firebase

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let userDefaults = UserDefaults.standard
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //FirebaseApp.configure()
        //registerNotifications(application: application)
        IQKeyboardManager.shared.enable = true
        openFirstScreen()
        Fabric.sharedSDK().debug = true
        
        return true
    }
    
    private func openFirstScreen() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let notFirstEnter = userDefaults.bool(forKey: Constants.notFirstEnter)
        if !notFirstEnter {
            userDefaults.set(true, forKey: Constants.notFirstEnter)
        }
//        if notFirstEnter {
            showTabBarVC()
//        } else {
            //showMyProfileVC()
       // }
        window?.makeKeyAndVisible()
    }
    
}

// MARK: - Transition

extension AppDelegate {
    
    private func showTabBarVC() {
        
        guard let vc = TabBarVC.instanceFromStoryboard(.tabBarVC) as? TabBarVC else { return }
       // let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = vc
    }
    
    private func showMyProfileVC() {
        
        let storyboard = UIStoryboard(name: "MyProfileVC", bundle: nil)
        guard let nc = storyboard.instantiateViewController(withIdentifier: "MyProfileNVC") as? UINavigationController else {
            return
        }
        window?.rootViewController = nc
    }
    
//    private func showTabBarVC() {
//
//        guard let vc = TabBarVC.instanceFromStoryboard(.tabBarVC) as? TabBarVC else { return }
//        let nc = UINavigationController(rootViewController: vc)
//        window?.rootViewController = nc
//    }
//
//    private func showMyProfileVC() {
//
//        guard let vc = MyProfileVC.instanceFromStoryboard(.myProfileVC) as? MyProfileVC else { return }
//        let nc = UINavigationController(rootViewController: vc)
//        window?.rootViewController = nc
//    }
    
}

// MARK: - Notification

extension AppDelegate {
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: .updateLocation, object: nil)
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func registerNotifications(application : UIApplication){
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        application.registerForRemoteNotifications()
        UNUserNotificationCenter.current().requestAuthorization( options: [.alert, .sound]){ _, _ in}
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        
        if isChatMessage(userInfo) {
            //let topVC = self.window?.rootViewController?.topViewController
            //completionHandler(topVC is ChannelVC ? [] : [.alert, .sound])
        } else {
            completionHandler([.alert, .sound])
        }
    }
    
    private func isChatMessage(_ userInfo: [AnyHashable : Any]) -> Bool {
        return userInfo["category"] as? String == "NEW_MESSAGE"
    }
    
    private func openChat(channelSid: String, friendName: String?) {
        
        //        let vc = ChannelVC.instance
        //        vc.channelSid = channelSid
        //        vc.friendName = friendName
        //
        //        if let topVC = self.window?.rootViewController?.topViewController, let nc = topVC.navigationController {
        //            nc.pushViewController(vc, animated: true)
        //        } else {
        //            let nc = UINavigationController()
        //            nc.pushViewController(vc, animated: false)
        //            self.window?.rootViewController = nc
        //        }
    }
    
    private func handleNotificationClick(userInfo: [AnyHashable:Any], callback: (() -> Void)?) {
        
        //        guard isChatMessage(userInfo), let channelSid = userInfo["chat_sid"] as? String else {
        //            callback?()
        //            return
        //        }
        //
        //        if self.window?.rootViewController?.topViewController is ChannelVC {
        callback?()
        //            return
        //        }
        //
        //        ChatManager.shared.initializeClient { error in
        //            self.openChat(channelSid: channelSid, friendName: userInfo["friend_name"] as? String)
        //            callback?()
        //        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        handleNotificationClick(userInfo: userInfo, callback: completionHandler)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("fcmToken")
        print(fcmToken)
    }
    
}
