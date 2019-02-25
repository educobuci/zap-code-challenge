//
//  ZapBoundingBox.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 25/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

class ZapBoundingBox {
    static let minlon: Float = -46.693419
    static let minlat: Float = -23.568704
    static let maxlon: Float = -46.641146
    static let maxlat: Float = -23.546686
    static func isInside(lon: Float, lat: Float) -> Bool {
        return  lon >= minlon && lon <= maxlon &&
                lat >= minlat && lat <= maxlat
    }
}
