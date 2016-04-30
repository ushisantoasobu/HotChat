//
//  AccountManager.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/23.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation

class AccountManager {

    var user = User()

    // MARK: - singleton

    class var sharedInstance : AccountManager {
        struct Static {
            static let instance : AccountManager = AccountManager()
        }
        return Static.instance
    }

    init() {
        user.name = "ushisantoasobu"
        user.openFb = false
        user.imageUrl = "https://pbs.twimg.com/profile_images/1745491150/image"
    }
}