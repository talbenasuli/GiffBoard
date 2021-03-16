//
//  HomeViewController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 10/03/2021.
//

import UIKit

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
        
        private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
            .backgroundColor(UIColor.App.white)
        
        private let viewModel: HomeViewModelType
        
        init(viewModel: HomeViewModelType = ViewModel()) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
            addConstraints()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.add(titleLabel, searchBar, segmentedControl, collectionView)
            viewModel.start()
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
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom).offset(.small)
            make.bottom.equalToSuperview()
        }
    }
}
