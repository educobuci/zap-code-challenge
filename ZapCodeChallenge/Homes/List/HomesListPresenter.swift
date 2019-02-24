//
//  HomesListPresenter.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import Foundation

class HomesListPresenter {
    let homesListView: HomesListViewController?
    let serviceUrl: URL
    var allData: [Home]?
    
    init(_ view: HomesListViewController?, url: URL) {
        self.homesListView = view
        self.serviceUrl = url
    }
    
    func loadHomesList(site: Site) {
        loadAll {
            var filteredList: [Home] = []
            if(site == .Zap) {
                filteredList = self.filterZap(self.allData!)
            } else if(site == .VivaReal) {
                filteredList = self.filterViva(self.allData!)
            }
            DispatchQueue.main.async {
                self.homesListView?.showHomesList(homeData: filteredList)
            }
        }
    }
    
    func filterZap(_ list: [Home]) -> [Home] {
        return allData!.filter({ (home) -> Bool in
            Int(home.pricingInfos.price)! % 2 == 0
        })
    }
    
    func filterViva(_ list: [Home]) -> [Home] {
        return allData!.filter({ (home) -> Bool in
            Int(home.pricingInfos.price)! % 2 == 1
        })
    }
    
    private func loadAll(callback: (() -> Void)?) {
        if(self.allData != nil) {
            callback?()
        } else {
            RestService.loadList(
                url: self.serviceUrl,
                onSuccess: { (data: [Home]) in self.allData = data; callback?() },
                onError: self.homesListView?.showError)
        }
    }
}
