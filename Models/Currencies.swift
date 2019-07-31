//
//  Currencies.swift
//  SnapKitPracticeApp
//
//  Created by Ford Labs on 24/07/19.
//  Copyright © 2019 Ford Labs. All rights reserved.
//

import Foundation

struct Currencies : Decodable {
    var Code: String?
    //var symbol: Character?
    //var thousandsSeparator: Character?
    //var decimalSeparator: Character?
    var SymbolOnLeft: Bool?
    var SpaceBetweenAmountAndSymbol: Bool?
    var RoundingCoefficient: Int?
    var DecimalDigits: Int?
}
