//
//  Rx+UIViewController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 09/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base == UIViewController {
    
    var showToast: Binder<String> {
        return Binder(self.base) { view, text in
            base.showToast(message: text, font: UIFont.App.toast.value)
        }
    }
}
