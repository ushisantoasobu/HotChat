//
//  Event.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation

enum EventSearchType {
    case Location
    case History
}

struct Event {
    var identifier :Int = 0
    var name :String = ""
    var date :NSDate = NSDate()
    var location :Location = Location()
    var creator :User = User()
    var chatCount :Int = 0
    var expire :NSDate = NSDate()
    var chats = [Chat]()

    init() {
        //
    }

    init(identifier :Int, name :String, chatCount :Int) {
        self.identifier = identifier
        self.name = name
        self.chatCount = chatCount
    }
}