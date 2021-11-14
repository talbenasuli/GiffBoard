//
//  CreateGiffCoordinator.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 13/06/2021.
//

import Foundation
import UIKit

enum CreateGiff { }

extension CreateGiff {
    
    final class Coordinator: Coordinators.Base {
        
        override func start() {
            showCamera()
        }
    }
}

private extension CreateGiff.Coordinator {
    
    func showCamera() {
        let viewModel = Camera.ViewModel()
        
        viewModel.output.cancelTapped
            .drive((self as Coordinators.Base).rx.dismissCoordinator)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.output.images
            .drive(onNext: { [weak viewModel] images in
                guard let viewModel = viewModel else { return }
                self.showGif(with: images, duration: viewModel.output.duration)
            }).disposed(by: viewModel.disposeBag)
        
        let viewController = Camera.ViewController(viewModel: viewModel)
        show(viewController)
    }
    
    func showGif(with images: [UIImage], duration: TimeInterval) {
        let viewController = Giff.PresenterViewController(with: images, duration: duration)
        show(viewController)
    }
}

