//
//  HomesListPresenter.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

class HomesListPresenter {
    let homesListView: HomesListView
    let serviceUrl: URL
    var allData: [Home]?
    
    init(_ view: HomesListView, url: URL) {
        self.homesListView = view
        self.serviceUrl = url
    }
    
    func loadHomesList(type: String) {
        loadAll {
            var filteredList: [Home] = []
            if(type == "Zap") {
                filteredList = self.filterZap(self.allData!)
            } else if(type == "Viva") {
                filteredList = self.filterViva(self.allData!)
            }
            DispatchQueue.main.async {
                self.homesListView.showHomesList(homeData: filteredList)
            }
        }
    }
    
    func filterZap(_ list: [Home]) -> [Home] {
        return allData!
    }
    
    func filterViva(_ list: [Home]) -> [Home] {
        return allData!
    }
    
    private
    func loadAll(callback: (() -> Void)?) {
        if(self.allData != nil) {
            callback?()
        } else {
            HomeService.loadAll(
                url: self.serviceUrl,
                onSuccess: { (data) in self.allData = data; callback?() },
                onError: self.homesListView.showError)
        }
    }
}
