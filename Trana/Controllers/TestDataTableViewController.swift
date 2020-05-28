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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedRow = selectedRow {
            let destination = segue.destination as! TestDataViewController
            
            destination.titleString = testDataManager.stringDataArray[selectedRow].title
            destination.testString = testDataManager.stringDataArray[selectedRow].testString
            
            self.selectedRow = nil
        }
    }
}
