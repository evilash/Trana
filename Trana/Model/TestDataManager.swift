//
//  TestDataManager.swift
//  Trana
//
//  Created by Matt M Smith on 5/7/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

struct TestDataManager {
    private let jsonFileManager = JSONFileManager()
    
    var arrayCount: Int {
        guard let testData = getTestData() else { return 0 }
        
        return testData.stringDataArray.count
    }
    
    func createNewTestDataSet() {
        let newStringDataArray = returnNewStringDataArray { (stringDataArray) in
            let lastID = stringDataArray.last?.id ?? 0
            let id = stringDataArray.count != 0 ? lastID + 1 : 0
            let rgbValues = RGBValues(r: 1.1, g: 2.2, b: 3.3)
            let stringData = StringData(id: id, title: "test", testString: "testing", color: [rgbValues])
            
            return stringData
        }

        jsonFileManager.writeToFile(with: newStringDataArray)
    }
    
    func getTitle(from index: Int) -> String {
        let title = getStringData(from: index) { (stringData) in
            let titleFromArray = stringData.title
            let title = !titleFromArray.isEmpty ? titleFromArray : "Test Set \(stringData.id)"
            return title
        }
        
        return title
    }
    
    func getTestString(from index: Int) -> String {
        let testString = getStringData(from: index) { $0.testString }
        
        return testString
    }
    
    private func getStringData(from index: Int, closure: (StringData) -> String) -> String {
        guard let testData = getTestData() else { return "" }
        let string = closure(testData.stringDataArray[index])
        
        return string
    }
    
    private func returnNewStringDataArray(closure: ([StringData]) -> StringData) -> [StringData] {
        var stringDataArray = [StringData]()

        if var testData = getTestData() {
            let stringData = closure(testData.stringDataArray)
            testData.stringDataArray.append(stringData)
            
            stringDataArray = testData.stringDataArray
        }
        
        return stringDataArray
    }

    private func getTestData() -> TestData? {
        guard let url = jsonFileManager.fileURL else { return nil }
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
