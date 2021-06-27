//
//  Rx+UINavigation.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 27/06/2021.
//

import RxSwift
import RxCocoa

extension Reactive where Base == UINavigationController {
    
    var pop: Binder<Void> {
        return Binder(self.base) { _, _ in
            base.popViewController(animated: true)
        }
    }
}
