//
//  NSDateExtension.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/23.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation

extension NSDate {

    func convertToString() -> String {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.stringFromDate(self)
    }
    
}