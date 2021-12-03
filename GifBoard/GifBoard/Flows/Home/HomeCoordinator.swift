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
    }
}

//Show gify
////            let viewController = GiphyViewController()
////            viewController.theme = GPHTheme(type: .light)
////            viewController.shouldLocalizeSearch = true
////            viewController.delegate = self
////
////            GiphyViewController.trayHeightMultiplier = 0.9
////            self.navigationController.present(viewController, animated: true)
//extension Home.Coordinator: GiphyDelegate {
//
//    func didDismiss(controller: GiphyViewController?) {
//
//    }
//
//    func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
//        let gifURL = media.url(rendition: .downsizedMedium, fileType: .gif)
//        let url = URL(string: gifURL!)
//
//        do {
//            let data = try Data(contentsOf: url!)
//            UIPasteboard.general.setData(data, forPasteboardType: "com.compuserve.gif")
//        } catch {
//            print("The file could not be copied")
//        }
//    }
//}
