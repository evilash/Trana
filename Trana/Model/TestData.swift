//
//  TestData.swift
//  Trana
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
    let id: Int
    let title: String
    var testString: String
    let color: [RGBValues]
}

struct RGBValues: Codable {
    let r: Double
    let g: Double
    let b: Double
}
