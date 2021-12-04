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
