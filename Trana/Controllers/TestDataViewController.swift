//
//  TestDataViewController.swift
//  Trana
//
//  Created by Matt M Smith on 5/6/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import UIKit

class TestDataViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var testDataTextView: UITextView!
    @IBOutlet weak var counterLabel: UILabel!
    
    var titleString = ""
    var testString = ""
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .randomBackgroundColor
        
        testDataTextView.delegate = self
        
        titleTextField.text = titleString
        testDataTextView.text = testString
    }
}

extension TestDataViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            counterLabel.text = "counter: \(text.count)"
        } else {
            counterLabel.text = "Cannot get data. Please try again later"
        }
    }
}
