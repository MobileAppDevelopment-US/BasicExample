//
//  UIView+Ext.swift
//  BasicExample
//
//  Created by Serik on 05.02.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

// Example - use custo, view

//let view: OverviewRecipeView = .fromNib()
//let view: OverviewRecipeView = .fromNib()
//view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height)
//view.setOverviewRecipe()
//self.view.addSubview(view)
