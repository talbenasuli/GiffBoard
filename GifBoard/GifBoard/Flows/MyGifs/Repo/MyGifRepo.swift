//
//  MyGifRepo.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 03/12/2021.
//

import Foundation
import RxSwift

protocol MyGifRepo {
    func getMyGifs(page: Int) -> Single<[Data]>
}

extension Giff.My {
    enum Repo { }
}

extension Giff.My.Repo {
    
    final class Base: MyGifRepo {
        
        private let localRepo: MyGifLocalRepo
        
        init(localRepo: MyGifLocalRepo) {
            self.localRepo = localRepo
        }
        
        func getMyGifs(page: Int) -> Single<[Data]> {
            return localRepo.getMyGifs(page: page)
        }
    }
}
