//
//  TestDataManager.swift
//  Trana
//
//  Created by Matt M Smith on 5/7/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

struct TestDataManager {
    
    private static var jsonFileURL: URL? {
        do {
            let pathToDocumentDir = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let filePath = pathToDocumentDir.appendingPathComponent("TestData.json")
            
            return filePath
        } catch {
            print(error)
            return nil
        }
    }
    
    static func checkForJSONFile() {
        guard let filePath = jsonFileURL?.relativePath else { return }
        
        if !FileManager.default.fileExists(atPath: filePath) {
            createNewFile()
        }
    }
            
    private static func createNewFile() {
        let dataSkeleton: [String: Any] = ["testData": [["id": 1, "title": "", "testString": "", "color": ""]]]
        
        do {
            let jsonObject = try JSONSerialization.data(withJSONObject: dataSkeleton, options: .prettyPrinted)
            guard let url = jsonFileURL else { return }
            
            try jsonObject.write(to: url, options: .atomic)            
        } catch {
            print(error)
        }
    }
}
