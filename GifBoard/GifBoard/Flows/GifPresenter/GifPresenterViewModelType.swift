//
//  GifPresenterViewModel.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 15/11/2021.
//

import UIKit
import RxRelay
import RxCocoa

struct GifPresenterViewModelInput {
    var images: [UIImage]
    var animationDuration: TimeInterval
    var buttonTitle: String
    
    var bottomButtonTapped: PublishRelay<Void>
    var gifFinished: PublishRelay<Void>
    var undoTapped: PublishRelay<Void>
}

struct GifPresenterViewModelOutput {
    var loading: Driver<Bool>
    var undoTapped: Driver<Void>
}

protocol GifPresenterViewModelType {
    var input: GifPresenterViewModelInput { get }
    var output: GifPresenterViewModelOutput { get }
}
