//
//  AlertViewController.swift
//  HotChat
//
//  Created by SatoShunsuke on 2016/05/03.
//  Copyright © 2016年 moguraproject. All rights reserved.
//

import UIKit
import ReSwiftRouter

protocol AlertViewControllerDelegate {
    func alertViewButtonTapped()
}

class AlertViewController: UIViewController, Routable {

    static let identifier = "AlertViewController"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    var delegate :AlertViewControllerDelegate?

    init() {
        super.init(nibName: "AlertViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupAppearance()

        self.titleLabel.text = "ありがとうございます！"
        self.messageLabel.text = "新しいイベントを登録しました"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - private

    private func setupAppearance() {
        self.titleLabel.textColor = UIColor.mainColor()
        self.button.backgroundColor = UIColor.mainColor()
        self.button.tintColor = UIColor.whiteColor()
    }

    // MARK: - IB actions

    @IBAction func buttonTapped(sender: AnyObject) {
        self.delegate?.alertViewButtonTapped()
    }


}
