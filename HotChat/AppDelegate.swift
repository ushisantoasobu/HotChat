//
//  AppDelegate.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

var store = Store<AppState>(
    reducer: AppReducer(),
    state: nil
)



// TODO : どこか別のファイルに独立させたい
class RootRoutable: Routable {

    var routable: Routable

    init(routable: Routable) {
        self.routable = routable
    }

    internal func changeRouteSegment(fromSegment: RouteElementIdentifier,
                                   to: RouteElementIdentifier,
                                   animated: Bool,
                                   completionHandler: RoutingCompletionHandler) -> Routable {

        print("RootRoutable - changeRouteSegment")
        print(to)

        abort()
    }

    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier,
                          animated: Bool,
                          completionHandler: RoutingCompletionHandler) -> Routable {
        completionHandler()

        print("RootRoutable - pushRouteSegment")
        print(routeElementIdentifier)

        return routable
    }

    func popRouteSegment(routeElementIdentifier: RouteElementIdentifier,
                         animated: Bool,
                         completionHandler: RoutingCompletionHandler) {
        completionHandler()

        print("RootRoutable - popRouteSegment")
        print(routeElementIdentifier)
    }
}

extension UINavigationController: Routable {

    public func changeRouteSegment(fromSegment: RouteElementIdentifier,
                                   to: RouteElementIdentifier,
                                   animated: Bool,
                                   completionHandler: RoutingCompletionHandler) -> Routable {

        print("UINavigationController - changeRouteSegment")
        print(to)

        if (to == AccountEditViewController.identifier) {
            completionHandler()
            let vc = AccountEditViewController()
            let nav = UINavigationController(rootViewController: vc)
            return nav
        } else if (to == EventCreateViewController.identifier) {
            completionHandler()
            let vc = EventCreateViewController() as Routable
            return vc
        }

        abort()
    }

    public func pushRouteSegment(
        routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: RoutingCompletionHandler) -> Routable {

        print("UINavigationController - pushRouteSegment")
        print(routeElementIdentifier)

        if (routeElementIdentifier == AccountEditViewController.identifier) {
            completionHandler()
            let vc = AccountEditViewController()
            let nav = UINavigationController(rootViewController: vc)
            presentViewController(nav, animated: true, completion: nil)
            return nav
        } else if (routeElementIdentifier == EventCreateViewController.identifier) {
            completionHandler()
            pushViewController(EventCreateViewController(), animated: true)
            return self
        } else if (routeElementIdentifier == TextInputViewController.identifier) {
            completionHandler()
            let vc = TextInputViewController()
            vc.textSetDone = {(text :String) in
                store.dispatch(SetRouteAction([
                    AppDelegate.rootIdentifier,
                    EventCreateViewController.identifier
                    ]))
            }
            pushViewController(vc, animated: true)
            return self
        } else if (routeElementIdentifier == DateSettingViewController.identifier) {

            completionHandler()
            let vc = DateSettingViewController()
            vc.initialDate = store.state.eventCreateState.date
            vc.dateSetDone = {(date :NSDate) in
                store.dispatch(SetRouteAction([
                    AppDelegate.rootIdentifier,
                    EventCreateViewController.identifier
                    ]))
            }
            pushViewController(vc, animated: true)
            return self

        } else if (routeElementIdentifier == EventListTableViewController.identifier) {
            completionHandler()
            pushViewController(EventListTableViewController(), animated: true)
            return self
        } else if (routeElementIdentifier == ChatListViewController.identifier) {
            completionHandler()
            pushViewController(ChatListViewController(), animated: true)
            return self
        }
        
        abort()
    }

    public func popRouteSegment(viewControllerIdentifier: RouteElementIdentifier,
                                animated: Bool,
                                completionHandler: RoutingCompletionHandler) {

        print("UINavigationController - popRouteSegment")
        print(viewControllerIdentifier)

        if (viewControllerIdentifier == AccountEditViewController.identifier) {
            dismissViewControllerAnimated(true, completion: completionHandler)
            return
        } else if (viewControllerIdentifier == EventCreateViewController.identifier) {
            completionHandler()
            popViewControllerAnimated(true)
        } else if (viewControllerIdentifier == TextInputViewController.identifier) {
            completionHandler()
            popViewControllerAnimated(true)
        } else if (viewControllerIdentifier == DateSettingViewController.identifier) {
            completionHandler()
            popViewControllerAnimated(true)
        }  else if (viewControllerIdentifier == EventListTableViewController.identifier) {
            completionHandler()
            popViewControllerAnimated(true)
        }  else if (viewControllerIdentifier == ChatListViewController.identifier) {
            completionHandler()
            popViewControllerAnimated(true)
        }
    }
}














@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, StoreSubscriber {

    static let rootIdentifier = "root"

    var window: UIWindow?
    var loading :LoadingView?
    var rootViewController: Routable!
    var router: Router<AppState>!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.setupAppearance()

        self.loading = LoadingView.getView("LoadingView") as? LoadingView

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let vc = SearchStartViewController(nibName: "SearchStartViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()

        rootViewController = nav

        // setup routing
        router = Router<AppState>(store: store, rootRoutable: RootRoutable(routable: rootViewController), stateSelector: { (state) -> NavigationState in
            return state.navigationState
        })

        // setup loading
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





        store.dispatch { state, store in
            if state.navigationState.route == [] {
                return SetRouteAction([
                    AppDelegate.rootIdentifier
                ])
            } else {
                return nil
            }
        }


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

