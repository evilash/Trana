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
    @IBOutlet weak var stringCountLabel: UILabel!
    @IBOutlet weak var alphaCountLabel: UILabel!
    @IBOutlet weak var numberCounterLabel: UILabel!
    @IBOutlet weak var symbolCounterLabel: UILabel!
    
    var titleString = ""
    var testString = ""
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postNotification()
        
        view.backgroundColor = .randomBackgroundColor
        
        testDataTextView.delegate = self
        
        titleTextField.text = titleString
        testDataTextView.text = testString
        
        displayStringCounts(from: testString)
    }
}

extension TestDataViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            displayStringCounts(from: text)
        } else {
            stringCountLabel.text = "Cannot get data. Please try again later"
        }
    }
}

extension TestDataViewController {
    fileprivate func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    fileprivate func displayStringCounts(from str: String) {
        stringCountLabel.text = "string count: \(str.count)"
        alphaCountLabel.text = "alpha count: \(str.alphaCount)"
        numberCounterLabel.text = "number count: \(str.numericCount)"
        symbolCounterLabel.text = "symbol count: \(str.specialCharacterCount)"
    }
}
