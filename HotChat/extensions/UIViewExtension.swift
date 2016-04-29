//
//  UIViewExtension.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/23.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit

extension UIView {

    // TODO : ここ、ジェネリクスでいけるでしょ！試す
    class func getView(nibName :String) -> UIView {
        let nib = UINib(nibName: nibName, bundle: nil)
        var views = nib.instantiateWithOwner(self, options: nil)
        return views[0] as! UIView
    }

}