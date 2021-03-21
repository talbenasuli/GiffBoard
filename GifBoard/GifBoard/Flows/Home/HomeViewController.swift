//
//  HomeViewController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 10/03/2021.
//

import UIKit
import RxCocoa
import RxSwift

extension Home {
    
    final class ViewController: UIViewController {
        
        private lazy var titleLabel = UILabel()
            .font(UIFont.App.header1.value)
            .text(viewModel.title)
            .textColor(UIColor.App.black)
        
        private lazy var searchBar = UISearchBar()
            .placeholder(viewModel.searchPlaceHolder)
            .setImage(for: .search, state: .normal)
        
        private lazy var segmentedControl = UISegmentedControl()
            .addSegment(withTitle: viewModel.leftSegmentTitle, at: 0, animated: false)
            .addSegment(withTitle: viewModel.rightSegementTitle, at: 1, animated: false)
            .selectSegment(at: 0)
        
        private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            .backgroundColor(UIColor.App.white)
            .delegate(self)
        
        private let viewModel: HomeViewModelType
        private let disposeBag = DisposeBag()
        private let collectionViewLayout = Home.CollectionViewLayout()
        
        init(viewModel: HomeViewModelType = ViewModel()) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
            addConstraints()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.add(titleLabel, searchBar, segmentedControl, collectionView)
            bindViewModel()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            navigation(style: .none)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

private extension Home.ViewController {

    func addConstraints() {
        view.backgroundColor = UIColor.App.white
        
        titleLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(.medium)
            make.leading.equalToSuperview().offset(.medium)
            make.trailing.equalToSuperview().inset(.medium)
        }
        
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(.medium)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.leading.trailing.equalTo(searchBar)
            make.top.equalTo(searchBar.snp.bottom).offset(.medium)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(.small)
            make.trailing.equalToSuperview().inset(.small)
            make.top.equalTo(segmentedControl.snp.bottom).offset(.small)
            make.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        collectionView.register(Home.GiffCell.self)
        viewModel.items
            .drive(collectionView.rx.items) { collectionView, index , data in
                
                switch data {
                case .giff(let data):
                    let cell: Home.GiffCell = collectionView.dequeueReusableCell(forIndexPath: IndexPath(row: index, section: 0))
                    cell.configure(with: data)
                    return cell
                }
            }.disposed(by: disposeBag)
        
        searchBar.rx.text
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        searchBar.rx
            .searchButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.viewModel.onSearchTappd.accept(())
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        viewModel.start()
    }
}

extension Home.ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellType = viewModel.item(at: indexPath)
        
        switch cellType {
        case .giff(let data):
            if let height = Int(data.images?.downsized?.height ?? "0"),
               let width = Int(data.images?.downsized?.width ?? "0"),
               width != 0 && height != 0 {
                let cellWidth = collectionView.frame.width / 3 - self.collectionViewLayout.minimumInteritemSpacing
                let imageRatio = cellWidth / CGFloat(width)
                return CGSize(width: cellWidth, height: CGFloat(height) * CGFloat(imageRatio))
            }
        }
        
        return .zero
    }
}

extension Home.ViewController {
    
    enum CellType {
        case giff(data: Giff.Data)
    }
}
