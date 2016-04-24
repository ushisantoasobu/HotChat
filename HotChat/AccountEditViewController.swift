//
//  AccountEditViewController.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/23.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit

class AccountEditViewController: UIViewController {

    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var facebookSwitch: UISwitch!

    init() {
        super.init(nibName: "AccountEditViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupAppearance()
        self.setupHeader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - private

    private func setupAppearance() {
        self.facebookSwitch.onTintColor = UIColor.mainColor()
        self.facebookSwitch.tintColor = UIColor.mainColor()
    }

    private func setupHeader() {
        self.navigationItem.title = "アカウント設定"

        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel,
                                         target: self, action: #selector(AccountEditViewController.closeButtonTapped))
        self.navigationItem.leftBarButtonItem = closeButton

        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                           target: self, action: #selector(AccountEditViewController.doneButtonTapped))
        self.navigationItem.rightBarButtonItems = [doneButton]
    }

    func closeButtonTapped() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func doneButtonTapped() {
        let alert = UIAlertController(title: nil, message: "アカウント設定を更新しました！", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (alert) in
            // TODO: weakself
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated:true, completion:nil)
        return
    }

    // MARK: - IB actions

    @IBAction func avatarButtonTapped(sender: AnyObject) {
        let alert = UIAlertController(title: nil, message: "画像の更新は現時点ではできません", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated:true, completion:nil)
        return
    }

    @IBAction func nameButtonTapped(sender: AnyObject) {
        let vc = TextInputViewController()
        vc.textSetDone = {(text :String) in
            // TODO: weakself
            self.navigationController?.popViewControllerAnimated(true)
            self.nameButton.setTitle(text, forState: .Normal)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }



}
