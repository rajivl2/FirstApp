//
//  Quotes.swift
//  SnapKitPracticeApp
//
//  Created by Ford Labs on 24/07/19.
//  Copyright © 2019 Ford Labs. All rights reserved.
//

import Foundation

struct Quotes : Decodable {
    var QuoteId: Int?
    var MinPrice: Double?
    var Direct: Bool
    var OutboundLeg: OutboundLeg?
    var QuoteDateTime: String?
}

struct OutboundLeg : Decodable {
    var CarrierIds: [Int?]
    var OriginId: Double?
    var DestinationId: Double?
    var DepartureDate: String?
}
