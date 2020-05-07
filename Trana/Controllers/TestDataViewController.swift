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
        
    var testData: String? {
        guard let testDataString = testDataTextView.text else { return nil }
        
        return testDataString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .randomBackgroundColor
        
        testDataTextView.delegate = self
    }

}

extension TestDataViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let text = testData {
            counterLabel.text = !text.isEmpty ? "counter: \(text.count)" : "counter: "
        } else {
            counterLabel.text = "Cannot get data. Please try again later"
        }
    }
}
