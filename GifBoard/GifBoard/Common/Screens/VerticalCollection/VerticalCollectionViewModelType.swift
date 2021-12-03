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

    
struct VerticalCollectionViewModelInput {
    var navigationPlusTapped = PublishRelay<Void>()
}

struct VerticalCollectionViewModelOutput {
    var navigationPlusTapped: Driver<Void>
    var loading: Driver<Bool>
}

protocol VerticalCollectionViewModelType: NavigaitonViewModel {
    var input: VerticalCollectionViewModelInput { get }
    var output: VerticalCollectionViewModelOutput { get }
    var disposeBag: DisposeBag { get }
}
