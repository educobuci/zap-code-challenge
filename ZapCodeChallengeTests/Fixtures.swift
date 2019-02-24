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
    static func genHomeBy(businessType: BusinessType, price: String) -> Home {
        return Home (
            usableAreas: 70,
            id: "",
            parkingSpaces: 0,
            images: [],
            address: Address(city: nil, neighborhood: nil, geoLocation: nil),
            bathrooms: 1,
            bedrooms: 1,
            pricingInfos: PrincingInfos(
                yearlyIptu: nil, price: price, businessType: businessType, monthlyCondoFee: "")
        )
    }
}
