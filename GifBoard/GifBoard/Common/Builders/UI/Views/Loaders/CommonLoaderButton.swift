//
//  CommonLoaderButton.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 23/11/2021.
//

import UIKit

final class CommonLoaderButton: UIButton, LoaderContainer {
    var loader: Loader = UIActivityIndicatorView(style: .whiteLarge)
}
