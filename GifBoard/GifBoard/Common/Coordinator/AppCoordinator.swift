//
//  AppCoordinator.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 09/03/2021.
//

import UIKit

enum App { }

extension App {
    
    final class Coordinator: Coordinators.Base {
        
        override func start() {
            showSplash()
        }
    }
}

private extension App.Coordinator {
    
    func showSplash() {
        let vc = Launch.ViewController()
        
        vc.onFinished.drive(onNext: {
            self.showHome()
        }).disposed(by: vc.disposeBag)
        show(vc)
    }
    
    func showHome() {
        guard let presenting = navigationController.viewControllers.first else { return }
        Home.Coordinator(presentationStyle: .present(presenting: presenting)).start()
    }
}
