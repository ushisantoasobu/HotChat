//
//  ChatListViewController.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit
import ReSwift

class ChatListViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource,
StoreSubscriber {

    @IBOutlet weak var fullSizeKeyboardHideButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatInputView: UIView!
    @IBOutlet weak var chatInputTextField: UITextField!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint! // 不要？？
    @IBOutlet weak var chatInputViewBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyLabel: UILabel!

    var chats = [Chat]()

    init() {
        super.init(nibName: "ChatListViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO : あとで setupState() みたいな感じでまとめる？？
        store.dispatch(TableAction(isEmpty: false))
        self.fullSizeKeyboardHideButton.hidden = true

        self.setupAppearance()
        self.setupHeader()
        self.setupTableView()

        self.load()
    }

    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear!!!!!!!!!!")
        super.viewWillAppear(animated)
        self.setupNotifications()

        // MEMO : 複数のstateを購読したいときはどうするんだろう？？ 一旦AppStateをそのまま返してる
        store.subscribe(self) { (state :AppState) -> AppState in
            return state
        }
    }

    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisappear&&&&&&&&&&&")
        super.viewWillDisappear(animated)
        self.removeNotifications()

        store.unsubscribe(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - ReSwift

    func newState(state: AppState) {
        self.emptyView.hidden = !state.tableState.isEmpty
    }

    // MARK: - private

    private func setupAppearance() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.chatInputView.backgroundColor = UIColor.mainColor()
        self.emptyLabel.textColor = UIColor.mainColor()
    }

    private func setupHeader() {
        self.navigationItem.title = "チャット一覧"
    }

    private func setupTableView() {
        self.tableView.separatorStyle = .None
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    private func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: nil) { (n :NSNotification!) -> Void in
            self.keyboardWillShow(n)
        }
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: nil) { (n :NSNotification!) -> Void in
            self.keyboardWillHide(n)
        }
    }

    private func removeNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(UIKeyboardWillShowNotification)
        NSNotificationCenter.defaultCenter().removeObserver(UIKeyboardWillHideNotification)
    }

    private func load() {
        store.state.loadingState.hidden = false
        APIManager.sharedInstance.getChats(0, handler: { (chats) in

            store.state.loadingState.hidden = true
            store.dispatch(TableAction(isEmpty: (chats.count == 0)))

            if chats.count == 0 {
                return
            }

            // TODO : weakself
            self.chats = chats
            self.tableView.reloadData()
        })
    }

    // MARK: - IB actions


    @IBAction func fullSizeKeyboardHideButtonTapped(sender: AnyObject) {
        self.chatInputTextField.resignFirstResponder()
    }

    // MARK: - keyboard from NSNotification

    func keyboardWillShow(notification:NSNotification) {
        let info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let curve = info[UIKeyboardAnimationCurveUserInfoKey] as! Int

        keyboardFrame = self.view.convertRect(keyboardFrame, toView: nil)

        self.chatInputViewBottomConstraint.constant = keyboardFrame.size.height

        UIView.animateWithDuration(duration as Double,
                                   delay: 0,
                                   options: UIViewAnimationOptions(rawValue: UInt(curve) << 16),
                                   animations: { () -> Void in
                                    self.view.layoutIfNeeded()
        }) { (flg) -> Void in
            self.fullSizeKeyboardHideButton.hidden = false
        }
    }

    func keyboardWillHide(notification:NSNotification) {
        let info = notification.userInfo!
        let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let curve = info[UIKeyboardAnimationCurveUserInfoKey] as! Int

        self.chatInputViewBottomConstraint.constant = 0

        UIView.animateWithDuration(duration as Double,
                                   delay: 0,
                                   options: UIViewAnimationOptions(rawValue: UInt(curve) << 16),
                                   animations: { () -> Void in
                                    self.view.layoutIfNeeded()
        }) { (flg) -> Void in
            self.fullSizeKeyboardHideButton.hidden = true
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    // MARK: - UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chats.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell :ChatTableViewCell
        let chat = self.chats[indexPath.row]
        if chat.mine {
            cell = ChatTableViewCell.getView("ChatMeTableViewCell") as! ChatTableViewCell
        } else {
            cell = ChatTableViewCell.getView("ChatOtherTableViewCell") as! ChatTableViewCell
        }
        cell.setChat(chat)
        return cell
    }
    
}
