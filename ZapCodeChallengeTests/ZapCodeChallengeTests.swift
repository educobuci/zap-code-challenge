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
    // Zap Specifics
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
    func testLonTatZero() {
        let zeroCoords = Fixtures.genHomeBy(geoLocation: GeoLocation(precision: "", location: Location(lon: 0, lat: 0)))
        let oneCoords = Fixtures.genHomeBy()
        let homesList = [zeroCoords, oneCoords]
        let filtered = SiteBusinessRule.filter(homesList: homesList)
        let location = filtered.first!.address.geoLocation?.location
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(location?.lat!, 1)
        XCTAssertEqual(location?.lon!, 1)
    }
    func testZapMinUsableAreasValue() {
        let saleAreas170x600k = Fixtures.genHomeBy(usableAreas: 180, businessType: .sale, price: "600000")
        let saleAreas150x600k = Fixtures.genHomeBy(usableAreas: 150, businessType: .sale, price: "600000")
        let saleAreasZero = Fixtures.genHomeBy(usableAreas: 0, businessType: .sale, price: "600000")
        let homesList = [saleAreas170x600k, saleAreas150x600k, saleAreasZero]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .Zap)
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].usableAreas, 150)
        XCTAssertEqual(filtered[1].usableAreas, 0)
    }
}
