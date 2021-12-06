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

enum VerticalCollectionCellType {
    case gif(Giff.My.CellViewModel)
}

protocol VerticalCollectionCell: UICollectionViewCell {
    func configure(with cellType: VerticalCollectionCellType)
}

struct VerticalCollectionViewModelInput {
    var navigationPlusTapped = PublishRelay<Int>()
}

struct VerticalCollectionViewModelOutput {
    var navigationPlusTapped: Driver<Int>
    var loading: Driver<Bool>
    var collectionItems: Driver<[VerticalCollectionCellType]>
    var navigationGifyTapped: Driver<Void>
}

protocol VerticalCollectionViewModelType: NavigaitonViewModel {
    var input: VerticalCollectionViewModelInput { get }
    var output: VerticalCollectionViewModelOutput { get }
    
    func item(at index: IndexPath) -> VerticalCollectionCellType
    var disposeBag: DisposeBag { get }
}
