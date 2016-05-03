//
//  TextInputViewController.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/23.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit
import ReSwiftRouter

class TextInputViewController: UIViewController, Routable {

    static let identifier = "TextInputViewController"

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var counterLabel: UILabel!

    var initialString :String?
    var maxCharCount :Int?
    var textSetDone :((String) -> Void)?

    init() {
        super.init(nibName: "TextInputViewController", bundle: nil)

        let route = store.state.navigationState.route

        // MEMO : こんなんでいいのか・・・いいはずがないw
        if route == [RootIdentifier, EventCreateViewController.identifier, TextInputViewController.identifier] {
            self.textSetDone = store.state.navigationState.getRouteSpecificState([
                RootIdentifier,
                EventCreateViewController.identifier,
                TextInputViewController.identifier
                ])
        } else if route == [RootIdentifier, AccountEditViewController.identifier, TextInputViewController.identifier] {
            self.textSetDone = store.state.navigationState.getRouteSpecificState([
                RootIdentifier,
                AccountEditViewController.identifier,
                TextInputViewController.identifier
                ])
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupHeader()

        self.counterLabel.hidden = (self.maxCharCount == nil)

        self.textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - private

    private func setupHeader() {
        self.navigationItem.title = "テキストを入力する"

        let backButton = UIBarButtonItem(title: "<", style: .Plain,
                                         target: self, action: #selector(TextInputViewController.back))
        self.navigationItem.leftBarButtonItem = backButton

        let createButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                           target: self, action: #selector(TextInputViewController.doneButtonTapped))
        self.navigationItem.rightBarButtonItems = [createButton]
    }

    func back() {
        // MEMO : ??? こんなことしなくちゃいけない？？ 上でも似たことやってるね、、、ここはおれの設計ミスか
        let route = store.state.navigationState.route
        if route == [RootIdentifier, EventCreateViewController.identifier, TextInputViewController.identifier] {
            store.dispatch(SetRouteAction([
                RootIdentifier,
                EventCreateViewController.identifier
                ]))
        } else if route == [RootIdentifier, AccountEditViewController.identifier, TextInputViewController.identifier] {
            store.dispatch(SetRouteAction([
                RootIdentifier,
                AccountEditViewController.identifier
                ]))
        }
    }

    func doneButtonTapped() {
        if self.textSetDone != nil {
            self.textSetDone!(self.textField.text!)
        }
    }


}
