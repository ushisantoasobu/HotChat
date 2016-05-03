//
//  ChatListViewController.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class ChatListViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource,
StoreSubscriber,
Routable {

    static let identifier = "ChatListViewController"

    @IBOutlet weak var fullSizeKeyboardHideButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatInputView: UIView!
    @IBOutlet weak var chatInputTextField: UITextField!
    @IBOutlet weak var chatInputViewBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyLabel: UILabel!

    init() {
        super.init(nibName: "ChatListViewController", bundle: nil)

        let event :Event = store.state.navigationState.getRouteSpecificState([
            RootIdentifier,
            EventListTableViewController.identifier,
            ChatListViewController.identifier
            ])!

        store.dispatch(ChatListSetEventAction(event: event))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO : あとで setupState() みたいな感じでまとめる？？
        store.dispatch(ChatListResetChatsAction())
        self.fullSizeKeyboardHideButton.hidden = true // MEMO : キーボードの出入りで表示切り替えてるのだけど、キーボードまわりもうまくReSwiftで扱えない感が

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
        // MEMO : 特定のstateだけ、とか考えたけど難しそう・・・そもそも渡ってくるstate自体はオールのstateなので、その前の処理でやらないと？？
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

    // MEMO : 初期化処理はviewdidloadに移したけど・・・どうするのがベスト？？
//    deinit {
//        store.dispatch(ChatListResetChatsAction())
//    }

    // MARK: - ReSwift

    func newState(state: AppState) {
        self.navigationItem.title = state.chatListState.event?.name
        self.emptyView.hidden = !state.chatListState.paging.isEmpty
        self.tableView.reloadData()
    }

    // MARK: - private

    private func setupAppearance() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.chatInputView.backgroundColor = UIColor.mainColor()
        self.emptyLabel.textColor = UIColor.mainColor()
    }

    private func setupHeader() {
        let backButton = UIBarButtonItem(title: "<", style: .Plain,
                                         target: self, action: #selector(ChatListViewController.back))
        self.navigationItem.leftBarButtonItem = backButton
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

    func back() {
        store.dispatch(SetRouteAction([RootIdentifier, EventListTableViewController.identifier]))
    }

    private func load() {
        let event = store.state.chatListState.event
        if event == nil {
            return
        }
        store.dispatch(LoadingShowAction(type: .Normal))
        APIManager.sharedInstance.getChats(event!.identifier, handler: { (chats) in
            store.dispatch(LoadingHideAction())
            store.dispatch(ChatListSuccessorPageAction(isLast: true, isEmpty: (chats.count == 0)))
            store.dispatch(ChatListAddChatsAction(chats: chats))
        })
    }

    private func validateSendMessage() -> Bool {
        // temp...空白のみのvalidateとかも本来は入れる
        return (self.chatInputTextField.text?.characters.count > 0)
    }

    // MARK: - IB actions

    @IBAction func chatSendButtonTapped(sender: AnyObject) {

        if !self.validateSendMessage() {
            return
        }

        store.dispatch(LoadingShowAction(type: .Masked))
        // MEMO : chatInputTextField.textもstateでもつ？？
        APIManager.sharedInstance.postChat(self.chatInputTextField.text!, handler: { (chat) in
            store.dispatch(LoadingHideAction())
            // TODO : weakself

            // MEMO : chatInputTextField.textもstateでもつ？？
            self.chatInputTextField.text = ""
            self.chatInputTextField.resignFirstResponder()
            store.dispatch(ChatListAddChatAction(chat: chat))
        })
    }

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
        let chat = store.state.chatListState.event?.chats[indexPath.row]
        if chat == nil {
            return 0.0
        }
        return ChatTableViewCell.cellHeight(chat!)
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
        return (store.state.chatListState.event?.chats.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let event = store.state.chatListState.event
        if event == nil {
            return UITableViewCell()
        }
        let cell :ChatTableViewCell
        let chat = event!.chats[indexPath.row]
        if chat.mine {
            cell = ChatTableViewCell.getView("ChatMeTableViewCell") as! ChatTableViewCell
        } else {
            cell = ChatTableViewCell.getView("ChatOtherTableViewCell") as! ChatTableViewCell
        }
        cell.setChat(chat)
        return cell
    }
    
}
