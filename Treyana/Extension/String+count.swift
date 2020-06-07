//
//  String+count.swift
//  Treyana
//
//  Created by Matt M Smith on 5/26/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation

extension String {
    var alphaCount: Int {
        let str = self.filter { $0.isLetter }
        
        return str.count
    }
    
    var numericCount: Int {
        let str = self.filter { $0.isNumber }
        
        return str.count
    }
    
    var specialCharacterCount: Int {
        var str = self.filter { $0.isPunctuation }
        let symbol = self.filter { $0.isSymbol }
        str.append(symbol)
        
        return str.count
    }
}
