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
    
    func getEvents(location :Location) -> [Event] {

        var event1 = Event()
        event1.name = "Sun kil moon 単独公演"
        event1.chatCount = 3

        var event2 = Event()
        event2.name = "Spiritualized - AcousticMainlines"
        event2.chatCount = 8

        return [
            event1, event2
        ]
    }
    
    func getEvents(userId :Int) -> [Event] {
        var event1 = Event()
        event1.name = "ドリップコーヒー選手権 2016"
        event1.chatCount = 34

        return [
            event1
        ]
    }
    
    func getEvent(eventId :Int) -> Event? {
        return nil
    }
    
}