//
//  DateSettingViewController.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/23.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit
import ReSwiftRouter


class DateSettingViewController: UIViewController, Routable {

    static let identifier = "DateSettingViewController"

    @IBOutlet private weak var datePicker: UIDatePicker!

    var initialDate :NSDate?
    var dateSetDone :((NSDate) -> Void)?

    init() {
        super.init(nibName: "DateSettingViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupHeader()
        self.setupPicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - private

    private func setupHeader() {
        self.navigationItem.title = "日時を設定する"

        let backButton = UIBarButtonItem(title: "<", style: .Plain,
                                         target: self, action: #selector(TextInputViewController.back))
        self.navigationItem.leftBarButtonItem = backButton

        let createButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                           target: self, action: #selector(DateSettingViewController.doneButtonTapped))
        self.navigationItem.rightBarButtonItems = [createButton]
    }

    private func setupPicker() {
        self.datePicker.minimumDate = NSDate()
        if self.initialDate != nil {
            self.datePicker.date = self.initialDate!
        }
    }

    func back() {
        store.dispatch(SetRouteAction([
            AppDelegate.rootIdentifier,
            EventCreateViewController.identifier
            ]))
    }

    func doneButtonTapped() {
        if self.dateSetDone != nil {
            // MEMO: あれ、ここのActionのdispatchって、、、こういった汎用的な画面のときどうするのがいいんだろう
            store.dispatch(CreateEventDateAction(date: self.datePicker.date))
            self.dateSetDone!(self.datePicker.date)
        }
    }
}
