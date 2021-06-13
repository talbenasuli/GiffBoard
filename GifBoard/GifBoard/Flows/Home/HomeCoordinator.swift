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
            showHome()
        }
    }
}

private extension Home.Coordinator {
    
    func showHome() {
        navigationController.viewControllers.removeAll()
        let viewModel = Home.ViewModel()
        
        viewModel.plusTapped.bind {
            self.showCreateGiff()
        }.disposed(by: viewModel.disposeBag)
        
        let vc = Home.ViewController(viewModel: viewModel)
        show(vc, animated: false)
    }
    
    func showCreateGiff() {
        guard let presenting = navigationController.last else { return } // TBA NTD add error handling
        CreateGiff.Coordinator(presentationStyle: .present(presenting: presenting)).start()
    }
}
