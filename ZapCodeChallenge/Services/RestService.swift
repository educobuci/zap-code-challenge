//
//  HomeService.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

class RestService {
    static func loadList<T: Decodable>(url: URL, onSuccess: @escaping ([T]) -> Void, onError: ((Error) -> Void)?) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode([T].self, from: data)
                onSuccess(decoded)
            }
            catch let jsonError {
                onError?(jsonError)
            }
        }.resume()
    }
}
