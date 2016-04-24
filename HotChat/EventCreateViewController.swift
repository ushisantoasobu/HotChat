//
//  EventCreateViewController.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/21.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit

class EventCreateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var date :NSDate?
    var name :String?
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - private

    private func setupHeader() {
        self.navigationItem.title = "イベントをつくる"

        let createButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                           target: self, action: #selector(EventCreateViewController.doneButtonTapped))
        self.navigationItem.rightBarButtonItems = [createButton]
    }

    private func setupTableView() {
        self.tableView.separatorStyle = .None
        self.tableView.scrollEnabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func doneButtonTapped() {
        if self.date == nil || self.name == nil {
            let alert = UIAlertController(title: nil, message: "未入力の項目があります", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated:true, completion:nil)
            return
        }

        self.navigationController?.popViewControllerAnimated(true)
    }

    // MARK: - UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            let vc = DateSettingViewController()
            vc.initialDate = self.date
            vc.dateSetDone = {(date :NSDate) in
                // TODO: weakself
                self.navigationController?.popViewControllerAnimated(true)
                self.date = date
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = TextInputViewController()
            vc.textSetDone = {(text :String) in
                // TODO: weakself
                self.navigationController?.popViewControllerAnimated(true)
                self.name = text
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
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
            if (self.date != nil) {
                cell.textLabel?.text = self.date?.convertToString()
                cell.textLabel?.textColor = UIColor.darkGrayColor()
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            } else {
                cell.textLabel?.text = "日時を設定します"
                cell.textLabel?.textColor = UIColor.lightGrayColor()
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            }
            break
        case 1:
            if (self.name != nil) {
                cell.textLabel?.text = self.name!
                cell.textLabel?.textColor = UIColor.darkGrayColor()
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            } else {
                cell.textLabel?.text = "イベント名を設定します"
                cell.textLabel?.textColor = UIColor.lightGrayColor()
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            }
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
