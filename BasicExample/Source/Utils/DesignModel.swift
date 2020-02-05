//
//  DesignModel.swift
//  BasicExample
//
//  Created by Serik on 28.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

typealias Design = DesignModel

open class DesignModel {

    // Fonts Size
    static let small: CGFloat = 13.0
    static let medium: CGFloat = 16.0
    static let standart: CGFloat = 17.0
    static let standart1: CGFloat = 20.0
    static let big: CGFloat = 24.0

    // Fonts
    static let avenirBold: String = "Avenir-Black"
    static let avenirMedium: String = "Avenir-Medium"
    static let avenirLight: String = "Avenir-Light"
    
    // Colors
    static var black: UIColor { return .black }
    static var white: UIColor { return .white }
    static var selectedColor: UIColor { return .lightGray }
    
    
    static var grayText: UIColor { return UIColor(red: 160.0/255.0,
                                                  green: 160.0/255.0,
                                                  blue: 160.0/255.0,
                                                  alpha: 1.0) }
    
    static var blue: UIColor { return UIColor(red: 5.0/255.0,
                                              green: 124.0/255.0,
                                              blue: 255.0/255.0,
                                              alpha: 1.0) }
    
    static var leftGradient: CGColor { return UIColor(red: 115.0/255.0,
                                                      green: 218.0/255.0,
                                                      blue: 206.0/255.0,
                                                      alpha: 1.0).cgColor }
    
    static var centerGradient: CGColor { return UIColor(red: 109.0/255.0,
                                                        green: 189.0/255.0,
                                                        blue: 234.0/255.0,
                                                        alpha: 1.0).cgColor }
    
    static var rightGradient: CGColor { return UIColor(red: 0.0/255.0,
                                                       green: 118.0/255.0,
                                                       blue: 255.0/255.0,
                                                       alpha: 1.0).cgColor }
    
    static var gray: UIColor { return UIColor(red: 237.0/255.0,
                                              green: 237.0/255.0,
                                              blue: 237.0/255.0,
                                              alpha: 1.0) }
}
