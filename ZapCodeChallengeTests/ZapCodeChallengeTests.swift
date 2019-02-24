//
//  ZapCodeChallengeTests.swift
//  ZapCodeChallengeTests
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import XCTest
@testable import ZapCodeChallenge

class ZapCodeChallengeTests: XCTestCase {
    func testZapMinRentValue() {
        let rent3k = Fixtures.genHomeBy(businessType: .rental, price: "3000")
        let rent3_5k = Fixtures.genHomeBy(businessType: .rental, price: "3500")
        let homesList = [rent3k, rent3_5k]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .Zap)
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first!.pricingInfos.price, "3500")
    }
    func testZapMinSaleValue() {
        let sale600k = Fixtures.genHomeBy(businessType: .sale, price: "600000")
        let sale100k = Fixtures.genHomeBy(businessType: .sale, price: "100000")
        let homesList = [sale600k, sale100k]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .Zap)
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first!.pricingInfos.price, "600000")
    }
}
