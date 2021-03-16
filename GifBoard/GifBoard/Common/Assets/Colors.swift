//
//  Colors.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 11/03/2021.
//

import UIKit

extension UIColor {
    enum App { }
}

extension UIColor.App {
    static var black: UIColor {
        return UIColor(red: 0.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
    
    static var turquoise: UIColor {
        return UIColor(hex: "#55769B")!
    }
    
    static var white: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
}
