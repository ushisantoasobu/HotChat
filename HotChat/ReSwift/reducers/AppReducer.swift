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

            loadingState: loadingReducer(state?.loadingState, action: action),
//            tableState:  tableReducer(state?.tableState, action: action),
            eventCreateState: eventCreateReducer(state?.eventCreateState, action: action),
            accountEditState: accountEditReducer(state?.accountEditState, action: action),
            eventListState: eventListReducer(state?.eventListState, action: action),
            chatListState: chatListReducer(state?.chatListState, action: action)
        )
    }

    func loadingReducer(state: LoadingState?, action: Action) -> LoadingState {
        var state = state ?? LoadingState()

        switch action {
        case let action as LoadingAction:
            state.hidden = action.hidden
            state.toucheable = action.touchable
            break
        default:
            break
        }

        return state
    }

//    func tableReducer(state: TableState?, action: Action) -> TableState {
//        var state = state ?? TableState()
//
//        switch action {
//        case let action as TableAction:
//            state.isEmpty = action.isEmpty
//            break
//        default:
//            break
//        }
//
//        return state
//    }

    // MARK: - EventCreate

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

    // MARK: - AccountEdit

    func accountEditReducer(state: AccountEditState?, action: Action) -> AccountEditState {
        var state = state ?? AccountEditState()

        switch action {
        case let action as AccountEditNameAction:
            state.name = action.name
            break
        case let action as AccountEditOpenFbAction:
            state.openFb = action.openFb
            break
        case _ as AccountEditResetAction:
            state.name = nil
            state.openFb = false
        default:
            break
        }

        return state
    }

    // MARK: - EventList

    func eventListReducer(state: EventListState?, action: Action) -> EventListState {
        var state = state ?? EventListState()

        switch action {
        case let action as EventListChangeTypeAction:
            state.type = action.type
            break
        case let action as EventListAddEventsAction:
            state.events?.appendContentsOf(action.events)
            break
        case let action as EventListSuccessorPageAction:
            state.paging = Paging(num: state.paging.num + 1,
                                  isLast: action.isLast,
                                  isEmpty: false,
                                  isRefreshing: false) // MEMO : 後半２つは仮
            break
        case _ as EventListResetEventsAction:
            state.events = []
            state.paging = Paging()
            break
        default:
            break
        }

        return state
    }

    // MARK: - XXXXX

    func chatListReducer(state: ChatListState?, action: Action) -> ChatListState {
        var state = state ?? ChatListState()

        switch action {
        case let action as ChatListAddChatsAction:
            state.chatList?.appendContentsOf(action.chats)
            break
        case let action as ChatListAddChatAction:
            state.chatList?.append(action.chat)
            break
        case let action as ChatListSuccessorPageAction:
            let num = action.isEmpty ? 0 : state.paging.num + 1
            state.paging = Paging(num: num,
                                  isLast: action.isLast,
                                  isEmpty: action.isEmpty,
                                  isRefreshing: false)
            break
        case _ as ChatListResetChatsAction:
            state.chatList = []
            state.paging = Paging()
            break
        default:
            break
        }

        return state
    }

}
