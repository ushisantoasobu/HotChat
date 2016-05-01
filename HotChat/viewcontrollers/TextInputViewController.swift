//
//  TextInputViewController.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/04/23.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit

class TextInputViewController: UIViewController {

    static let identifier = "TextInputViewController"

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var counterLabel: UILabel!

    var initialString :String?
    var maxCharCount :Int?
    var textSetDone :((String) -> Void)?

    init() {
        super.init(nibName: "TextInputViewController", bundle: nil)
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

        let createButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                           target: self, action: #selector(TextInputViewController.doneButtonTapped))
        self.navigationItem.rightBarButtonItems = [createButton]
    }

    func doneButtonTapped() {
        if self.textSetDone != nil {
            store.dispatch(CreateEventNameAction(name: self.textField.text!))
            self.textSetDone!(self.textField.text!)
        }
    }


}
