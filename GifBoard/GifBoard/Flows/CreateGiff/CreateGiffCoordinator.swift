//
//  CreateGiffCoordinator.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 13/06/2021.
//

import Foundation

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
        let viewController = Camera.ViewController(viewModel: viewModel)
        show(viewController)
    }
}

