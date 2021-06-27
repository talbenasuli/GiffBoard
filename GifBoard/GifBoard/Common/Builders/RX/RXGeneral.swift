//
//  RXGeneral.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 15/06/2021.
//

import RxSwift
import RxCocoa

func makeObservable(from function: @escaping (AnyObserver<Void>) -> Void) -> Observable<Void> {
    return Observable.create { (observer) -> Disposable in
        function(observer)
        return Disposables.create()
    }
}
