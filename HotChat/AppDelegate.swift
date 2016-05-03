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
import ReSwiftRecorder


var store = Store<AppState>(
    reducer: AppReducer(),
    state: nil
)

/*
var store = RecordingMainStore<AppState>(reducer: AppReducer(),
                                         state: nil,
                                         typeMaps: [AppActionTypeMap, ReSwiftRouter.typeMap],
                                         recording: "recording.json")

let AppActionTypeMap: TypeMap = [
    LoadingShowAction.type : LoadingShowAction.self,
    LoadingHideAction.type : LoadingHideAction.self,
    CreateEventNameAction.type : CreateEventNameAction.self,
    CreateEventDateAction.type : CreateEventDateAction.self,
    CreateEventResetAction.type : CreateEventResetAction.self,
    EventListChangeTypeAction.type : EventListChangeTypeAction.self,
    EventListAddEventsAction.type : EventListAddEventsAction.self,
    EventListResetEventsAction.type : EventListResetEventsAction.self,
    EventListSuccessorPageAction.type : EventListSuccessorPageAction.self,
    ChatListSetEventAction.type : ChatListSetEventAction.self,
    ChatListAddChatsAction.type : ChatListAddChatsAction.self,
    ChatListAddChatAction.type : ChatListAddChatAction.self,
    ChatListResetChatsAction.type : ChatListResetChatsAction.self,
    ChatListSuccessorPageAction.type : ChatListSuccessorPageAction.self,
    AccountEditNameAction.type : AccountEditNameAction.self,
    AccountEditOpenFbAction.type : AccountEditOpenFbAction.self,
    AccountEditResetAction.type : AccountEditResetAction.self
]
 */


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, StoreSubscriber {

    var window: UIWindow?
    var loading :LoadingView?
    var rootViewController: Routable!
    var router: Router<AppState>!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.setupAppearance()

        // setup initialVC
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let vc = SearchStartViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()

        // setup loading
        self.loading = LoadingView.getView("LoadingView") as? LoadingView
        if let loading = self.loading {
            self.window?.addSubviewWithZeroConstraints(loading)
        }

        // setup routing
        rootViewController = nav
        router = Router<AppState>(store: store, rootRoutable: RootRoutable(routable: rootViewController), stateSelector: { (state) -> NavigationState in
            return state.navigationState
        })

        // setup subscribe (for only loading)
        store.subscribe(self) { (state :AppState) -> LoadingState in
            return state.loadingState
        }

        // some store dispatches
        store.dispatch(LoadingHideAction())
        store.dispatch { state, store in
            if state.navigationState.route == [] {
                return SetRouteAction([
                    RootIdentifier
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

    /**
     UIAppearanceの設定
     */
    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.mainColor()
    }
}

