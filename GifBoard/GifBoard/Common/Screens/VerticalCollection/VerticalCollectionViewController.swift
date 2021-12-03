//
//  MyGifsViewController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 29/11/2021.
//

import UIKit

    final class VerticalCollectionViewController: UIViewController, LoaderContainer {
        
        var loader: Loader = LottieLoader(animationPath: "gifLoader")
            .contentMode(.scaleAspectFit)
            .loopMode(.loop)
        
        private let collectionViewLayout = Home.CollectionViewLayout()
        private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            .backgroundColor(UIColor.App.white)
            .keyboardDismissMode(.onDrag)
            .delegate(self)
        
        private let viewModel: VerticalCollectionViewModelType
        
        init(viewModel: VerticalCollectionViewModelType) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            layoutView()
            bindViewModel()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            navigation(styles: viewModel.navigationStyles)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func addLoader() {
            view.addSubview(loader)
            
            loader.snp.makeConstraints { make in
                make.width.height.equalTo(300)
                make.center.equalToSuperview()
            }
        }
    }

private extension VerticalCollectionViewController {
    
    func layoutView() {
        view.add(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        
        collectionView.register(Home.GiffCell.self)
        
        viewModel.output.loading
            .drive(onNext: { [weak self] loading in
                loading ? self?.showLoader() : self?.hideLoader()
            }).disposed(by: viewModel.disposeBag)
    }
}

extension VerticalCollectionViewController: UICollectionViewDelegate {
    
}
