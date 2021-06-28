//
//  CameraViewController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 13/06/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

extension Camera {
    
    final class ViewController: UIViewController, LoaderContainer {
    
        var loader: Loader = UIActivityIndicatorView(style: .gray)
    
        private let cameraButton = UIButton(frame: .zero)
            .backgroundColor(UIColor.App.turquoise)
            .borderColor(UIColor.App.white)
            .borderWidth(1)
        
        private let viewModel: CameraViewModelType
        private let disposeBag = DisposeBag()
        
        init(viewModel: CameraViewModelType) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            super.loadView()
            addViews()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            cameraButton.alpha = 0
            bindViewModel()
            setupNavigation()
            showLoader()
            view.backgroundColor = .white
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            viewModel.openCamera()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
        }
    }
}

private extension Camera.ViewController {
    
    func setupNavigation() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
            .tintColor(.white)

        cancelButton.rx
            .tap
            .bind(to: viewModel.cancelTapped)
            .disposed(by: disposeBag)
        
        navigation(style: .background(color: .clear),
                   .separator(.clear),
                   .right(buttons: [cancelButton]))
    }
    
    func bindViewModel() {
        
        viewModel.cameraLayer
            .drive(onNext: { [weak self] layer in
                guard let self = self else { return }
                layer.frame = self.view.bounds
                self.view.layer.addSublayer(layer)
                self.view.bringSubviewToFront(self.cameraButton)
                self.cameraButton.fadeIn(duration: 0.7)
            }).disposed(by: disposeBag)
        
        let longGestureBegin = view.rx
            .longPressGesture()
            .when(.began)
            .map({ _ in })
            .share()
        
        let longGestureFinished = view.rx
            .longPressGesture()
            .when(.ended)
            .map({ _ in })
            .share()
        
       longGestureBegin
            .bind(to: viewModel.cameraLongPressBagan)
            .disposed(by: disposeBag)
        
        longGestureBegin
            .map({ return (ratio: 1.3, duration: 0.3) })
            .bind(to: (cameraButton as UIView).rx.scaleAnimation )
            .disposed(by: disposeBag)
        
       longGestureFinished
            .bind(to: viewModel.cameraLongPressFinished)
            .disposed(by: disposeBag)
        
        longGestureFinished
            .map({ return (ratio: 1.0, duration: 0.3) })
            .bind(to: (cameraButton as UIView).rx.scaleAnimation )
            .disposed(by: disposeBag)
        
        viewModel.enableTouch
            .map({ !$0 })
            .drive(cameraButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func addViews() {

        view.add(cameraButton)
        
        cameraButton.snp.makeConstraints { make in
            make.height.width.equalTo(App.Pedding.huge.rawValue * 2)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(App.Pedding.huge.rawValue * 2)
        }
    }
}
