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
    private static let record = CKRecord(recordType: Constants.Cloud.recordType)
    
    static func saveToCloud(url: URL) {
        let container = CKContainer.default()
        let database = container.privateCloudDatabase
        
        record[Constants.Cloud.testStrings] = CKAsset(fileURL: url)
        
        database.save(record) { (_, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }
        }
    }
    
    static func loadTestData() {
        let savedRecord = Record()
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: Constants.Cloud.modificationDate, ascending: false)
        let query = CKQuery(recordType: Constants.Cloud.recordType, predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = [Constants.Cloud.modificationDate, Constants.Cloud.testStrings]
        operation.resultsLimit = 1
        
        operation.recordFetchedBlock = { cloudRecord in
            if let cloudDate = cloudRecord.modificationDate, let recordDate = record.modificationDate {
                if cloudDate > recordDate {
                    savedRecord.asset = cloudRecord[Constants.Cloud.testStrings]
                    if let oldFileURL = JSONFileManager.fileURL, let newFileURL = savedRecord.asset?.fileURL {
                        do {
                            _ = try FileManager.default.replaceItemAt(oldFileURL, withItemAt: newFileURL, backupItemName: nil, options: .usingNewMetadataOnly)
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        print("URL FAIL")
                    }
                }
            } else {
                print("DATE FAIL")
            }
        }
        
        operation.queryCompletionBlock = { _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
        
        CKContainer.default().privateCloudDatabase.add(operation)
    }
}
