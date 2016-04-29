//
//  AppState.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/24.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {

    var loadingState = LoadingState()
    var tableState = TableState()
    var eventCreateState = EventCreateState()
    var accountEditState = AccountEditState()
    var eventListState = EventListState()
    var chatListState = ChatListState()

    // future...we will add Router
}

struct LoadingState {
    var hidden = true
    var toucheable = false
}

struct TableState {
    var isEmpty = false
}

// ↑ 汎用的なStateをどんな感じでつくっていくべきか迷う

struct EventCreateState: StateType {
    var name :String?
    var date :NSDate?
}

struct AccountEditState: StateType {
    var name :String?
    var openFb = false
}

struct EventListState: StateType {
    var locationList :[Event]?
    var historyList :[Event]?
}

struct ChatListState: StateType {
    var chatList :[Chat]?
    var sendingChat :Chat?
}