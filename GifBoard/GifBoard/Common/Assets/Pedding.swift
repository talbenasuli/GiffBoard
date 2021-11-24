//
//  Padding.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 14/03/2021.
//

import Foundation

extension App {
    
    enum Padding: Int {
        case tiny = 8
        case small = 16
        case medium = 24
        case big = 32
        case huge = 40
        
        
        // constants
        static var bottomPadding: Int {
            return App.Padding.huge.rawValue * 2
        }
        
    }
}
