//
//  AppActions.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/24.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation
import ReSwift

// MEMO: 一旦すべてのActionをここに書いていくこととする（複数のファイルにはしない）

// MARK: - Common

struct CommonShowLoadingAction: Action { }
struct CommonHideLoadingAction: Action { }
struct CommonListEmptyAction: Action { }

// MARK: - Loading

struct LoadingAction: Action {
    let hidden :Bool
    let touchable :Bool
}

// MARK: - Table

struct TableAction: Action {
    let isEmpty :Bool
}

// MARK: - CreateEvent

struct CreateEventNameAction: Action {
    let name :String
}

struct CreateEventDateAction: Action {
    let date :NSDate
}

struct CreateEventResetAction: Action {
}

// MARK: - EventList

// MEMO: 以下分ける必要あるのかわからない、まずはわけてつくってみる

struct EventListLocationAddAction: Action {
    let list :[Event]
}

struct EventListHistoryAddAction: Action {
    let list :[Event]
}

// MARK: - ChatList

struct ChatListAddChatsAction: Action {
    let list :[Chat]
}

struct ChatListAddChatAction: Action {
    let list :Chat
}

// MARK: - AccountEdit

struct AccountEditNameAction: Action {
    let name :String
}

struct AccountEditOpenFbAction: Action {
    let openFb :Bool
}

struct AccountEditResetAction: Action {
}

// MARK: - DateSetting

struct DateSettingSetAction: Action {
    let date :NSData
}


