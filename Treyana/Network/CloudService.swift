//
//  CloudService.swift
//  Treyana
//
//  Created by Matt M Smith on 6/8/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation
import CloudKit

struct CloudService {
    func saveToCloud(url: URL) {
        let record = CKRecord(recordType: Constants.Cloud.recordType)
        let container = CKContainer.default()
        let database = container.privateCloudDatabase
        
        record[Constants.Cloud.testStrings] = CKAsset(fileURL: url)
        
        database.save(record) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
}
