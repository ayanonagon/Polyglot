//
//  ViewController.swift
//  Polyglot
//
//  Created by Ayaka Nonaka on 7/27/14.
//  Copyright (c) 2014 Ayaka Nonaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var translator: Polyglot?

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var translationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.translator = Polyglot(clientId: "YOUR_CLIENT_ID", clientSecret: "YOUR_CLIENT_SECRET")
    }

    @IBAction func didTapTranslateButton(sender: AnyObject) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.translator?.translate(self.inputTextField.text) { translation in
            dispatch_async(dispatch_get_main_queue(), {
                if let language = self.translator?.fromLanguage?.rawValue {
                    self.translationLabel.text = "Translated from \(language.capitalizedString): \(translation)"
                }
                else {
                    self.translationLabel.text = translation
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
        }
    }
}
