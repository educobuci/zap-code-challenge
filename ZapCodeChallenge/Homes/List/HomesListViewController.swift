//
//  HomesViewController.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "HomeCell"

class HomesListViewController: UICollectionViewController {
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    private var homeData: [Home]?
    private var presenter: HomesListPresenter?
    
    override func viewDidLoad() {
        let url = URL(string: Config.serviceURL)!
        self.presenter = HomesListPresenter(self, url: url)
        self.presenter?.loadHomesList(site: .VivaReal)
    }
    
    func showHomesList(homeData: [Home]) {
        self.homeData = homeData
        self.loadingView.stopAnimating()
        self.collectionView.reloadData()
    }
    
    func showError(error: Error) {
        // TODO: Implement the error hading
        print(error)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeData?.count ?? 0
    }    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let home = self.homeData![indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCell
        if(!cell.isFXDone) {
            cell.setupFX()
        }
        if(home.pricingInfos.businessType == .rental) {
            cell.priceLabel.text = "\(Strings.FOR_RENT) \(Strings.formatBRL(home.pricingInfos.price))"
        } else {
            cell.priceLabel.text = "\(Strings.FOR_SALE) \(Strings.formatBRL(home.pricingInfos.price))"
        }
        cell.characteristicsLabel.text = formatCharacteristics(home)
        if let firstImage = home.images.first {
            cell.image.sd_setImage(with: URL(string: firstImage))
        }
        cell.addressLabel.text = formatAddress(home.address)
        return cell
    }
    
    private func formatCharacteristics(_ home: Home) -> String {
        let rooms = "\(Strings.pluralize(scalar: home.bedrooms, term: Strings.BEDROOM))"
        let baths = "\(Strings.pluralize(scalar: home.bathrooms, term: Strings.BATHROOM))"
        let area = "\(home.usableAreas)m²"
        let parking = "\(Strings.pluralize(scalar:(home.parkingSpaces ?? 0), term: Strings.PARKING_SPACE))"
        return "\(rooms)・\(baths)・\(area)・\(parking)"
    }
    
    private func formatAddress(_ address: Address) -> String {
        if let neighborhood = address.neighborhood, let city = address.city {
            if(!neighborhood.isEmpty && !city.isEmpty) {
                return "\(neighborhood)・\(city)"
            }
        }
        return ""
    }
}
