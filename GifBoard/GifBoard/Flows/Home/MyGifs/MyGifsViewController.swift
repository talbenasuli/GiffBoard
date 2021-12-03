//
//  MyGifsViewController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 29/11/2021.
//

import UIKit

extension Giff.My {
    
    final class ViewContorller: UIViewController {
        
        private let viewModel: MyGifViewModelType
        
        init(viewModel: MyGifViewModelType) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            navigation(styles: viewModel.navigationStyles)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
