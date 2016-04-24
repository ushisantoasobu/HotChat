//
//  AppState.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/24.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {

    var eventCreateState = EventCreateState()

    // future...we will add Router
}

struct EventCreateState: StateType {
    var name = ""
    var date = NSDate()
}