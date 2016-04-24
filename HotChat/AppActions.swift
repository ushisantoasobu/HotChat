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

struct CreateEventNameAction: Action {
    let name :String
}

struct CreateEventDateAction: Action {
    let date :NSDate
}