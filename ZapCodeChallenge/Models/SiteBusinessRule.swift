//
//  Site.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 24/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

class SiteBusinessRule {
    static func filter(homesList: [Home], bySiteType: SiteType? = nil) -> [Home] {
        var rules: [(_ home:Home) -> Bool] = []
        if let type = bySiteType {
            if(type == .Zap) {
                rules.append(filterZap)
            } else if (bySiteType == .VivaReal) {
                rules.append(filterViva)
            }
        }
        rules.append(filterZeroCords)
        return homesList.filter { home in
             rules.allSatisfy { rule in rule(home) }
        }
    }
    
    private static func filterZap(_ home: Home) -> Bool {
        let rentalRule = home.pricingInfos.businessType == .rental &&
            Int(home.pricingInfos.price)! >= 3500
        let saleRule = home.pricingInfos.businessType == .sale &&
            Int(home.pricingInfos.price)! >= 600000
        return rentalRule || saleRule
    }
    
    private static func filterViva(_ home: Home) -> Bool {
        let rentalRule = home.pricingInfos.businessType == .rental &&
            Int(home.pricingInfos.price)! <= 4000
        let saleRule = home.pricingInfos.businessType == .sale &&
            Int(home.pricingInfos.price)! <= 700000
        return rentalRule || saleRule
    }
    
    private static func filterZeroCords(_ home: Home) -> Bool {
        if let location = home.address.geoLocation?.location {
            return location.lat! != 0 && location.lon != 0
        }
        return false
    }
}
