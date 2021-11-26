//
//  Fonts.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 10/03/2021.
//

import UIKit

extension UIFont {
    enum App {
        case header1
        case toast
        
        var value: UIFont {
            switch self {
            case .header1: return UIFont.boldSystemFont(ofSize: 50)
            case .toast: return UIFont.italicSystemFont(ofSize: 60)
            }
        }
    }
}
