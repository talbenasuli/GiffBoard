//
//  Rx+Animations.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 27/06/2021.
//

import Foundation

import RxSwift
import RxCocoa

extension Reactive where Base == UIView {
    
    var scaleAnimation: Binder<(CGFloat, TimeInterval)> {
        return Binder(self.base) { _, params in
            base.scale(sizeRatio: params.0, duration: params.1)
        }
    }
}
