//
//  Site.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 24/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

class SiteBusinessRule {
    // ZAP Constants
    private static let zapMinRentPrice = 3500
    private static let zapMinSalePrice = 600000
    private static let zapMinRatio: Float = 3500.0
    private static let zapMinRatioInBounding: Float = zapMinRatio * 0.9
    
    // Viva Real Constants
    private static let vivaMaxRentPrice = 4000
    private static let vivaMaxSalePrice = 700000
    private static let vivaCondoFeeRatio: Float = 0.3 // 30%
    private static let vivaCondoFeeRatioInBounding: Float = vivaCondoFeeRatio * 1.5 // + 50%
    
    static func filter(homesList: [Home], siteType: SiteType? = nil) -> [Home] {
        var rules: [(_ home:Home) -> Bool] = []
        if let type = siteType {
            if(type == .Zap) {
                rules.append(filterZap)
                rules.append(filterZapMinAreasPriceRatio)
            } else if (siteType == .VivaReal) {
                rules.append(filterViva)
                rules.append(filterVivaMaxCondoFee)
            }
        }
        rules.append(filterZeroCords)
        return homesList.filter { home in
             rules.allSatisfy { rule in rule(home) }
        }
    }
    
    private static func filterZap(_ home: Home) -> Bool {
        let rentalRule = home.pricingInfos.businessType == .rental &&
            Int(home.pricingInfos.rentalTotalPrice!)! >= zapMinRentPrice
        let saleRule = home.pricingInfos.businessType == .sale &&
            Int(home.pricingInfos.price)! >= zapMinSalePrice
        return rentalRule || saleRule
    }
    
    private static func filterViva(_ home: Home) -> Bool {
        let rentalRule = home.pricingInfos.businessType == .rental &&
            Int(home.pricingInfos.rentalTotalPrice!)! <= vivaMaxRentPrice
        let saleRule = home.pricingInfos.businessType == .sale &&
            Int(home.pricingInfos.price)! <= vivaMaxSalePrice
        return rentalRule || saleRule
    }
    
    private static func filterZeroCords(_ home: Home) -> Bool {
        if let location = home.address.geoLocation?.location {
            return location.lat! != 0 && location.lon != 0
        }
        return false
    }
    
    private static func filterZapMinAreasPriceRatio(_ home: Home) -> Bool {
        if(home.pricingInfos.businessType != .sale || home.usableAreas == 0) {
            return true
        }
        let price = Int(home.pricingInfos.price)!
        var ratio = zapMinRatio
        if let location = home.address.geoLocation?.location {
            if(ZapBoundingBox.isInside(lon: location.lon!, lat: location.lat!)) {
                ratio = zapMinRatioInBounding
            }
        }
        return price / home.usableAreas > Int(ratio)
    }
    
    private static func filterVivaMaxCondoFee(_ home: Home) -> Bool {
        var ratio = vivaCondoFeeRatio
        if let location = home.address.geoLocation?.location {
            if(ZapBoundingBox.isInside(lon: location.lon!, lat: location.lat!)) {
                ratio = vivaCondoFeeRatioInBounding
            }
        }
        if let condoFee = Float(home.pricingInfos.monthlyCondoFee ?? "") {
            if (home.pricingInfos.businessType == .rental) {
                let price = Float(home.pricingInfos.rentalTotalPrice!)!
                return condoFee / price < ratio
            }
        }
        return true
    }
}
