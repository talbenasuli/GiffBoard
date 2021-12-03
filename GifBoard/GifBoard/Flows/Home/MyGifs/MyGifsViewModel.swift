//
//  MyGifsViewModel.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 29/11/2021.
//

import Foundation
import UIKit
import RxSwift

extension Giff.My {
    
    final class ViewModel: MyGifViewModelType {
        
        let disposeBag = DisposeBag()
        
        var navigationStyles: [BarStyle] {
            let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
                .tintColor(.black)
            
            rightButton.rx.tap
                .bind(to: input.navigationPlusTapped)
                .disposed(by: disposeBag)
           
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 117, height: 33))
            imageView.image = UIImage(named: "navigation_logo")
            let logo = UIBarButtonItem.init(customView: imageView)
            
            return [.background(color: .clear),
                        .separator(.clear),
                        .right(buttons: [rightButton]),
                        .left(buttons: [logo])]
        }
        
        var input = Giff.My.ViewModelInput()
        var output: Giff.My.ViewModelOutput
        
        init() {
            output = Giff.My.ViewModelOutput(navigationPlusTapped: input.navigationPlusTapped.asDriver(onErrorDriveWith: .never()))
        }
    }
}
