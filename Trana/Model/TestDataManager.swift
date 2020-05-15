//
//  TestDataManager.swift
//  Trana
//
//  Created by Matt M Smith on 5/7/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

struct TestDataManager {
    
    private let fileURL: URL? = {
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
        let jsonTemplate = ["stringData":[["id": 0, "title": "Test", "testString": "testing", "color": [["r": 0.0, "g": 0.0, "b": 0.0]]]]]
            
            do {
                let data = try JSONSerialization.data(withJSONObject: jsonTemplate, options: .prettyPrinted)

                try data.write(to: url, options: .atomic)
            } catch {
                print(error)
            }
        }
    }
    
    func createNewTestDataSet() {
        guard let testData = getTestData() else { return }
        guard let url = fileURL else { return }
        var stringDataArray = testData.stringData
        guard let lastID = stringDataArray.last?.id else { return }
        let id = stringDataArray.count != 0 ? lastID + 1 : 0
        let rgbValues = RGBValues(r: 1.1, g: 2.2, b: 3.3)
        let stringData = StringData(id: id, title: "test", testString: "testing", color: [rgbValues])
        
        stringDataArray.append(stringData)

        let newTestDataObject = TestData(stringData: stringDataArray)
        
        do {
            let encode = JSONEncoder()
            try encode.encode(newTestDataObject).write(to: url)
            
        } catch {
            print(error)
        }
    }
    
    private func getTestData() -> TestData? {
        guard let url = fileURL else { return nil }
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            let testData = try decoder.decode(TestData.self, from: data)

            return testData
        } catch {
            print(error)
            return nil
        }
    }
}
