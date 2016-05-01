//
//  AccountEditViewController.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/23.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class AccountEditViewController: UIViewController, StoreSubscriber, Routable {

    static let identifier = "AccountEditViewController"

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

        self.setupInitialState()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        store.subscribe(self) { (state :AppState) -> AccountEditState in
            return state.accountEditState
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        store.unsubscribe(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - ReSwift

    func newState(state: AccountEditState) {
        self.nameButton.setTitle(state.name, forState: .Normal)
        self.facebookSwitch.setOn(state.openFb, animated: true) // MEMO: 初回だけfalseにしたいとか、どうする？？
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

    private func setupInitialState() {
        // MEMO: こう書いたらどうなっちゃうの？？コンパイルエラーでないけど・・
//        store.state.accountEditState.name = AccountManager.sharedInstance.user.name
//        store.state.accountEditState.openFb = AccountManager.sharedInstance.user.openFb

        store.dispatch(AccountEditNameAction(name: AccountManager.sharedInstance.user.name))
        store.dispatch(AccountEditOpenFbAction(openFb: AccountManager.sharedInstance.user.openFb))
    }

    func closeButtonTapped() {
        store.dispatch(AccountEditResetAction())
        store.dispatch(
            SetRouteAction([
                "UINavigationController"
                ])
        )
    }

    func doneButtonTapped() {

        if store.state.accountEditState.name == nil {
            let alert = UIAlertController(title: nil, message: "アカウント名がおかしいです！", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated:true, completion:nil)
            return
        }

        AccountManager.sharedInstance.user.name = store.state.accountEditState.name!
        AccountManager.sharedInstance.user.openFb = store.state.accountEditState.openFb

        let alert = UIAlertController(title: nil, message: "アカウント設定を更新しました！", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (alert) in
            // TODO: weakself
            store.dispatch(
                SetRouteAction([
                    "UINavigationController"
                    ])
            )
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
            store.dispatch(AccountEditNameAction(name: text))
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func facebookSwitchChanged(sender: UISwitch) {
        store.dispatch(AccountEditOpenFbAction(openFb: sender.on))
    }


}
