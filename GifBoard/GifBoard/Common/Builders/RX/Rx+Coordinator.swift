//
//  Rx+Coordinator.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 27/06/2021.
//

import RxSwift
import RxCocoa

extension Coordinators.Base: ReactiveCompatible { }

extension Reactive where Base == Coordinators.Base {
    
    var dismissCoordinator: Binder<Void> {
        return Binder(self.base) { _, _ in
            base.dismissCoordinator()
        }
    }
}
