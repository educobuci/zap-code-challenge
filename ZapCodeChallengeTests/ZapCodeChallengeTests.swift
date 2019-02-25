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
        let rent3k = Fixtures.genHomeWith(businessType: .rental, price: "3000")
        let rent3_5k = Fixtures.genHomeWith(businessType: .rental, price: "3500")
        let homesList = [rent3k, rent3_5k]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .Zap)
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first!.pricingInfos.price, "3500")
    }
    func testZapMinSaleValue() {
        let sale600k = Fixtures.genHomeWith(businessType: .sale, price: "600000")
        let sale100k = Fixtures.genHomeWith(businessType: .sale, price: "100000")
        let homesList = [sale600k, sale100k]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .Zap)
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first!.pricingInfos.price, "600000")
    }
    func testVivaMaxRentValue() {
        let rent4k = Fixtures.genHomeWith(businessType: .rental, price: "4000")
        let rent5k = Fixtures.genHomeWith(businessType: .rental, price: "5000")
        let homesList = [rent4k, rent5k]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .VivaReal)
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first!.pricingInfos.price, "4000")
    }
    func testVivaMaxSaleValue() {
        let sale700k = Fixtures.genHomeWith(businessType: .sale, price: "700000")
        let sale800k = Fixtures.genHomeWith(businessType: .sale, price: "800000")
        let homesList = [sale700k, sale800k]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .VivaReal)
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first!.pricingInfos.price, "700000")
    }
    func testLonTatZero() {
        let zeroCoords = Fixtures.genHomeWith(geoLocation: GeoLocation(precision: "", location: Location(lon: 0, lat: 0)))
        let oneCoords = Fixtures.genHomeWith()
        let homesList = [zeroCoords, oneCoords]
        let filtered = SiteBusinessRule.filter(homesList: homesList)
        let location = filtered.first!.address.geoLocation?.location
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(location?.lat!, 1)
        XCTAssertEqual(location?.lon!, 1)
    }
    func testZapMinUsableAreasValue() {
        let saleAreas180x600k = Fixtures.genHomeWith(usableAreas: 180, businessType: .sale, price: "600000")
        let saleAreas150x600k = Fixtures.genHomeWith(usableAreas: 150, businessType: .sale, price: "600000")
        let saleAreasZero = Fixtures.genHomeWith(usableAreas: 0, businessType: .sale, price: "600000")
        let homesList = [saleAreas180x600k, saleAreas150x600k, saleAreasZero]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .Zap)
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].usableAreas, 150)
        XCTAssertEqual(filtered[1].usableAreas, 0)
    }
    func testZapMinUsableAreasValueInBounding() {
        let inLocation = GeoLocation(precision: "", location: Location(lon: ZapBoundingBox.maxlon, lat: ZapBoundingBox.minlat))
        let outLocation = GeoLocation(precision: "", location: Location(lon: ZapBoundingBox.maxlon + 1, lat: ZapBoundingBox.minlat - 1))
        let saleAreas190x600kIn = Fixtures.genHomeWith(usableAreas: 190, businessType: .sale, price: "600000", geoLocation: inLocation)
        let saleAreas190x600kOut = Fixtures.genHomeWith(usableAreas: 190, businessType: .sale, price: "600000", geoLocation: outLocation)
        let homesList = [saleAreas190x600kIn, saleAreas190x600kOut]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .Zap)
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first!.address.geoLocation?.location?.lon, ZapBoundingBox.maxlon)
    }
    func testVivaCondoMaxValue() {
        let rentCondo30Percent = Fixtures.genHomeWith(businessType: .rental, price: "1000", condoFee: "300")
        let rentCondo20Percent = Fixtures.genHomeWith(businessType: .rental, price: "1000", condoFee: "200")
        let rentCondoInvalid = Fixtures.genHomeWith(businessType: .rental, price: "1000", condoFee: "")
        let homesList = [rentCondo30Percent, rentCondo20Percent, rentCondoInvalid]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .VivaReal)
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].pricingInfos.monthlyCondoFee, "200")
        XCTAssertEqual(filtered[1].pricingInfos.monthlyCondoFee, "")
    }
    func testVivaCondoMaxValueInBounding() {
        let inLocation = GeoLocation(precision: "", location: Location(lon: ZapBoundingBox.maxlon, lat: ZapBoundingBox.minlat))
        let outLocation = GeoLocation(precision: "", location: Location(lon: ZapBoundingBox.maxlon + 1, lat: ZapBoundingBox.minlat - 1))
        let rentCondo44PercentIn = Fixtures.genHomeWith(businessType: .rental, price: "1000", geoLocation: inLocation, condoFee: "440")
        let rentCondo44PercentOut = Fixtures.genHomeWith(businessType: .rental, price: "1000", geoLocation: outLocation, condoFee: "440")
        let homesList = [rentCondo44PercentIn, rentCondo44PercentOut]
        let filtered = SiteBusinessRule.filter(homesList: homesList, bySiteType: .VivaReal)
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first!.address.geoLocation?.location?.lon, ZapBoundingBox.maxlon)        
    }
}
