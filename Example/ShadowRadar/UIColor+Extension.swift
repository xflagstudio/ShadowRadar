//
//  UIColor+Extension.swift
//  ShadowRadar_Example
//
//  Created by Meng Li on 2019/02/21.
//  Copyright © 2019 XFLAG. All rights reserved.
//

import UIKit

extension UIColor {
    
    open class var random: UIColor {
        return UIColor(red: CGFloat.random(in: 0...1),
                       green: CGFloat.random(in: 0...1),
                       blue: CGFloat.random(in: 0...1),
                       alpha: 1.0)
    }
    
}
