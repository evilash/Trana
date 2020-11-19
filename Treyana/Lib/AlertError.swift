//
//  AlertError.swift
//  Treyana
//
//  Created by Matt M Smith on 11/18/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

enum AlertError: String, Error {
    case title = "ERROR"
    case nilArray = "The array has returned nil"
    case emptyCount = "The array has a count of nil"
    case missingTitle = "The cell is missing a title"
}
