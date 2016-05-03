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

    func addSubviewWithZeroConstraints(view :UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)

        self.addConstraint(NSLayoutConstraint(
            item: self,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Top,
            multiplier: 1.0,
            constant: 0.0))

        self.addConstraint(NSLayoutConstraint(
            item: self,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0.0))

        self.addConstraint(NSLayoutConstraint(
            item: self,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0.0))

        self.addConstraint(NSLayoutConstraint(
            item: self,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Right,
            multiplier: 1.0,
            constant: 0.0))

        view.layoutIfNeeded()
    }

}