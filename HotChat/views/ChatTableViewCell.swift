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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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

    
}
