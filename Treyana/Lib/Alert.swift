//
//  Alert.swift
//  Treyana
//
//  Created by Matt M Smith on 11/18/20.
//  Copyright © 2020 Matt. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    static func create(title: AlertError = .title, message: AlertError, vc: UIViewController) {
        let alert = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        vc.present(alert, animated: true, completion: nil)
    }
}
