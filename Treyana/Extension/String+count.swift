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
        let alpha = self.filter { $0.isLetter }
        
        return alpha.count
    }
    
    var numericCount: Int {
        let numericString = self.filter { $0.isNumber }
        
        return numericString.count
    }
    
    var specialCharacterCount: Int {
        var specialCharacters = self.filter { $0.isPunctuation }
        let symbol = self.filter { $0.isSymbol }
        specialCharacters.append(symbol)
        
        return specialCharacters.count
    }
}
