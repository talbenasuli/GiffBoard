//
//  AppDelegate.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 07/03/2021.
//

import UIKit
import GiphyUISDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: App.Coordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window =  UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        Giphy.configure(apiKey: "TbalhqAYtccJ8gS2UgBy4D2CrfBlMrQ0")
        self.appCoordinator = App.Coordinator(window: window)
        appCoordinator.start()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: .NSExtensionHostDidBecomeActive, object: nil)
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
