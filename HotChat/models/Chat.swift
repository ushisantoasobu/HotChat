//
//  Chat.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation

struct Chat {
    var user = User()
    var message = ""
    var date = NSDate()
    var likeCount = 0
    var anonymous = false
    var mine = false

    init(){ }

    init(user :User, message :String, mine :Bool) {
        self.user = user
        self.message = message
        self.mine = mine
    }
}
