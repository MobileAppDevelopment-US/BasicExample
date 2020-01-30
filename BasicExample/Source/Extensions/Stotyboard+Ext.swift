//
//  Extension+Stotyboard.swift
//  BasicExample
//
//  Created by Serik on 29.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static var tabBarVC: UIStoryboard {
        return UIStoryboard(name: "TabBarVC", bundle: nil)
    }
    
    static var userProfileVC: UIStoryboard {
        return UIStoryboard(name: "UserProfileVC", bundle: nil)
    }
    
    static var myProfileVC: UIStoryboard {
        return UIStoryboard(name: "MyProfileVC", bundle: nil)
    }
    
}
