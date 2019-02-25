//
//  Fixtures.swift
//  ZapCodeChallengeTests
//
//  Created by Eduardo Cobuci on 24/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import XCTest
@testable import ZapCodeChallenge

class Fixtures {
    static func genHomeBy(
        businessType: BusinessType = .rental,
        price: String = "",
        geoLocation: GeoLocation = defaultGeoLocation) -> Home {
        return Home (
            usableAreas: 70,
            id: "",
            parkingSpaces: 0,
            images: [],
            address: Address(city: nil, neighborhood: nil, geoLocation: geoLocation),
            bathrooms: 1,
            bedrooms: 1,
            pricingInfos: PrincingInfos(
                yearlyIptu: nil, price: price, businessType: businessType, monthlyCondoFee: "")
        )
    }
    private static let defaultGeoLocation = GeoLocation(precision: "ROOFTOP", location: Location(lon: 1, lat: 1))
}
