//
//  HomeRepo.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 16/03/2021.
//

import Foundation
import RxSwift

protocol HomeRepoType {
    func search(body: Giff.Body) -> Single<Giff.Response>
}

extension Home {
    
    final class Repo: HomeRepoType {
        
        let homeRouter: HomeRouterType
        
        init(homeRouter: HomeRouterType = Home.Router()) {
            self.homeRouter = homeRouter
        }
        
        func search(body: Giff.Body) -> Single<Giff.Response> {
            return homeRouter.search(body: body)
        }
    }
}
