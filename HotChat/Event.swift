//
//  Event.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation

// ???
typealias Location = (String, String) // (lattitude, )

struct Event {
    var name :String
    var date :NSDate
    var location :Location
    var creator :User
    var chatCount :Int
    var expire :NSDate
}