//
//  LottieLoader.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 03/12/2021.
//

import Foundation
import Lottie

final class LottieLoader: UIView, Loader {

    var animationView: AnimationView?
    
    init(animationPath: String) {
        super.init(frame: .zero)
        animationView = .init(name: animationPath)
        
        if let animationView = animationView {
            add(animationView)
            
            animationView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        animationView?.play()
    }
    
    func stopAnimating() {
        animationView?.stop()
    }
}
