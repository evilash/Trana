//
//  UIColor+random.swift
//  Treyana
//
//  Created by Matt M Smith on 5/6/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import UIKit

extension UIColor {
    static var randomBackgroundColor: UIColor {
        let backgroundColorArray: [UIColor] = [.systemPink, .systemTeal, .systemYellow, systemOrange, .systemPurple, .systemGreen]
        let randomNumber = Int.random(in: 0..<backgroundColorArray.count)
        let backgroundColor = backgroundColorArray[randomNumber]
        
        return backgroundColor
    }
}
