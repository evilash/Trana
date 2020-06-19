//
//  TestDataViewController.swift
//  Treyana
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
        
        titleTextField.delegate = self
        testDataTextView.delegate = self
        navigationController?.delegate = self
        
        titleTextField.text = titleString
        testDataTextView.text = testString
        
        displayCounts(for: testString)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let url = JSONFileManager.fileURL else {
            let alert = UIAlertController(title: "ERROR", message: "File could not be found!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            
            present(alert, animated: true)
            
            return
        }
        
        CloudService.saveToCloud(url: url)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        displayShareSheet()
    }
}

// MARK: - TestDataViewController extension
extension TestDataViewController {
    fileprivate func writeString(_ string: String) {
        guard let index = testDataManager.stringDataArray?.firstIndex(where: {$0.id == id}) else { return }
        testDataManager.writeTestString(to: index, with: string)
    }
    
    fileprivate func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notification.name), object: nil)
    }
    
    fileprivate func displayCounts(for string: String) {
        stringCountLabel.text = "string count: \(string.count)"
        alphaCountLabel.text = "alpha count: \(string.alphaCount)"
        numberCounterLabel.text = "number count: \(string.numericCount)"
        symbolCounterLabel.text = "symbol count: \(string.specialCharacterCount)"
    }
    
    @objc func doneTapped() {
        testDataTextView.resignFirstResponder()
    }
    
    func displayShareSheet() {
        let infoToBeShared = [self]
        let activityViewController = UIActivityViewController(activityItems: infoToBeShared, applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [.addToReadingList, .assignToContact, .message, .openInIBooks, .postToFacebook, .postToFlickr, .postToVimeo, .postToWeibo, .postToTencentWeibo, .postToTwitter, .postToWeibo, .print, .saveToCameraRoll]
        
        present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate extension
extension TestDataViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

//MARK: - UITextViewDelegate extension
extension TestDataViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            writeString(text)
            displayCounts(for: text)
        } else {
            stringCountLabel.text = "Cannot get data. Please try again later"
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        
        toolbar.items = [done]
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
        
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        
        return true
    }
}

//MARK: - UINavigationControllerDelegate extension
extension TestDataViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.isKind(of: TestDataTableViewController.self) {
            let viewController = viewController as! TestDataTableViewController
            
            testDataManager.writeTitle(to: id, with: titleTextField.text!)
            viewController.testDataTableView.reloadData()
        }
    }
}

//MARK: - UIActivityItemSource extension
extension TestDataViewController: UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "Just needed something here"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        let stringCounts = """
            test string: \(testDataTextView.text!)
            
            \(stringCountLabel.text!)
            
            \(alphaCountLabel.text!)
            
            \(numberCounterLabel.text!)
            
            \(symbolCounterLabel.text!)
            """
        
        return stringCounts
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {

        return titleTextField.text!
    }
}
