//
//  ChatLikeButton.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/28.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import Foundation
import UIKit

class ChatLikeButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setTitleColor(UIColor.mainThinColor(), forState: .Normal)
        self.setTitleColor(UIColor.mainColor(), forState: .Selected)
    }

}