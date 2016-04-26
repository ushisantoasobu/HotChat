//
//  InfiniteLoadingCell.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/27.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit

class InfiniteLoadingCell: UITableViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!

    class func instantiate() -> InfiniteLoadingCell {
        let nib = UINib(nibName: "InfiniteLoadingCell", bundle: nil)
        var views = nib.instantiateWithOwner(self, options: nil)
        return views[0] as! InfiniteLoadingCell
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .None
        self.indicator.startAnimating()
    }
    
}
