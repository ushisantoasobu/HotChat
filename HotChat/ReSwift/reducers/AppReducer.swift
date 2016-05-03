//
//  AppReducer.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/24.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter

struct AppReducer: Reducer {

    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(
            navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
            loadingState: loadingReducer(state?.loadingState, action: action),
            eventCreateState: eventCreateReducer(state?.eventCreateState, action: action),
            accountEditState: accountEditReducer(state?.accountEditState, action: action),
            eventListState: eventListReducer(state?.eventListState, action: action),
            chatListState: chatListReducer(state?.chatListState, action: action)
        )
    }

    func loadingReducer(state: LoadingState?, action: Action) -> LoadingState {
        var state = state ?? LoadingState()

        switch action {
        case let action as LoadingShowAction:
            state.type = action.type
            state.isLoading = true
            break
        case _ as LoadingHideAction:
            state.isLoading = false
            break
        default:
            break
        }

        return state
    }

    // MARK: - EventCreate

    func eventCreateReducer(state: EventCreateState?, action: Action) -> EventCreateState {
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

    // MARK: - ChatList

    func chatListReducer(state: ChatListState?, action: Action) -> ChatListState {
        var state = state ?? ChatListState()

        switch action {
        case let action as ChatListSetEventAction:
            state.event = action.event
            break
        case let action as ChatListAddChatsAction:
            state.event?.chats.appendContentsOf(action.chats)
            break
        case let action as ChatListAddChatAction:
            state.event?.chats.append(action.chat)
            break
        case let action as ChatListSuccessorPageAction:
            let num = action.isEmpty ? 0 : state.paging.num + 1
            state.paging = Paging(num: num,
                                  isLast: action.isLast,
                                  isEmpty: action.isEmpty,
                                  isRefreshing: false)
            break
        case _ as ChatListResetChatsAction:
            state.event?.chats = []
            state.paging = Paging()
            break
        default:
            break
        }

        return state
    }

}
