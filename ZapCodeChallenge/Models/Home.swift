//
//  Home.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

struct Home: Decodable {
    let usableAreas: Int
    let id: String?
    let parkingSpaces: Int?
    let images: [String]
    let address: Address
    let bathrooms: Int
    let bedrooms: Int
    let pricingInfos: PrincingInfos
}
