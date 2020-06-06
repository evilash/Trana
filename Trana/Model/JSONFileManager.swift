//
//  JSONFileManager.swift
//  Trana
//
//  Created by Matt M Smith on 5/15/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

struct JSONFileManager {
    let fileURL: URL? = {
        do {
            let url = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(Constants.File.name)
            print(url)
            
            return url
        } catch {
            print(error)
            return nil
        }
    }()
    
    func createNewJSONFile() {
        guard let url = fileURL else { return }
        
        if FileManager.default.contents(atPath: url.relativePath) == nil {
            let message = "Thank you for using Trana. The true power of Trana comes from allowing iCloud to share your test data between devices."
            let rgbValues = RGBValues(r: 0.0, g: 0.0, b: 0.0)
            let stringData = StringData(id: 0, title: "Trana", testString: message, color: [rgbValues])
            
            writeToFile(with: [stringData])
        }
    }
    
    func writeToFile(with stringDataArray: [StringData]) {
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
