//
//  SearchStartViewController.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit
import ReSwiftRouter

class SearchStartViewController: UIViewController, Routable {

    static let identifier = "SearchStartViewController"

    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!

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
        self.locationButton.backgroundColor = UIColor.mainColor()
        self.historyButton.backgroundColor = UIColor.mainColor()
    }

    private func setupHeader() {
        self.navigationItem.title = "イベントを探す"

        let userButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit,
                                         target: self, action: #selector(SearchStartViewController.userButtonTapped))
        self.navigationItem.leftBarButtonItem = userButton

        let createButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add,
                                         target: self, action: #selector(SearchStartViewController.createButtonTapped))
        self.navigationItem.rightBarButtonItems = [createButton]
    }

    func userButtonTapped() {
        store.dispatch(
            SetRouteAction([
                "UINavigationController",
                AccountEditViewController.identifier
            ])
        )
    }

    func createButtonTapped() {

        store.dispatch(
            SetRouteSpecificData(route: ["UINavigationController", EventCreateViewController.identifier],
                data: 3)
        )

        store.dispatch(
            SetRouteAction([
                "UINavigationController",
                EventCreateViewController.identifier
            ])
        )

    }


    // MARK: - IB actions

    @IBAction func locationButtonTapped(sender: AnyObject) {
        let vc = EventListTableViewController(type: .Location)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func historyButtonTapped(sender: AnyObject) {
        let vc = EventListTableViewController(type: .History)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
