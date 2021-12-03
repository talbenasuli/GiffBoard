//
//  MyGifsCoordinator.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 29/11/2021.
//

import UIKit

extension Giff.My {
    
    final class Coordinator: TabCoordinator {
        
        var tabViewController: UIViewController
        
        init() {
            let viewModel = Giff.My.ViewModel()
                        
            let vc = Giff.My.ViewContorller(viewModel: viewModel)
            let nvc = UINavigationController(rootViewController: vc)
            
            vc.tabBarItem = UITabBarItem(title: "MY GIFS",
                                           image: UIImage(named: "gif"),
                                           selectedImage: UIImage(named: "gif_selected"))
            tabViewController = nvc
            
            viewModel.output.navigationPlusTapped
                .drive(onNext: {
                    self.showCamera()
                }).disposed(by: viewModel.disposeBag)
        }
    }
}

private extension Giff.My.Coordinator {

    func showCamera() {
        CreateGiff.Coordinator(presentationStyle: .present(presenting: tabViewController)).start()
    }
}
