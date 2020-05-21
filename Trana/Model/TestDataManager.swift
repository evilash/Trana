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
        guard let testData = getTestData() else { return "" }
        let stringDataArray = testData.stringDataArray[index]
        let titleFromArray = stringDataArray.title
        let title = !titleFromArray.isEmpty ? titleFromArray : stringDataArray.testString
        
        return title
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
