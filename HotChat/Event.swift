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
    var name :String = ""
    var date :NSDate = NSDate()
    var location :Location = Location()
    var creator :User = User()
    var chatCount :Int = 0
    var expire :NSDate = NSDate()

    init() {
        //
    }

    init(name :String, chatCount :Int) {
        self.name = name
        self.chatCount = chatCount
    }
}