//
//  Address.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

struct Address: Decodable {
    let city: String?
    let neighborhood: String?
    let geoLocation: GeoLocation?
}
