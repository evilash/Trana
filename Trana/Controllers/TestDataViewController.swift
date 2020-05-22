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
        
        titleTextField.text = titleString
        testDataTextView.text = testString
    }
}
