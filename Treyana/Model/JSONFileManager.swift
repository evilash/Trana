//
//  JSONFileManager.swift
//  Treyana
//
//  Created by Matt M Smith on 5/15/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

struct JSONFileManager {
    static let fileURL: URL? = {
        do {
            let url = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(Constants.File.name)
            print(url)
            
            return url
        } catch {
            print(error)
            return nil
        }
    }()
    
    static func createNewJSONFile() {
        guard let url = fileURL else { return }
        
        if FileManager.default.contents(atPath: url.relativePath) == nil {
            let message = "Thank you for using Treyana. The true power of Treyana comes from allowing iCloud to share your test data between devices."
            let stringData = StringData(id: 0, title: "Treyana", testString: message)
            
            writeToFile(with: [stringData])
        }
    }
    
    static func writeToFile(with stringDataArray: [StringData]) {
        guard let url = fileURL else { return }
        let testData = TestData(stringDataArray: stringDataArray)
        let encoder = JSONEncoder()
        
        do {
            try encoder.encode(testData).write(to: url)
        } catch {
            print(error)
        }
    }
}
