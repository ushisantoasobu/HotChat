//
//  EventListTableViewController.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit
import ReSwift

class EventListTableViewController: UITableViewController, StoreSubscriber {

    init(type :EventSearchType) {
        super.init(nibName: "EventListTableViewController", bundle: nil)

        store.dispatch(EventListChangeTypeAction(type: type))
        store.dispatch(EventListResetEventsAction())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        self.setupTableView()

        self.load()
    }

//    deinit {
//        store.dispatch(EventListResetEventsAction())
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        store.subscribe(self) { (state :AppState) -> AppState in
            return state
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        store.unsubscribe(self)
    }

    // MARK: - ReSwift

    func newState(state: AppState) {

        // MEMO : 再描画不要のstate変更はどうすればいいのだろう？？？

        print("new state !!!!!!!!!!!!!!!!!!!!!!!!!!!")

        self.tableView.reloadData() // 何回もreloaddatea走ってるっぽい！！これはninjinkunの言ってたことだと思う > < 
    }

    // MARK: - private

    private func setupTableView() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(EventListTableViewController.refresh), forControlEvents: .ValueChanged)
        self.refreshControl = refresh

        self.tableView.tableFooterView = UIView(frame: CGRectZero) // 空のセルの線を消す
    }

    // MEMO : この引数微妙かな・・・またはこれもstateでもてる？？ listをoptionalにしてそこで判定とか
    private func load(type :LoadingType = .Normal) {
        if store.state.eventListState.type == nil {
            return
        }

        let page = store.state.eventListState.paging.num
        switch store.state.eventListState.type! {
        case .Location:
            store.dispatch(LoadingShowAction(type: type))
            APIManager.sharedInstance.getEvents(Location(), page: page, handler: { (events, isLastPage) in
                // TODO : weakself
                self.refreshControl?.endRefreshing()
                store.dispatch(LoadingHideAction())

                // MEMO : ここイケてない？？
                if page == 0 {
                    store.dispatch(EventListResetEventsAction())
                }

                store.dispatch(EventListAddEventsAction(events: events))
                store.dispatch(EventListSuccessorPageAction(isLast: isLastPage))
            })
            break
        case .History:
            store.dispatch(LoadingShowAction(type: type))
            APIManager.sharedInstance.getEvents(0, page: page, handler: { (events) in
                // TODO: weakself
                self.refreshControl?.endRefreshing()
                store.dispatch(LoadingHideAction())

                // MEMO : ここイケてない？？
                if page == 0 {
                    store.dispatch(EventListResetEventsAction())
                }

                store.dispatch(EventListAddEventsAction(events: events))
                store.dispatch(EventListSuccessorPageAction(isLast: true))
            })
            break
        }

    }

    func refresh() {
        store.dispatch(EventListResetEventsAction())
        self.load(.StatusBar)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let events = store.state.eventListState.events ?? []
        if events.count == 0 {
            return 0
        }

        if store.state.eventListState.paging.isLast {
            return events.count
        } else {
            return events.count + 1
        }

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        let events = store.state.eventListState.events ?? []
        if indexPath.row == events.count {
            let cell = InfiniteLoadingCell.instantiate()
            return cell
        }

        let cell = EventTableViewCell.instantiate()
        cell.setEvent(events[indexPath.row])
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - XXXXX

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = ChatListViewController(event: store.state.eventListState.events![indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Table view delegate

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return EventTableViewCell.cellHeight()
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell is InfiniteLoadingCell {
            if store.state.loadingState.isLoading != true {
                self.load(.StatusBar)
            }
        }
    }
    
}
