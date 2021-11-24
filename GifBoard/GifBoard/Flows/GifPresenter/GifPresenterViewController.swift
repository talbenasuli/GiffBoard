//
//  GifPresenterViewController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 28/06/2021.
//

import UIKit
import SwiftGifOrigin
import RxSwift

extension Giff {
    
    final class PresenterViewController: UIViewController {
        
        private let viewModel: GifPresenterViewModelType
        
        private let imageView = UIImageView()
        
        private let disposeBag = DisposeBag()
        
        private lazy var bottomButton = CommonLoaderButton(frame: .zero)
            .title(viewModel.input.buttonTitle)
            .font(UIFont.App.header1.value)
            .titleColor(UIColor.App.white)
            .backgroundColor(UIColor.App.turquoise)
        
        
        init(viewModel: GifPresenterViewModelType) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            super.loadView()
            view.backgroundColor = .white
            setupNavigation()
            layoutView()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            bindViewModel()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            imageView.startAnimating()
        }
        
        private func setupNavigation() {
            let undo = UIBarButtonItem(barButtonSystemItem: .undo, target: nil, action: nil)
                .tintColor(.white)

            undo.rx
                .tap
                .bind(to: viewModel.input.undoTapped)
                .disposed(by: disposeBag)
            
            navigation(style: .background(color: .clear),
                       .separator(.clear),
                       .left(buttons: [undo]))
        }
        
        private func layoutView() {
            view.add(imageView, bottomButton)
            
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            bottomButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(.big)
                make.trailing.equalToSuperview().inset(.big)
                make.bottom.equalToSuperview().inset(App.Padding.bottomPadding)
            }
        }
        
        private func bindViewModel() {
            bindImageView()
            bindBottomButton()
        }
        
        private func bindImageView() {
            imageView.animationImages = viewModel.input.images
            imageView.animationDuration = viewModel.input.animationDuration
            imageView.animationRepeatCount = 0
            imageView.image = imageView.animationImages?.first
        }
        
        private func bindBottomButton() {
            
            bottomButton.rx.tap
                .bind(to: viewModel.input.bottomButtonTapped)
                .disposed(by: disposeBag)
            
            viewModel.output.loading
                .drive(bottomButton.rx.loader)
                .disposed(by: disposeBag)
        }
    }
}
