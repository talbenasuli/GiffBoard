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
    func getMyGif(index: Int) -> Single<([UIImage], Camera.GifContent)>
}

extension Giff.My.Repo {
    
    final class Local: MyGifLocalRepo {
        
        func getMyGif(index: Int) -> Single<([UIImage], Camera.GifContent)> {
            
            return Single.create { single -> Disposable in
                
                DispatchQueue.global(qos: .background).async {
                    
                    do {
                        let gifs = try Disk.retrieve("GifIndex\(index)", from: .documents, as: [UIImage].self)
                        let content = try Disk.retrieve("GifIndex\(index)\\Content", from: .documents, as: Camera.GifContent.self)
                        single(.success((gifs,content)))
                    } catch let error{
                        print("fail to save gif - \(error)")
                        single(.error(error))
                    }
                }
                
                return Disposables.create()
            }
        }
    }
}
