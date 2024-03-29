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
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    @IBAction func siteChanged(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            currentSite = .VivaReal
        } else {
            currentSite = .Zap
        }
        self.presenter?.loadHomesList(site: currentSite)
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        collectionView.setContentOffset(CGPoint(x: 0, y: -topBarHeight), animated: true)
    }
    
    @IBAction func retryButtonTouch(_ sender: Any) {
        self.loadingView.startAnimating()
        self.errorView.isHidden = true
        self.presenter?.loadHomesList(site: currentSite)
    }
    
    private var homeData: [Home]?
    private var presenter: HomesListPresenter?
    var selectedHome: Home?
    var currentSite: SiteType = .VivaReal
    
    override func viewDidLoad() {
        let url = URL(string: Config.serviceURL)!
        self.presenter = HomesListPresenter(self, url: url)
        self.presenter?.loadHomesList(site: currentSite)
    }
    
    func showHomesList(homeData: [Home]) {
        self.homeData = homeData
        self.loadingView.stopAnimating()
        self.collectionView.reloadData()
    }
    
    func showError(error: Error) {
        errorView.isHidden = false
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

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedHome = self.homeData![indexPath.item]
        performSegue(withIdentifier: "details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsController = segue.destination as? HomeDetailsViewController {
            detailsController.home = self.selectedHome
        }
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
