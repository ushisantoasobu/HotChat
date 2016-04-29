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

    // MARK: - temp data

    // TODO: add paging...try reducer some patterns
    var locationEvents = [
        Event(identifier: 0, name: "BLUE by MUSIC CIRCUS BEACH EDITION", chatCount: 343),
        Event(identifier: 1, name: "Spiritualized - AcousticMainlines", chatCount: 8),
        Event(identifier: 1, name: "カルチャークラブ 単独来日公演", chatCount: 1),
        Event(identifier: 1, name: "2PM ARENA TOUR 2016 GALAXY OF 2PM", chatCount: 854),
        Event(identifier: 1, name: "The Stone Roses 16/6/3 (金) 18:15 日本武道館", chatCount: 14),
        Event(identifier: 1, name: "DIZZY MIZZ LIZZY Japan Tour 2016", chatCount: 22),
        Event(identifier: 1, name: "NEW ORDER 来日公演", chatCount: 6),
        Event(identifier: 1, name: "MOGWAI JAPAN TOUR 2016", chatCount: 11),
        Event(identifier: 1, name: "AVICII JAPAN TOUR 2016", chatCount: 121),
        Event(identifier: 1, name: "スペシャル・ライヴ ヒストリー・オブ・テリー・ボジオ", chatCount: 12),
        Event(identifier: 1, name: "サラ・ブライトマン ガラ・コンサート", chatCount: 32),
        Event(identifier: 1, name: "アレクサンデル･ガジェヴ　ピアノ･リサイタル", chatCount: 8),
        Event(identifier: 1, name: "ユーリ・テミルカーノフ(指揮) サンクトペテルブルグ・フィルハーモニー交響楽団", chatCount: 9),
        Event(identifier: 1, name: "Sun kil moon 単独公演", chatCount: 3),
    ]

    var chats = [
        Chat(user: User(name: "ushisantoasobu"), message: "楽しみですね、よろしくお願いします！！", mine: true),
        Chat(user: User(name: "高畑充希"), message: "全然人入ってない > < 見やすいけど寂しい", mine: false)
    ]

    // MARK: - public

    func getUser(userId :Int) -> User? {
        return nil
    }

    func putUser(user :User, handler : () -> Void ) -> Void {
        //
    }
    
    func getEvents(location :Location, page :Int, handler : ([Event], Bool) -> Void ) {
        let delay = 1.2 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            let startIndex = page * 10
            let endIndex = (self.locationEvents.count < (startIndex + 10)) ?  self.locationEvents.count : (startIndex + 10)
            let isLastPage = (page == 1)
            handler(Array(self.locationEvents[startIndex..<endIndex]), isLastPage)
        })
    }
    
    func getEvents(userId :Int, page :Int, handler :([Event] -> Void)) {
        let delay = 0.4 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            var event1 = Event()
            event1.name = "ドリップコーヒー選手権 2016"
            event1.chatCount = 34

            handler([event1])
        })
    }
    
    func getEvent(eventId :Int) -> Event? {
        return nil
    }

    func postEvent(event :Event, handler :(() -> Void)){
        let delay = 0.4 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.locationEvents.append(event)
            handler()
        })
    }

    func getChats(eventId :Int, handler :([Chat] -> Void)){

        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {

            // temp
            if eventId == 0 {
                handler([])
                return
            }
            
            handler(self.chats)
        })
    }

    func postChat(chat :Chat, handler :(() -> Void)){
        //
    }

    func deleteChat(chatId :Int, handler :(() -> Void)){
        //
    }

}