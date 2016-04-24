//
//  APIManager.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation

class APIManager {

    // MARK: - singleton

    class var sharedInstance : APIManager {
        struct Static {
            static let instance : APIManager = APIManager()
        }
        return Static.instance
    }

    // MARK: - public

    func getUser(userId :Int) -> User? {
        return nil
    }
    
    func getEvents(location :Location, handler : [Event] -> Void ) {

        var event1 = Event()
        event1.name = "Sun kil moon 単独公演"
        event1.chatCount = 3

        var event2 = Event()
        event2.name = "Spiritualized - AcousticMainlines"
        event2.chatCount = 8

        handler([event1, event2])
    }
    
    func getEvents(userId :Int, handler :([Event] -> Void)) {
        var event1 = Event()
        event1.name = "ドリップコーヒー選手権 2016"
        event1.chatCount = 34

        handler([event1])
    }
    
    func getEvent(eventId :Int) -> Event? {
        return nil
    }

    func getChats(eventId :Int, handler :([Chat] -> Void)){

//        let delay = 1.0 * Double(NSEC_PER_SEC)
//        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//        dispatch_after(time, dispatch_get_main_queue(), {
//
//        })

        var user1 = User()
        user1.name = "ushisantoasobu"

        var chat1 = Chat()
        chat1.user = user1
        chat1.message = "楽しみですね、よろしくお願いします！！"
        chat1.mine = true

        var user2 = User()
        user2.name = "高畑充希"

        var chat2 = Chat()
        chat2.user = user2
        chat2.message = "全然人入ってない > < 見やすいけど寂しい"
        chat2.mine = false

        handler([chat1, chat2])
    }
}