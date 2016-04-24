//
//  AccountManager.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/23.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation

class AccountManager {

    var identifier = 1
    var name = "ushisantoasobu"
    // TODO: User() のほうが正しい？？

    // MARK: - singleton

    class var sharedInstance : AccountManager {
        struct Static {
            static let instance : AccountManager = AccountManager()
        }
        return Static.instance
    }
}