//
//  HomeRouter.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 16/03/2021.
//

import Foundation
import RxSwift

protocol HomeRouterType {
    func search(body: Giff.Body) -> Single<Giff.Response>
}

extension Home {
    
    final class Router: HomeRouterType {
        
        let giffApi: GifAPIType
        
        init(giffApi: GifAPIType = Giff.API()) {
            self.giffApi = giffApi
        }
        
        func search(body: Giff.Body) -> Single<Giff.Response> {
            return giffApi.search(body: body)
        }
    }
}
