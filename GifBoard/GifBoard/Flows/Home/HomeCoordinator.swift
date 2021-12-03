//
//  HomeCoordinator.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 10/03/2021.
//

import UIKit
import GiphyUISDK

enum Home { }

extension Home {
    final class Coordinator: Coordinators.Base {
        
        private let tabBar = UITabBarController()
        
        override func start() {
            setupTabBar()
        }
    }
}

private extension Home.Coordinator {
    
    func setupTabBar() {
        let coordinators: [TabCoordinator] = [Giff.My.Coordinator()]
        tabBar.viewControllers = coordinators.map { $0.tabViewController }
        show(tabBar, animated: false)

//        let viewModel = Home.ViewModel()
//
//        viewModel.plusTapped.bind {
////            self.showCreateGiff()
////            let viewController = GiphyViewController()
////            viewController.theme = GPHTheme(type: .light)
////            viewController.shouldLocalizeSearch = true
////            viewController.delegate = self
////
////            GiphyViewController.trayHeightMultiplier = 0.9
////            self.navigationController.present(viewController, animated: true)
//        }.disposed(by: viewModel.disposeBag)
//
//        let vc = Home.ViewController(viewModel: viewModel)
//
    }
    
    func showCreateGiff() {
        guard let presenting = navigationController.last else { return } // TBA NTD add error handling
        CreateGiff.Coordinator(presentationStyle: .present(presenting: presenting)).start()
    }
}

extension Home.Coordinator: GiphyDelegate {
    
    func didDismiss(controller: GiphyViewController?) {
        
    }
    
    func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
        let gifURL = media.url(rendition: .downsizedMedium, fileType: .gif)
        let url = URL(string: gifURL!)
        
        do {
            let data = try Data(contentsOf: url!)
            UIPasteboard.general.setData(data, forPasteboardType: "com.compuserve.gif")
        } catch {
            print("The file could not be copied")
        }
    }
}
