//
//  HomesListView.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

protocol HomesListView {
    func showHomesList(homeData: [Home])
    func showError(error: Error)
}
