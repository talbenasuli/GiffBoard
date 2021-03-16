//
//  Coordinator.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 09/03/2021.
//

import UIKit

protocol CoordinatorType: class {
    var navigationController: UINavigationController { get }
    func start()
}

enum Coordinators { }

extension Coordinators {
    
    enum PresentationStyle {
        case present(presenting: UIViewController)
        case push(navigation: UINavigationController)
        case window(UIWindow)
    }
    
    class Base: CoordinatorType {
        
        var presentationStyle: PresentationStyle
        var navigationController = UINavigationController()
        
        private let navigationStartIndex: Int
        
        init(presentationStyle: PresentationStyle) {
            self.presentationStyle = presentationStyle
            
            switch presentationStyle {
            case .present, .window:
                navigationStartIndex = 0
                
            case .push(let navigation):
                navigationStartIndex = navigation.lastViewControllerIndex
            }
        }
        
        func start() { }
        
        func show(_ viewController: UIViewController,
                  animated: Bool = true,
                  modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
            
            let isFirstScreen = navigationStartIndex == 0
            isFirstScreen ? showFirst(viewController, animated: animated, modalPresentationStyle: modalPresentationStyle): navigationController.pushViewController(viewController, animated: animated)
        }
        
        private func showFirst(_ viewController: UIViewController,
                               animated: Bool,
                               modalPresentationStyle: UIModalPresentationStyle) {
            switch presentationStyle {
            case .present(let presenting):
                let nvc = UINavigationController(rootViewController: viewController)
                navigationController = nvc
                navigationController.modalPresentationStyle = modalPresentationStyle
                presenting.present(nvc, animated: animated)
                
            case .push(let navigation):
                navigationController = navigation
                navigationController.pushViewController(viewController, animated: true)
                
            case .window(let window):
                let nvc = UINavigationController(rootViewController: viewController)
                navigationController = nvc
                window.makeKeyAndVisible()
                window.rootViewController = navigationController
            }
        }
    }
}

extension UINavigationController {
    var lastViewControllerIndex: Int {
        return viewControllers.count > 0 ? viewControllers.count - 1 : 0
    }

    func pop(to index: Int, animated: Bool = true) {
        let viewController = viewControllers[index]
        popToViewController(viewController, animated: animated)
    }
}
