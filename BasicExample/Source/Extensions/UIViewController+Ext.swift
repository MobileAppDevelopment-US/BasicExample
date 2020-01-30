//
//  UIViewController+Extension.swift
//  BasicExample
//
//  Created by Serik on 29.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

extension UIViewController {
        
    static func instanceFromStoryboard(_ storyboard: UIStoryboard) -> UIViewController {
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }


    private func topViewController(currentViewController: UIViewController) -> UIViewController {
        
        if let tabBarController = currentViewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
            
        } else if let navigationController = currentViewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
            
       } else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentedViewController)
            
       } else {
            return currentViewController
        }
    }
    
}
