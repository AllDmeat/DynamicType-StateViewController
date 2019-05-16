//
//  Int+StringRepresentation.swift
//  DynamicType
//
//  Created by Алексей Берёзка on 15/05/2019.
//  Copyright © 2019 Алексей Берёзка. All rights reserved.
//

import Foundation

extension Int {
    var stringRepresentation: String {
        let formatter = NumberFormatter.stringRepresentationFormatter
        let number = NSNumber(value: self)
        let stringRepresentation = formatter.string(from: number)
        return stringRepresentation!
    }
}

extension NumberFormatter {
    static let stringRepresentationFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter
    }()
}
