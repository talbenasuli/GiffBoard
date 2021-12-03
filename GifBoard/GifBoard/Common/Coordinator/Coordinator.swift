//
//  Coordinator.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 09/03/2021.
//

import UIKit

protocol CoordinatorType: AnyObject {
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
        
        private var didShowFirst: Bool = false
        
        init(presentationStyle: PresentationStyle) {
            self.presentationStyle = presentationStyle
        }
        
        func start() { }
        
        func show(_ viewController: UIViewController,
                  animated: Bool = true,
                  modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
            
            if !didShowFirst {
                showFirst(viewController, animated: animated, modalPresentationStyle: modalPresentationStyle)
            } else {
                navigationController.pushViewController(viewController, animated: animated)
            }
        }
        
        func dismissCoordinator(animated: Bool = true, completion: (() -> Void)? = nil) {
            
            switch presentationStyle {
            case .present:
                navigationController.dismiss(animated: animated, completion: completion)
            case .push:
                navigationController.popToRootViewController(animated: animated)
                completion?()
            case .window:
                break
            }
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
                window.makeKeyAndVisible()
                window.rootViewController = viewController
            }
            
            didShowFirst = true
        }
    }
}
