//
//  LottieAnimationViewBuilder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 03/12/2021.
//

import UIKit
import Lottie

extension LottieLoader {
    
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        animationView?.contentMode = contentMode
        return self
    }
    
    func loopMode(_ loopMode: LottieLoopMode) -> Self {
        animationView?.loopMode = loopMode
        return self
    }
    
    func animationSpeed(_ speed: CGFloat) -> Self {
        animationView?.animationSpeed = speed
        return self
    }
}
