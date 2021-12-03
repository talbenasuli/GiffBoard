//
//  HomeViewModelType.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 10/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelType {
    
    var title: String { get }
    var searchPlaceHolder: String { get }
    var leftSegmentTitle: String { get }
    var rightSegementTitle: String { get }
    
    var searchText: BehaviorRelay<String?> { get }
    var onSearchTappd: PublishRelay<Void> { get }
    var scrollToEnd: PublishRelay<Void> { get }
    var plusTapped: PublishRelay<Void> { get }
    
    var items: Driver<[Home.ViewController.CellType]> { get }
    var showFloatingMassage: Driver<String> { get }
    var loading: Driver<Bool> { get }
    
    var selectedItem: PublishRelay<Home.ViewController.CellType> { get }
    
    func item(at indexPath: IndexPath) -> Home.ViewController.CellType
    func start()
}
