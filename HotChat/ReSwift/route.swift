//
//  route.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/05/03.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation
import ReSwiftRouter

let RootIdentifier = "root"

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
            pushViewController(TextInputViewController(), animated: true)
            return self
        } else if (routeElementIdentifier == DateSettingViewController.identifier) {

            completionHandler()
            let vc = DateSettingViewController()
            vc.initialDate = store.state.eventCreateState.date
            vc.dateSetDone = {(date :NSDate) in
                store.dispatch(SetRouteAction([
                    RootIdentifier,
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