//
//  GifRouter.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 16/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol GifAPIType {
    func search(body: Giff.Body) -> Single<Giff.Response>
}

extension Giff {
    
    final class API: GifAPIType {
        
        let url = "https://api.giphy.com/v1/gifs"
        
        func search(body: Giff.Body) -> Single<Giff.Response> {
            let searchUrl = "\(url)/search"
            return Single.create { single -> Disposable in
                
                let networkManager = Network.Manager()
                let request = Network.Request<Giff.Response, Giff.Body>(path: searchUrl, method: .get)
                    .addBody(body)
                
                networkManager.dispatch(request: request) { result in
                    
                    switch result {
                    case .success(let giffResponse):
                        single(.success(giffResponse))
                        
                    case .failure(let error):
                        single(.error(error))
                    }
                }
                
                return Disposables.create()
            }
        }
    }
}
