//
//  TapGestureRecognizer.swift
//  BasicExample
//
//  Created by Serik on 29.01.2020.
//  Copyright © 2020 Serik_Klement. All rights reserved.
//

import UIKit

// срабатывает перед тапом на любые вью с типом TapGestureRecognizer удобно делать вью выделение при тапе

class TapGestureRecognizer: UITapGestureRecognizer {
    
    var highlightOnTouch = true
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        
        if highlightOnTouch {
            let bgcolor = view?.backgroundColor
            UIView.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction, .curveLinear], animations: {
                self.view?.backgroundColor = Design.selectedColor
            }) { (_) in
                UIView.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction, .curveLinear], animations: {
                    self.view?.backgroundColor = bgcolor
                })
            }
        }
    }
    
}
