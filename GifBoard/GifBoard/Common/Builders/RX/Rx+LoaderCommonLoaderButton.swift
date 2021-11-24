//
//  Rx+LoaderCommonLoaderButton.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 23/11/2021.
//

import RxSwift
import RxCocoa

extension Reactive where Base == CommonLoaderButton {
    
    var loader: Binder<Bool> {
        return Binder(self.base) { view, loading in
            loading ? view.showLoader() : view.hideLoader()
        }
    }
}
