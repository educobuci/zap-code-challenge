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

class HomesListViewController: UICollectionViewController, HomesListView {
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    private var homeData: [Home]?
    private var presenter: HomesListPresenter?
    
    override func viewDidLoad() {
        let url = URL(string: "http://grupozap-code-challenge.s3-website-us-east-1.amazonaws.com/sources/source-1.json")!
        self.presenter = HomesListPresenter(self, url: url)
        self.presenter?.loadHomesList(type: "Viva")
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let home = self.homeData![indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeListCell
        if(!cell.isFXDone) {
            cell.setupFX()
        }
        cell.priceLabel.text = "Á venda R$\(home.pricingInfos!.price!)"
        cell.characteristicsLabel.text = formatCharacteristics(home: home)
        if let firstImage = home.images.first {
            cell.image.sd_setImage(with: URL(string: firstImage))
        }
        return cell
    }
    
    private func formatCharacteristics(home: Home) -> String {
        let rooms = "\(pluralize(scalar: home.bedrooms, term: "quarto"))"
        let baths = "\(pluralize(scalar: home.bathrooms, term: "banheiro"))"
        let area = "\(home.usableAreas)m²"
        let parking = "\(pluralize(scalar:(home.parkingSpaces ?? 0), term: "vaga"))"
        return "\(rooms)・\(baths)・\(area)・\(parking)"
    }
    
    func pluralize(scalar: Int, term: String) -> String {
        let sentence = "\(scalar) \(term)"
        if(scalar != 1) {
            return "\(sentence)s"
        }
        return sentence
    }
}
