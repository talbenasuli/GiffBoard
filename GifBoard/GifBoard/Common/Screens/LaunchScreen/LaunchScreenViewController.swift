//
//  LaunchScreenViewController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 07/03/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum Launch { }

extension Launch {
    final class ViewController: UIViewController {
        
        private let _onFinished = PublishRelay<Void>()
        lazy var onFinished = _onFinished.asDriver(onErrorDriveWith: .never())
        
        let disposeBag = DisposeBag()
   
        private let background = UIImageView()
            .image(named: "gradien-background")
       
        private let logo = UIImageView()
            .image(named: "logo")
            .alpha(0)
        
        private let duration: TimeInterval = 1.5
     
        init() {
            super.init(nibName: nil, bundle: nil)
            layoutViews()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: false)
            fadeLogoIn()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

private extension Launch.ViewController {
    
    func layoutViews() {
        view.add(background, logo)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logo.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func fadeLogoIn() {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.logo.alpha = 1
        } completion: { [weak self] complete in
            if complete {
                self?._onFinished.accept(())
            }
        }
    }
}
