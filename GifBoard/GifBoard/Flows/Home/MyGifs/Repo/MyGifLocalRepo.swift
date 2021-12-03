//
//  MyGifLocalRepo.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 03/12/2021.
//

import Foundation
import RxSwift
import Disk

protocol MyGifLocalRepo {
    
    func getMyGifs(page: Int) -> Single<[Data]>
}

extension Giff.My.Repo {
    
    final class Local: MyGifLocalRepo {
        
        func getMyGifs(page: Int) -> Single<[Data]> {
            
            return Single.create { single -> Disposable in
                
                DispatchQueue.global(qos: .background).async {
                    
                    do {
                        let gifs = try Disk.retrieve("mineGif.json", from: .documents, as: [Data].self)
                        single(.success(gifs))
                    } catch let error{
                        print("fail to save gif")
                        single(.error(error))
                    }
                }
                
                return Disposables.create()
            }
        }
    }
}
