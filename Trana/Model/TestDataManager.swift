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
            let url = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(Constants.File.name)

            return url
        } catch {
            print(error)
            return nil
        }
    }
    
    static func createNewJSONFile() {
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
