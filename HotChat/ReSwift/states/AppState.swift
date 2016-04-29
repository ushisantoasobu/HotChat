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
    var eventCreateState = EventCreateState()
    var accountEditState = AccountEditState()
    var eventListState = EventListState()
    var chatListState = ChatListState()

    // future...we will add Router
}

struct LoadingState {
    var isLoading = false
    var type :LoadingType = .Normal
}

// ↑ 汎用的なStateをどんな感じでつくっていくべきか迷う

struct Paging {
    var num = 0
    var isLast = false
    var isEmpty = false
    var isRefreshing = false // MEMO : 使える？？
}

struct EventCreateState: StateType {
    var name :String?
    var date :NSDate?
}

struct AccountEditState: StateType {
    var name :String?
    var openFb = false
}

struct EventListState: StateType {
    var events :[Event]?
    var type :EventSearchType?
    var paging = Paging()
}

struct ChatListState: StateType {
    // MEMO : ここの event は EventListState の state と共有されてないと無意味だよね？？
    var event :Event?
    var sendingChat :Chat?
    var paging = Paging()
}