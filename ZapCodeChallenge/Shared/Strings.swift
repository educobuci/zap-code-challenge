//
//  Strings.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 24/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

class Strings {
    static let BEDROOM = "quarto"
    static let BATHROOM = "banheiro"
    static let PARKING_SPACE = "vaga"
    static let FOR_RENT = "Para alugar"
    static let FOR_SALE = "Á venda"
    
    static func pluralize(scalar: Int, term: String) -> String {
        let sentence = "\(scalar) \(term)"
        if(scalar != 1) {
            return "\(sentence)s"
        }
        return sentence
    }
    
    static func formatBRL(_ value: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        let number = Int(value)!
        return "R$ \(formatter.string(from: number as NSNumber)!)"
    }
}
