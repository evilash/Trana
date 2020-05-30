//
//  TestDataTableViewController.swift
//  Trana
//
//  Created by Matt M Smith on 5/6/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import UIKit

class TestDataTableViewController: UIViewController {
    @IBOutlet weak var testDataTableView: UITableView!
    
    let testDataManager = TestDataManager()
    var selectedRow: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableReload()
        
        testDataTableView.dataSource = self
        testDataTableView.delegate = self
    }
    
    @IBAction func pressedAddData(_ sender: UIBarButtonItem) {
        testDataManager.createNewTestDataSet()
        performSegue(withIdentifier: "ListToData", sender: self)
    }
}

extension TestDataTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDataManager.stringDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.cellID, for: indexPath)
        cell.textLabel?.text = testDataManager.stringDataArray[indexPath.row].title
        
        return cell
    }
}

extension TestDataTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "ListToData", sender: self)
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            testDataManager.deleteData(from: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TestDataViewController
        
        if let selectedRow = selectedRow {
            let title = testDataManager.stringDataArray[selectedRow].title
            
            destination.titleString = !title.isEmpty ? title : "Test Set: \(selectedRow)"
            destination.testString = testDataManager.stringDataArray[selectedRow].testString
            destination.id = testDataManager.stringDataArray[selectedRow].id
            
            self.selectedRow = nil
        } else {
            destination.id = testDataManager.stringDataArray.count - 1
        }
    }
}

extension TestDataTableViewController {
    fileprivate func tableReload() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc fileprivate func loadList(notification: NSNotification){
        testDataTableView.reloadData()
    }
}
