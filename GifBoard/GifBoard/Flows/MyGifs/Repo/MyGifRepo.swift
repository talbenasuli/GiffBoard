//
//  MyGifRepo.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 03/12/2021.
//

import Foundation
import RxSwift

protocol MyGifRepo {
    func getMyGif(index: Int) -> Single<([UIImage], Camera.GifContent)>
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
        
        func getMyGif(index: Int) -> Single<([UIImage], Camera.GifContent)> {
            return localRepo.getMyGif(index: index)
        }
    }
}
