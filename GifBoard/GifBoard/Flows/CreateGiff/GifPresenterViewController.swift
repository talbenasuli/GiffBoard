//
//  GifPresenterViewController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 28/06/2021.
//

import UIKit
import SwiftGifOrigin

extension Giff {
    
    final class PresenterViewController: UIViewController {
        
        let imageView = UIImageView()
        
        private let images: [UIImage]
        private let duration: TimeInterval
        
        init(with images: [UIImage], duration: TimeInterval) {
            self.images = images
            self.duration = duration
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            super.loadView()
            view.backgroundColor = .white
            view.add(imageView)
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            imageView.animationImages = images
            imageView.animationDuration = duration
            imageView.animationRepeatCount = 0
            imageView.image = imageView.animationImages?.first
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            imageView.startAnimating()
        }
    }
}
