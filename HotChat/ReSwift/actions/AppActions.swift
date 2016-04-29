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

// MEMO: 以下分ける必要あるのかわからない、まずはわけてつくってみる => やっぱ一旦やめる

//struct EventListLocationAddAction: Action {
//    let list :[Event]
//}
//
//struct EventListHistoryAddAction: Action {
//    let list :[Event]
//}

struct EventListChangeTypeAction: Action {
    let type :EventSearchType
}

struct EventListAddEventsAction: Action {
    let events :[Event]
}

struct EventListResetEventsAction: Action { }

struct EventListSuccessorPageAction: Action {
    let isLast :Bool
}

// MARK: - ChatList

struct ChatListAddChatsAction: Action {
    let chats :[Chat]
}

struct ChatListAddChatAction: Action {
    let chat :Chat
}

struct ChatListResetChatsAction: Action { }

struct ChatListSuccessorPageAction: Action {
    let isLast :Bool
    let isEmpty :Bool
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


