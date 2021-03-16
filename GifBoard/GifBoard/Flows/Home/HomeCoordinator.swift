//
//  HomeCoordinator.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 10/03/2021.
//

import UIKit

enum Home { }

extension Home {
    
    final class Coordinator: Coordinators.Base {
        
        override func start() {
            navigationController.viewControllers.removeAll()
            let viewModel = ViewModel()
            
            viewModel.strong = self
            
            let vc = ViewController(viewModel: viewModel)
            show(vc, animated: false)
        }
    }
}
