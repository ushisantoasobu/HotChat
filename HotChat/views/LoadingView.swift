//
//  LoadingView.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/29.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        self.indicator.color = UIColor.mainColor()
        self.backgroundColor = UIColor.clearColor()
    }

}
