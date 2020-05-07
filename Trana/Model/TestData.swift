//
//  TestData.swift
//  Trana
//
//  Created by Matt M Smith on 5/6/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

struct StringData {
    let stringData: [TestData]
}

struct TestData: Codable {
    let id: Int
    let title: String
    let testString: String
    let color: String
}
