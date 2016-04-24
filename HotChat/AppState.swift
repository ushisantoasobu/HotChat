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

    var eventCreateState = EventCreateState()
    var accountEditState = AccountEditState()
    var eventListState = EventListState()
    var chatListState = ChatListState()

    // future...we will add Router
}

struct EventCreateState: StateType {
    var name :String?
    var date :NSDate?
}

struct AccountEditState: StateType {
    var name :String?
}

struct EventListState: StateType {
    var locationList :[Event]?
    var historyList :[Event]?
}

struct ChatListState: StateType {
    var chatList :[Chat]?
    var sendingChat :Chat?
}