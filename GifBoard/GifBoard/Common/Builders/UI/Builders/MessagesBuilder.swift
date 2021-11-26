//
//  MessagesBuilder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 09/06/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let containter = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let toastLabel = UILabel(frame: .zero)
        
        containter.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        containter.alpha = 1.0
        containter.layer.cornerRadius = 10;
        
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message

        containter.add(toastLabel)
        toastLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        self.view.addSubview(containter)
        containter.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            containter.alpha = 0.0
        }, completion: {(isCompleted) in
            containter.removeFromSuperview()
        })
    }
}
