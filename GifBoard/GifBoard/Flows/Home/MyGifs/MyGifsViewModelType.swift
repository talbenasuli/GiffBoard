//
//  MyGifsViewModelType.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 29/11/2021.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

extension Giff.My {
    
    struct ViewModelInput {
        var navigationPlusTapped = PublishRelay<Void>()
    }
    
    struct ViewModelOutput {
        var navigationPlusTapped: Driver<Void>
    }
}

protocol MyGifViewModelType: NavigaitonViewModel {
    var input: Giff.My.ViewModelInput { get }
    var output: Giff.My.ViewModelOutput { get }
}
