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
        
    var testData: String? {
        guard let testDataString = testDataTextView.text else { return nil }
        
        return testDataString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .randomBackgroundColor
    }

}
