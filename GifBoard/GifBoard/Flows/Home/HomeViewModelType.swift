//
//  HomeViewModelType.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 10/03/2021.
//

import Foundation

protocol HomeViewModelType {
    
    var title: String { get }
    var searchPlaceHolder: String { get }
    var leftSegmentTitle: String { get }
    var rightSegementTitle: String { get }
    
    func start()
}
