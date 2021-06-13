//
//  NavigationBuilder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 10/03/2021.
//

import UIKit

enum BarStyle {
    case title(String, UIColor, UIFont)
    case separator(UIColor)
    case background(color: UIColor)
    case left(buttons: [UIBarButtonItem])
    case right(buttons: [UIBarButtonItem])
    case titleView(view: UIView)
    case none
}

extension UIViewController {
    func navigation(style: BarStyle...) {
        self.navigationItem.hidesBackButton = true
        
        for option in style {
            
            switch option {
            
            case .title(let title, let color, let font):
                self.navigationItem.titleView =  UILabel()
                    .font(font)
                    .textColor(color)
                    .text(title)
                
            case .separator(let color):
                self.navigationController?.navigationBar.shadowImage = color.image()

            case .background(color: let color):
                self.navigationController?.navigationBar.setBackgroundImage(color.image(), for: .default)

            case .left(let buttons):
                self.navigationItem.setLeftBarButtonItems(buttons, animated: true)

            case .right(let buttons):
                self.navigationItem.setRightBarButtonItems(buttons, animated: true)

            case .titleView(let view):
                self.navigationItem.titleView = view
                
            case .none:
                navigationController?.setNavigationBarHidden(true, animated: false)

            }
        }
    }
}

extension UINavigationController {
    
    var last: UIViewController? {
        return viewControllers.last
    }
}
