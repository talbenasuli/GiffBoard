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
                guard let viewModel = viewModel, !images.isEmpty else { return }
                self.showGif(with: viewModel, and: images)
            }).disposed(by: viewModel.disposeBag)
        
        let viewController = Camera.ViewController(viewModel: viewModel)
        show(viewController)
    }
    
    func showGif(with cameraViewModel: Camera.ViewModel, and images: [UIImage]) {
        let viewModel = Giff.PresenterViewModel(images: images, animationDuration: cameraViewModel.output.duration)

        cameraViewModel.output.gifFinished
            .asObservable()
            .bind(to: viewModel.input.gifFinished)
            .disposed(by: cameraViewModel.disposeBag)
        
        viewModel.output.undoTapped
            .drive((self as Coordinators.Base).rx.dismissCoordinator)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.output.done
            .drive((self as Coordinators.Base).rx.dismissCoordinator)
            .disposed(by: viewModel.disposeBag)
        
        let viewController = Giff.PresenterViewController(viewModel: viewModel)
        show(viewController)
    }
}

