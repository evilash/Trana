//
//  TestDataListViewController.swift
//  Trana
//
//  Created by Matt M Smith on 5/6/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import UIKit

class TestDataListViewController: UIViewController {
    @IBOutlet weak var testDataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testDataTableView.dataSource = self
        testDataTableView.delegate = self
    }
    
    @IBAction func pressedAddData(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: SegueIdentifier.listToData, sender: self)
    }
}

extension TestDataListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}

extension TestDataListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
