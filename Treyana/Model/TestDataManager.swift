//
//  TestDataManager.swift
//  Treyana
//
//  Created by Matt M Smith on 5/7/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

enum JsonError: Error {
    case cantFindFile
    case cantDecodeFile
}

struct TestDataManager {
    fileprivate let jsonFileManager = JSONFileManager()
    
    var stringDataArray: [StringData] {
        var strArray = [StringData]()
        
        do {
            let testData = try getTestData()
            strArray = testData.stringDataArray
        } catch {
            print(error.localizedDescription)
        }
        
        return strArray
    }
        
    //MARK: - Public functions
    func createNewTestDataSet() {
        let newStringDataArray = returnNewStringDataArray { (stringDataArray) in
            let lastID = stringDataArray.last?.id ?? 0
            let id = stringDataArray.count != 0 ? lastID + 1 : 0
            let stringData = StringData(id: id, title: "Test Set \(id)", testString: "")
            
            stringDataArray.append(stringData)
            
            return stringDataArray
        }

        jsonFileManager.writeToFile(with: newStringDataArray)
    }
    
    func writeTitle(to index: Int, with text: String) {
        let newStringDataArray = returnNewStringDataArray { (stringDataArray) -> [StringData] in
            stringDataArray[index].title = text
            
            return stringDataArray
        }
        
        jsonFileManager.writeToFile(with: newStringDataArray)
    }
    
    func writeTestString(to index: Int, with text: String) {
        let newStringDataArray = returnNewStringDataArray { (stringDataArray) -> [StringData] in
            stringDataArray[index].testString = text
            
            return stringDataArray
        }
        
        jsonFileManager.writeToFile(with: newStringDataArray)
    }
    
    func deleteData(from index: Int) {
        let newStringDataArray = returnNewStringDataArray { (stringArray) in
            stringArray.remove(at: index)
            let updatedArrayWithIds = updateIds(for: stringArray)

            return updatedArrayWithIds
        }
        
        jsonFileManager.writeToFile(with: newStringDataArray)
    }
    
    //MARK: - Private functions
    fileprivate func updateIds(for array: [StringData]) -> [StringData] {
        var strArray = array
        
        for index in 0..<strArray.count where strArray[index].id != index {
            strArray[index].id = index
        }

        return strArray
    }
    
    fileprivate func returnNewStringDataArray(closure: (inout [StringData]) -> [StringData]) -> [StringData] {
        var stringDataArray = [StringData]()

        do {
            var testData = try getTestData()
            stringDataArray = closure(&testData.stringDataArray)
        } catch {
            print(error.localizedDescription)
        }
            
        return stringDataArray
    }

    fileprivate func getTestData() throws -> TestData {
        guard let url = jsonFileManager.fileURL else { throw JsonError.cantFindFile }
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            let testData = try decoder.decode(TestData.self, from: data)

            return testData
        } catch {
            throw JsonError.cantDecodeFile
        }
    }
}

extension JsonError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cantDecodeFile:
            return NSLocalizedString("The file cannot be decoded", comment: "")
        case .cantFindFile:
            return NSLocalizedString("The file cannot be found", comment: "")
        }
    }
}
