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

// MARK: - Loading

struct LoadingShowAction: StandardActionConvertible {
    static let type = "LoadingShowAction"
    let type :LoadingType
    init(type :LoadingType) { self.type = type }
    init(_ standardAction: StandardAction) { self.type = .Normal }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: LoadingShowAction.type, payload: ["type" : type.rawValue], isTypedAction: true)
    }
}

struct LoadingHideAction: StandardActionConvertible {
    static let type = "LoadingHideAction"
    init() {}
    init(_ standardAction: StandardAction) {}
    func toStandardAction() -> StandardAction {
        return StandardAction(type: LoadingHideAction.type, payload: nil, isTypedAction: true)
    }
}

// MARK: - CreateEvent

struct CreateEventNameAction: StandardActionConvertible {
    static let type = "CreateEventNameAction"
    let name :String
    init(name :String) { self.name = name }
    init(_ standardAction: StandardAction) { self.name = "" }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: CreateEventNameAction.type, payload: ["name" : name], isTypedAction: true)
    }
}

struct CreateEventDateAction: StandardActionConvertible {
    static let type = "CreateEventDateAction"
    let date :NSDate
    init(date :NSDate) { self.date = date }
    init(_ standardAction: StandardAction) { self.date = NSDate() }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: CreateEventDateAction.type, payload: ["date" : date], isTypedAction: true)
    }
}

struct CreateEventResetAction: StandardActionConvertible {
    static let type = "CreateEventResetAction"
    init() {}
    init(_ standardAction: StandardAction) {}
    func toStandardAction() -> StandardAction {
        return StandardAction(type: CreateEventResetAction.type, payload: nil, isTypedAction: true)
    }
}

// MARK: - EventList

struct EventListChangeTypeAction: StandardActionConvertible {
    static let type = "EventListChangeTypeAction"
    let type :EventSearchType
    init(type :EventSearchType) { self.type = type }
    init(_ standardAction: StandardAction) { self.type = .Location }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: EventListChangeTypeAction.type, payload: ["type" : type.rawValue], isTypedAction: true)
    }
}

struct EventListAddEventsAction: StandardActionConvertible {
    static let type = "EventListAddEventsAction"
    let events :[Event]
    init(events :[Event]) { self.events = events }
    init(_ standardAction: StandardAction) { self.events = [] }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: EventListAddEventsAction.type, payload: ["events" : "test"], isTypedAction: true)
    }
}

struct EventListResetEventsAction: StandardActionConvertible {
    static let type = "EventListResetEventsAction"
    init() {}
    init(_ standardAction: StandardAction) {}
    func toStandardAction() -> StandardAction {
        return StandardAction(type: EventListResetEventsAction.type, payload: nil, isTypedAction: true)
    }
}

struct EventListSuccessorPageAction: StandardActionConvertible {
    static let type = "EventListSuccessorPageAction"
    let isLast :Bool
    init(isLast :Bool) { self.isLast = isLast }
    init(_ standardAction: StandardAction) { self.isLast = false }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: EventListSuccessorPageAction.type, payload: ["isLast" : isLast], isTypedAction: true)
    }
}

// MARK: - ChatList

struct ChatListSetEventAction: StandardActionConvertible {
    static let type = "ChatListSetEventAction"
    let event :Event
    init(event :Event) { self.event = event }
    init(_ standardAction: StandardAction) { self.event = Event() }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: ChatListSetEventAction.type, payload: ["event" : "test"], isTypedAction: true)
    }
}

struct ChatListAddChatsAction: StandardActionConvertible {
    static let type = "ChatListAddChatsAction"
    let chats :[Chat]
    init(chats :[Chat]) { self.chats = chats }
    init(_ standardAction: StandardAction) { self.chats = [] }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: ChatListAddChatsAction.type, payload: ["chats" : "test"], isTypedAction: true)
    }
}

struct ChatListAddChatAction: StandardActionConvertible {
    static let type = "ChatListAddChatAction"
    let chat :Chat
    init(chat :Chat) { self.chat = chat }
    init(_ standardAction: StandardAction) { self.chat = Chat() }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: ChatListAddChatAction.type, payload: ["chat" : "test"], isTypedAction: true)
    }
}

struct ChatListResetChatsAction: StandardActionConvertible {
    static let type = "ChatListResetChatsAction"
    init() {}
    init(_ standardAction: StandardAction) {}
    func toStandardAction() -> StandardAction {
        return StandardAction(type: ChatListResetChatsAction.type, payload: nil, isTypedAction: true)
    }
}

struct ChatListSuccessorPageAction: StandardActionConvertible {
    static let type = "ChatListSuccessorPageAction"
    let isLast :Bool
    let isEmpty :Bool

    init(isLast :Bool, isEmpty :Bool) {
        self.isLast = isLast
        self.isEmpty = isEmpty
    }
    init(_ standardAction: StandardAction) {
        self.isLast = false
        self.isEmpty = false
    }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: ChatListSuccessorPageAction.type,
                              payload: [
                                "isLast" : isLast,
                                "isEmpty" : isEmpty
            ],
                              isTypedAction: true)
    }
}

// MARK: - AccountEdit

struct AccountEditNameAction: StandardActionConvertible {
    static let type = "AccountEditNameAction"
    let name :String
    init(name :String) { self.name = name }
    init(_ standardAction: StandardAction) { self.name = "" }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: AccountEditNameAction.type, payload: ["name" : name], isTypedAction: true)
    }
}

struct AccountEditOpenFbAction: StandardActionConvertible {
    static let type = "AccountEditOpenFbAction"
    let openFb :Bool
    init(openFb :Bool) { self.openFb = openFb }
    init(_ standardAction: StandardAction) { self.openFb = false }
    func toStandardAction() -> StandardAction {
        return StandardAction(type: AccountEditOpenFbAction.type, payload: ["openFb" : openFb], isTypedAction: true)
    }
}

struct AccountEditResetAction: StandardActionConvertible {
    static let type = "AccountEditResetAction"
    init() {}
    init(_ standardAction: StandardAction) {}
    func toStandardAction() -> StandardAction {
        return StandardAction(type: AccountEditResetAction.type, payload: nil, isTypedAction: true)
    }
}

// MARK: - DateSetting

//struct DateSettingSetAction: Action {
//    let date :NSData
//}

//struct DateSettingSetAction: StandardActionConvertible {
//    static let type = "DateSettingSetAction"
//    let date :NSData
//    init(date :NSData) { self.date = date }
//    init(_ standardAction: StandardAction) { self.date = NSData }
//    func toStandardAction() -> StandardAction {
//        return StandardAction(type: DateSettingSetAction.type, payload: ["date" : date], isTypedAction: true)
//    }
//}

