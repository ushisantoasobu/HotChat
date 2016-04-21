//
//  SearchStartViewController.swift
//  HotChat
//
//  Created by 佐藤 俊輔 on 2016/04/20.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit

class SearchStartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHeader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - private

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
        print("user")

    }

    func createButtonTapped() {
        print("create")

    }
    

    // MARK: - IB actions

    @IBAction func locationButtonTapped(sender: AnyObject) {
        let vc = EventListTableViewController()
        vc.type = .Location
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func historyButtonTapped(sender: AnyObject) {
        let vc = EventListTableViewController()
        vc.type = .History
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
