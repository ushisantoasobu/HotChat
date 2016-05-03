//
//  EventCreateViewController.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/21.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class EventCreateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StoreSubscriber, Routable {

    static let identifier = "EventCreateViewController"

    @IBOutlet weak var tableView: UITableView!

    let sections = ["日時", "イベント名", "場所"]

    init() {
        super.init(nibName: "EventCreateViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupHeader()
        self.setupTableView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        store.subscribe(self) { (state :AppState) -> EventCreateState in
            return state.eventCreateState
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

    func newState(state: EventCreateState) {
        self.tableView.reloadData()
    }

    // MARK: - private

    private func setupHeader() {
        self.navigationItem.title = "イベントをつくる"

        let backButton = UIBarButtonItem(title: "<", style: .Plain,
                                         target: self, action: #selector(EventCreateViewController.back))
        self.navigationItem.leftBarButtonItem = backButton

        let createButton = UIBarButtonItem(barButtonSystemItem: .Done,
                                           target: self, action: #selector(EventCreateViewController.doneButtonTapped))
        self.navigationItem.rightBarButtonItems = [createButton]
    }

    private func setupTableView() {
        self.tableView.separatorStyle = .None
        self.tableView.scrollEnabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func back() {
        store.dispatch(
            SetRouteAction([
                RootIdentifier
                ])
        )
    }

    func doneButtonTapped() {
        if store.state.eventCreateState.date == nil || store.state.eventCreateState.name == nil {
            let alert = UIAlertController(title: nil, message: "未入力の項目があります", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated:true, completion:nil)
            return
        }

        let event = Event(identifier: 1, name: store.state.eventCreateState.name!, chatCount: 0)
        APIManager.sharedInstance.postEvent(event) {
            store.dispatch(CreateEventResetAction())
            store.dispatch(
                SetRouteAction([
                    RootIdentifier
                    ])
            )
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            store.dispatch(
                SetRouteAction([
                    RootIdentifier,
                    EventCreateViewController.identifier,
                    DateSettingViewController.identifier
                    ])
            )
            break
        case 1:
            let textSetDoneHandler = {(text :String) in
                store.dispatch(SetRouteAction([
                    RootIdentifier,
                    EventCreateViewController.identifier
                    ]))
                store.dispatch(CreateEventNameAction(name: text))
            }
            let route = [RootIdentifier,
                         EventCreateViewController.identifier,
                         TextInputViewController.identifier]
            store.dispatch(SetRouteSpecificData(route: route, data: textSetDoneHandler))
            store.dispatch(SetRouteAction(route))
            break
        case 2: break
        default: break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
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
        return self.sections.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            if (store.state.eventCreateState.date != nil) {
                cell.textLabel?.text = store.state.eventCreateState.date!.convertToString()
                cell.textLabel?.textColor = UIColor.darkGrayColor()
            } else {
                cell.textLabel?.text = "日時を設定します"
                cell.textLabel?.textColor = UIColor.lightGrayColor()
            }
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            break
        case 1:
            if (store.state.eventCreateState.name != nil) {
                cell.textLabel?.text = store.state.eventCreateState.name!
                cell.textLabel?.textColor = UIColor.darkGrayColor()
            } else {
                cell.textLabel?.text = "イベント名を設定します"
                cell.textLabel?.textColor = UIColor.lightGrayColor()
            }
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            break
        case 2:
            cell.textLabel?.text = " ※ 現在地が設定されます"
            cell.textLabel?.textColor = UIColor.grayColor()
            cell.selectionStyle = .None
            break
        default: break
        }
        return cell
    }

}
