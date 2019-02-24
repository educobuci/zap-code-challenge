//
//  PricingInfo.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

enum BusinessType: String, Decodable {
    case sale = "SALE"
    case rental = "RENTAL"
}

struct PrincingInfos: Decodable {
    let yearlyIptu: String?
    let price: String
    let businessType: BusinessType
    let monthlyCondoFee: String?
}
