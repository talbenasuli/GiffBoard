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
        
        private let collectionViewLayout = VerticalCollectionViewLayout()
        private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            .backgroundColor(UIColor.App.white)
            .keyboardDismissMode(.onDrag)
            .allowsSelection(false)
        
        private let viewModel: VerticalCollectionViewModelType
        
        init(viewModel: VerticalCollectionViewModelType) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.register(Giff.My.CollectionCell.self, forCellWithReuseIdentifier: Giff.My.CollectionCell.defaultReuseIdentifier)
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
            make.leading.trailing.bottom.equalToSuperview()
            make.topMargin.equalToSuperview().offset(.big)
        }
    }
    
    func bindViewModel() {
    
        collectionView.rx
            .setDelegate(self)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.output.collectionItems
            .drive(collectionView.rx.items) { collectionView, index, cellType in
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Giff.My.CollectionCell.defaultReuseIdentifier, for: IndexPath(row: index, section: 0)) as! VerticalCollectionCell
                cell.configure(with: cellType)
                return cell
            }.disposed(by: viewModel.disposeBag)
        
        viewModel.output.loading
            .drive(onNext: { [weak self] loading in
                loading ? self?.showLoader() : self?.hideLoader()
            }).disposed(by: viewModel.disposeBag)
    }
}

extension VerticalCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellType = viewModel.item(at: indexPath)
        
        switch cellType {
        case .gif:
            let height = 200
            let width = 130

            let cellWidth = collectionView.frame.width / 2 - self.collectionViewLayout.minimumInteritemSpacing
            let imageRatio = cellWidth / CGFloat(width)
            return CGSize(width: cellWidth, height: CGFloat(height) * CGFloat(imageRatio))
            
        }
    }
}
