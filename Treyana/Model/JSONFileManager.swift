//
//  JSONFileManager.swift
//  Treyana
//
//  Created by Matt M Smith on 5/15/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

struct JSONFileManager {
    static let url: URL? = {
        let url = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(Constants.File.name)
        
        return url
    }()
    
    static func createNewJSONFile() {
        guard let url = url else { return }
        
        if FileManager.default.contents(atPath: url.relativePath) == nil {
            let stringData = StringData(id: 0, title: "Treyana", testString: Constants.Message.firstTime)
            
            writeToFile(with: [stringData])
        }
    }
    
    static func writeToFile(with stringDataArray: [StringData]) {
        guard let url = url else { return }
        let testData = TestData(stringDataArray: stringDataArray)
        let encoder = JSONEncoder()
        
        do {
            try encoder.encode(testData).write(to: url)
            cloudService.saveToCloud(url: url)
        } catch {
            print(error)
        }
    }
}
