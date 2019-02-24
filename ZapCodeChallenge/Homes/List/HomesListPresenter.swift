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
    
    func loadHomesList(site: SiteType) {
        loadAll {
            let filteredList = SiteBusinessRule.filter(homesList: self.allData!, bySiteType: site)
            DispatchQueue.main.async {
                self.homesListView?.showHomesList(homeData: filteredList)
            }
        }
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
