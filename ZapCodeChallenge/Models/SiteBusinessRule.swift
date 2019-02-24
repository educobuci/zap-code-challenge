//
//  Site.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 24/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

class SiteBusinessRule {
    static func filter(homesList: [Home], bySiteType: SiteType) -> [Home] {
        var result: [Home] = []
        if(bySiteType == .Zap) {
            result = filterZap(homesList)
        } else if (bySiteType == .VivaReal){
            result = filterViva(homesList)
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
        return []
    }
}
