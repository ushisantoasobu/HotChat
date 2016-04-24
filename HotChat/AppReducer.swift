//
//  AppReducer.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/24.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation
import ReSwift

struct AppReducer: Reducer {

    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(
            //            navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
            //            authenticationState: authenticationReducer(state?.authenticationState, action: action),
            //            repositories: repositoriesReducer(state?.repositories, action: action),
            //            bookmarks: bookmarksReducer(state?.bookmarks, action: action)

            eventCreateState: eventCreateReducer(state?.eventCreateState, action: action)
        )
    }

    func eventCreateReducer(state: EventCreateState?, action: Action) -> EventCreateState {
//        var state = state ?? initialAuthenticationState()
        var state = state ?? EventCreateState() // TODO??

        switch action {
        case let action as CreateEventNameAction:
            state.name = action.name
            break
        case let action as CreateEventDateAction:
            state.date = action.date
        case _ as CreateEventResetAction:
            state.name = nil
            state.date = nil
        default:
            break
        }

        return state
    }

}
