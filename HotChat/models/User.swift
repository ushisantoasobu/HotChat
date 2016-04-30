//
//  User.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation

struct User {
    var identifier :Int = 0
    var name :String = ""
    var imageUrl :String = ""
    var openFb :Bool = false

    init() {}

    init(name :String, imageUrl :String) {
        self.name = name
        self.imageUrl = imageUrl
    }
}