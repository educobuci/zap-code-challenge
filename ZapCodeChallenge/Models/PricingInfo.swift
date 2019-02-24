//
//  PricingInfo.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

class PrincingInfos: Decodable {
    var yearlyIptu: String?
    var price: String?
    var businessType: String?
    var monthlyCondoFee: String?
}
