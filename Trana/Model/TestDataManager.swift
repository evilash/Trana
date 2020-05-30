//
//  TestDataManager.swift
//  Trana
//
//  Created by Matt M Smith on 5/7/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

struct TestDataManager {
    fileprivate let jsonFileManager = JSONFileManager()
    
    var stringDataArray: [StringData] {
        var strArray = [StringData]()
        
        if let testData = getTestData() {
            strArray = testData.stringDataArray
        }
        
        return strArray
    }
        
    //MARK: - Public functions
    func createNewTestDataSet() {
        let newStringDataArray = returnNewStringDataArray { (stringDataArray) in
            let lastID = stringDataArray.last?.id ?? 1
            let id = stringDataArray.count != 0 ? lastID + 1 : 1
            let rgbValues = RGBValues(r: 1.1, g: 2.2, b: 3.3)
            let stringData = StringData(id: id, title: "test set \(id)", testString: "testing", color: [rgbValues])
            
            stringDataArray.append(stringData)
            
            return stringDataArray
        }

        jsonFileManager.writeToFile(with: newStringDataArray)
    }
    
    func writeData(to index: Int, with text: String) {
        let newStringDataArray = returnNewStringDataArray { (stringDataArray) -> [StringData] in
            stringDataArray[index].testString = text
            
            return stringDataArray
        }
        
        jsonFileManager.writeToFile(with: newStringDataArray)
    }
    
    func deleteData(from index: Int) {
        let newStringDataArray = returnNewStringDataArray { (stringArray) in
            stringArray.remove(at: index)
            return stringArray
        }
        
        jsonFileManager.writeToFile(with: newStringDataArray)
    }
    
    //MARK: - Private functions
    fileprivate func getStringData(from index: Int, closure: (StringData) -> String) -> String {
        guard let testData = getTestData() else { return "" }
        let string = closure(testData.stringDataArray[index])
        
        return string
    }
    
    fileprivate func returnNewStringDataArray(closure: (inout [StringData]) -> [StringData]) -> [StringData] {
        var stringDataArray = [StringData]()

        if var testData = getTestData() {
            stringDataArray = closure(&testData.stringDataArray)
        }
        
        return stringDataArray
    }

    fileprivate func getTestData() -> TestData? {
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
