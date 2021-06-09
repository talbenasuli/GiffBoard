//
//  LoaderContainer.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 09/06/2021.
//

import UIKit

protocol LoaderContainer {
    func showLoader()
    func hideLoader()
    func addLoader()
    var loader: Loader { get }
}

protocol Loader: UIView {
    func startAnimating()
    func stopAnimating()
}

extension UIActivityIndicatorView: Loader { }


extension LoaderContainer where Self: UIViewController {
    
    func addLoader() {
        view.addSubview(loader)
        
        loader.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.center.equalToSuperview()
        }
    }
    
    func showLoader() {
        let loaderExists = view.subviews.first { $0 is Loader } != nil
        
        if !loaderExists {
            addLoader()
        }
        loader.isHidden = false
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.isHidden = true
        loader.stopAnimating()
    }
}
