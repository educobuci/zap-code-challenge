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
    func testVivaMaxRentValue() {
        let rent4k = Fixtures.genHomeBy(businessType: .rental, price: "4000")
        let rent5k = Fixtures.genHomeBy(businessType: .rental, price: "5000")
        let homesList = [rent4k, rent5k]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .VivaReal)
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first!.pricingInfos.price, "4000")
    }
    func testVivaMaxSaleValue() {
        let sale700k = Fixtures.genHomeBy(businessType: .sale, price: "700000")
        let sale800k = Fixtures.genHomeBy(businessType: .sale, price: "800000")
        let homesList = [sale700k, sale800k]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .VivaReal)
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first!.pricingInfos.price, "700000")
    }
}
