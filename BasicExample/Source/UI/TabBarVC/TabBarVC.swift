//
//  TabBarVC.swift
//  BasicExample
//
//  Created by Serik on 29.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        tabBar.tintColor = Design.blue
        tabBar.isTranslucent = false
        tabBar.items?[0].title = "Users"
        tabBar.items?[1].title = "My profile"
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: Design.avenirMedium, size: 14)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
    
}

//extension TabBarVC : ChatManagerBadgeDelegate {
//
//    func unreadMessagesChanged(count : UInt) {
//        if count > 0 {
//            tabBar.items?[1].badgeValue = "\(count)"
//        } else {
//            tabBar.items?[1].badgeValue = nil;
//        }
//    }
//
//}
