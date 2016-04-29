//
//  AppDelegate.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit
import ReSwift

var store = Store<AppState>(
    reducer: AppReducer(),
    state: nil
)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, StoreSubscriber {

    var window: UIWindow?
    var loading :LoadingView?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.setupAppearance()

        self.loading = LoadingView.getView("LoadingView") as? LoadingView

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let vc = SearchStartViewController(nibName: "SearchStartViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()

        if let loading = self.loading {
            loading.translatesAutoresizingMaskIntoConstraints = false
            self.window?.addSubview(loading)

            self.window?.addConstraint(NSLayoutConstraint(
                item: self.window!,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: loading,
                attribute: .Top,
                multiplier: 1.0,
                constant: 0.0))

            self.window?.addConstraint(NSLayoutConstraint(
                item: self.window!,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: loading,
                attribute: .Left,
                multiplier: 1.0,
                constant: 0.0))

            self.window?.addConstraint(NSLayoutConstraint(
                item: self.window!,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: loading,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: 0.0))

            self.window?.addConstraint(NSLayoutConstraint(
                item: self.window!,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: loading,
                attribute: .Right,
                multiplier: 1.0,
                constant: 0.0))

            loading.layoutIfNeeded()
        }

        store.subscribe(self) { (state :AppState) -> LoadingState in
            return state.loadingState
        }

        store.dispatch(LoadingHideAction())


        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - ReSwift

    func newState(state: LoadingState) {

        self.loading?.setType(state.type)
        self.loading?.hidden = !state.isLoading
//        self.loading?.touchable = state.toucheable

        if state.type == .StatusBar {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = state.isLoading
        }
    }

    // MARK: - private

    private func setupAppearance() {
//        UINavigationBar.appearance().backgroundColor = UIColor.mainColor()
        UINavigationBar.appearance().tintColor = UIColor.mainColor()
    }
}

