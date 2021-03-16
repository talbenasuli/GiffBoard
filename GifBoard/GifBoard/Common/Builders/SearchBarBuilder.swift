//
//  SearchBarBuilder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 11/03/2021.
//

import UIKit

extension UISearchBar {
    
    func barStyle(_ barStyle: UIBarStyle) -> Self {
        self.barStyle = barStyle
        return self
    }
    
    func placeholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    func delegate(_ delegate: UISearchBarDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    func searchBarStyle(_ searchBarStyle: Style) -> Self {
        self.searchBarStyle = searchBarStyle
        return self
    }
    
    func setImage(for icon: Icon, state: UIControl.State) -> Self {
        self.image(for: icon, state: state)
        return self
    }
}
