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
    
    let testDataManager = TestDataManager()
    
    var titleString = ""
    var testString = ""
    var id = 0
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postNotification()
        
        view.backgroundColor = .randomBackgroundColor
        
        titleTextField.delegate = self
        testDataTextView.delegate = self
        navigationController?.delegate = self
        
        titleTextField.text = titleString
        testDataTextView.text = testString
        
        displayStringCounts(for: testString)
    }
    
    fileprivate func writeString(_ string: String) {
        guard let index = testDataManager.stringDataArray.firstIndex(where: {$0.id == id}) else { return }
        testDataManager.writeTestString(to: index, with: string)
    }
    
    fileprivate func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    fileprivate func displayStringCounts(for str: String) {
        stringCountLabel.text = "string count: \(str.count)"
        alphaCountLabel.text = "alpha count: \(str.alphaCount)"
        numberCounterLabel.text = "number count: \(str.numericCount)"
        symbolCounterLabel.text = "symbol count: \(str.specialCharacterCount)"
    }

    @objc func doneTapped() {
        testDataTextView.resignFirstResponder()
    }
}

extension TestDataViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension TestDataViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            writeString(text)
            displayStringCounts(for: text)
        } else {
            stringCountLabel.text = "Cannot get data. Please try again later"
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let bar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        
        bar.items = [done]
        bar.sizeToFit()
        textView.inputAccessoryView = bar
        
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        
        return true
    }
}

extension TestDataViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.isKind(of: TestDataTableViewController.self) {
            let viewController = viewController as! TestDataTableViewController
            
            testDataManager.writeTitle(to: id, with: titleTextField.text!)
            viewController.testDataTableView.reloadData()
        }
    }
}
