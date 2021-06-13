//
//  CameraViewController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 13/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

extension Camera {
    
    final class ViewController: UIViewController {
        
        private let viewModel: CameraViewModelType
        private let disposeBag = DisposeBag()
        
        init(viewModel: CameraViewModelType) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            bindViewModel()
            navigation(style: .none)
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            viewModel.openCamera()
        }
    }
}

private extension Camera.ViewController {
    
    func bindViewModel() {
        
        viewModel.cameraLayer
            .drive(onNext: { [weak self] layer in
                guard let self = self else { return }
                layer.frame = self.view.bounds
                self.view.layer.addSublayer(layer)
            }).disposed(by: disposeBag)
    }
}
