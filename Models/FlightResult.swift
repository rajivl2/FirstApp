//
//  FlightResult.swift
//  SnapKitPracticeApp
//
//  Created by Ford Labs on 24/07/19.
//  Copyright © 2019 Ford Labs. All rights reserved.
//

import Foundation

struct FlightResult : Decodable {
    var Quotes: [Quotes]
    var Places: [Places]
    var Carriers: [Carriers]
    var Currencies: [Currencies]
}
