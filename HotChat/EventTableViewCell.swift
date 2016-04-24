//
//  EventTableViewCell.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chatCountLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!

    class func instantiate() -> EventTableViewCell {
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        var views = nib.instantiateWithOwner(self, options: nil)
        return views[0] as! EventTableViewCell
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.chatCountLabel.textColor = UIColor.mainColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setEvent(event :Event) {
        self.nameLabel.text = event.name
        self.chatCountLabel.text = "comment " + String(event.chatCount)
    }

    class func cellHeight() -> CGFloat {
        return 64.0
    }
}
