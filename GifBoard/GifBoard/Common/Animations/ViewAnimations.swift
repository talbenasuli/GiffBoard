//
//  ViewAnimations.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 27/06/2021.
//

import UIKit

extension UIView {
    
    func fadeIn(duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.alpha = 1
        }
    }
    
    func fadeOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.alpha = 0
        }
    }
    
    func scale(sizeRatio: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: sizeRatio, y: sizeRatio)
        }
    }
}
