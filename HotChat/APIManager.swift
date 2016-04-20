//
//  APIManager.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation

class APIManager {
    //singleton
    
    func getUser(userId :Int) -> User? {
        return nil
    }
    
    func getEvents(location :Location) -> [Event] {
        return []
    }
    
    func getEvents(userId :Int) -> [Event] {
        return []
    }
    
    func getEvent(eventId :Int) -> Event? {
        return nil
    }
    
}