//
//  HomeService.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

class HomeService {
    static func loadAll(url: URL, onSuccess: @escaping ([Home]) -> Void, onError: ((Error) -> Void)?) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let homeData = try JSONDecoder().decode([Home].self, from: data)
                onSuccess(homeData)
            }
            catch let jsonError {
                onError?(jsonError)
            }
        }.resume()
    }
}
