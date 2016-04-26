//
//  EventListTableViewController.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit

class EventListTableViewController: UITableViewController {

    var events = [Event]()
    var type :EventSearchType = .Location
    var page = 0
    var isLoading = false
    var isRefreshing = false
    var isLastPage = false

    init() {
        super.init(nibName: "EventListTableViewController", bundle: nil)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - private

    private func setupTableView() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(EventListTableViewController.refresh), forControlEvents: .ValueChanged)
        self.refreshControl = refresh
    }

    private func load() {
        switch self.type {
        case .Location:
            self.isLoading = true
            APIManager.sharedInstance.getEvents(Location(), page: self.page, handler: { (events, isLastPage) in
                // TODO: weakself
                self.refreshControl?.endRefreshing()
                self.isLoading = false
                if self.page == 0 {
                    self.events = []
                }
                self.events.appendContentsOf(events)
                self.page = self.page.successor()
                self.isLastPage = isLastPage
                self.tableView.reloadData()
            })
            break
        case .History:
            self.isLoading = true
            APIManager.sharedInstance.getEvents(0, page: self.page, handler: { (events) in
                // TODO: weakself
                self.refreshControl?.endRefreshing()
                self.isLoading = false
                if self.page == 0 {
                    self.events = []
                }
                self.events.appendContentsOf(events)
                self.page = self.page.successor()
                self.isLastPage = true
                self.tableView.reloadData()
            })
            break
        }

    }

    func refresh() {
        self.page = 0
        self.load()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.events.count == 0 {
            return 0
        }

        if self.isLastPage {
            return self.events.count
        } else {
            return self.events.count + 1
        }

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        if indexPath.row == self.events.count {
            let cell = InfiniteLoadingCell.instantiate()
            return cell
        }

        let cell = EventTableViewCell.instantiate()
        cell.setEvent(self.events[indexPath.row])
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
        let vc = ChatListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Table view delegate

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return EventTableViewCell.cellHeight()
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell is InfiniteLoadingCell {
            if !self.isLoading {
                self.load()
            }
        }
    }
    
}
