//
//  LoadingView.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/29.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit

enum LoadingType {
    case Normal
//    case NormalWhite
    case Masked
}

class LoadingView: UIView {

    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        self.setType(.Normal)
    }

    func setType(type :LoadingType) {
        let indicatorColor: UIColor
        let backgroundColor: UIColor
        let touchable: Bool

        switch type {
        case .Normal:
            backgroundColor = UIColor.clearColor()
            indicatorColor = UIColor.mainColor()
            touchable = false
            break
        case .Masked:
            backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.45)
            indicatorColor = UIColor.mainColor()
            touchable = false
            break
        }

        self.indicator.color = indicatorColor
        self.backgroundColor = backgroundColor
        self.userInteractionEnabled = touchable
    }

}
