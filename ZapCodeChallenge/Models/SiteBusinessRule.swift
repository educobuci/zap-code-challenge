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
        var result: [Home] = homesList
        if let type = bySiteType {
            if(type == .Zap) {
                result = filterZap(homesList)
            } else if (bySiteType == .VivaReal) {
                result = filterViva(homesList)
            }
        }
        return result
    }
    private static func filterZap(_ homesList: [Home]) -> [Home] {
        return homesList.filter({ (home) -> Bool in
            let rentalRule = home.pricingInfos.businessType == .rental &&
                Int(home.pricingInfos.price)! >= 3500
            let saleRule = home.pricingInfos.businessType == .sale &&
                Int(home.pricingInfos.price)! >= 600000
            return rentalRule || saleRule
        })
    }
    private static func filterViva(_ homesList: [Home]) -> [Home] {
        return homesList.filter({ (home) -> Bool in
            let rentalRule = home.pricingInfos.businessType == .rental &&
                Int(home.pricingInfos.price)! <= 4000
            let saleRule = home.pricingInfos.businessType == .sale &&
                Int(home.pricingInfos.price)! <= 700000
            return rentalRule || saleRule
        })
    }
}
