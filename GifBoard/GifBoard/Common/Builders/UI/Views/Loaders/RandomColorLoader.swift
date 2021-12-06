//
//  RandomColorLoader.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 23/11/2021.
//

import UIKit

final class RandomColorLoader: UIView, Loader {
    
    func startAnimating() {
        fadeLogoIn()
    }
    
    func stopAnimating() {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .random()
        alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fadeLogoIn() {
        UIView.animate(withDuration: 1.0) {
            self.alpha = 1
        } completion: { complete in
            if complete { self.fadeLogoOut() }
        }

    }
    
    func fadeLogoOut() {
        UIView.animate(withDuration: 1.0) {
            self.alpha = 0
        } completion: { complete in
            if complete { self.fadeLogoIn() }
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
