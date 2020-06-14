//
//  TestData.swift
//  Treyana
//
//  Created by Matt M Smith on 5/6/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

struct TestData: Codable {
    var stringDataArray: [StringData]
    
    enum CodingKeys: String, CodingKey {
        case stringDataArray = "stringData"
    }
}

struct StringData: Codable {
    var id: Int
    var title: String
    var testString: String
}
