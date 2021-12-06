//
//  MyGifsCoordinator.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 29/11/2021.
//

import UIKit
import GiphyUISDK

extension Giff.My {
    
    final class Coordinator: TabCoordinator {
        
        var tabViewController: UIViewController
        
        init() {
            let repo = Giff.My.Repo.Base(localRepo: Giff.My.Repo.Local())
            let viewModel = Giff.My.ViewModel(repo: repo)
                        
            let vc = VerticalCollectionViewController(viewModel: viewModel)
            let nvc = UINavigationController(rootViewController: vc)
            
            vc.tabBarItem = UITabBarItem(title: "MY GIFS",
                                           image: UIImage(named: "gif"),
                                           selectedImage: UIImage(named: "gif_selected"))
            tabViewController = nvc
            
            viewModel.output.navigationPlusTapped
                .drive(onNext: { numberOfItems in
                    self.showCamera(with: numberOfItems)
                }).disposed(by: viewModel.disposeBag)
            
            viewModel.output.navigationGifyTapped
                .drive(onNext: {
                    self.showGify()
                }).disposed(by: viewModel.disposeBag)
        }
    }
}

private extension Giff.My.Coordinator {

    func showCamera(with numberOfItems: Int) {
        CreateGiff.Coordinator(presentationStyle: .present(presenting: tabViewController), numberOfItems: numberOfItems).start()
    }
    
    func showGify() {
        let viewController = GiphyViewController()
        viewController.theme = GPHTheme(type: .light)
        viewController.shouldLocalizeSearch = true
        GiphyViewController.trayHeightMultiplier = 0.9
//        viewController.delegate = self
        tabViewController.present(viewController, animated: true)
    }
    
    

    ////
    ////
    //extension Home.Coordinator: GiphyDelegate {
    //
    //    func didDismiss(controller: GiphyViewController?) {
    //
    //    }
    //
    //    func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
    //        let gifURL = media.url(rendition: .downsizedMedium, fileType: .gif)
    //        let url = URL(string: gifURL!)
    //
    //        do {
    //            let data = try Data(contentsOf: url!)
    //            UIPasteboard.general.setData(data, forPasteboardType: "com.compuserve.gif")
    //        } catch {
    //            print("The file could not be copied")
    //        }
    //    }
    //}

}
