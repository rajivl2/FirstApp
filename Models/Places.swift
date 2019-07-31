//
//  Places.swift
//  SnapKitPracticeApp
//
//  Created by Ford Labs on 24/07/19.
//  Copyright © 2019 Ford Labs. All rights reserved.
//

import Foundation

struct Places : Decodable {
    var PlaceId: Double?
    var IataCode: String?
    var Name: String?
    //var Type: String?
    var SkyscannerCode: String?
    var CityName: String?
    var CityId: String?
    var CountryName: String?
}
