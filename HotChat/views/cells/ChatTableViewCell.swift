//
//  ChatTableViewCell.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bodyContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
        self.bodyContainerView.layer.cornerRadius = 8.0
        self.selectionStyle = .None
    }
    
    func setChat(chat :Chat) {
        self.nameLabel?.text = chat.user.name
        self.bodyLabel.text = chat.message
        
        if chat.mine {
            self.bodyLabel.textColor = UIColor.whiteColor()
            self.bodyContainerView.backgroundColor = UIColor.mainColor()
        } else {
            self.bodyLabel.textColor = UIColor.whiteColor()
            self.bodyContainerView.backgroundColor = UIColor.lightGrayColor()

            // temp code
            if let avatar = self.avatarImageView {
                let data = NSData(contentsOfURL: NSURL(string: chat.user.imageUrl)!)
                if data == nil {
                    return
                }
                avatar.image = UIImage(data: data!)
            }
        }
    }

    // MARK: - IB actions

    @IBAction func likeButtonTapped(button: ChatLikeButton) {
        button.selected = !button.selected
    }

    // MARK: - class func

    class func cellHeight(chat :Chat) -> CGFloat {
        // MEMO : bad code
        var verticalMargin :CGFloat = 0.0
        var horizontalMargin :CGFloat = 0.0
        if chat.mine {
            verticalMargin = 120 - 88
            horizontalMargin = 320 - 248 - 8 - 8
        } else {
            verticalMargin = 136 - 75
            horizontalMargin = 320 - 200 - 8 - 8
        }
        let tempLabel = UILabel(frame: CGRectMake(0.0, 0.0,
            UIScreen.mainScreen().bounds.width - horizontalMargin, CGFloat.max))
        tempLabel.font = UIFont.systemFontOfSize(14)
        tempLabel.text = chat.message
        tempLabel.numberOfLines = 0
        tempLabel.sizeToFit()
        print(tempLabel.frame.size.height)
        return verticalMargin + tempLabel.frame.size.height + 8
    }

    
}
