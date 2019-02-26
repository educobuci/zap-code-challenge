//
//  HomeDetailsViewController.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 25/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import UIKit
import SDWebImage

class HomeDetailsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var businessTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var condoFeeLabel: UILabel!
    @IBOutlet weak var bedroomsLabel: UILabel!
    @IBOutlet weak var bathroomsLabels: UILabel!
    @IBOutlet weak var parkingLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var home: Home! = nil
    //let imageHeight = CGFloat(300)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        self.setupImagePages()
        self.fillInfo()
    }
    
    func setupImagePages() {
        self.pageControl.numberOfPages = home.images.count
        for (index, image) in home.images.enumerated() {
            let frame = CGRect(x: (CGFloat(index) * self.scrollView.frame.width), y: 0,
                               width: self.scrollView.frame.width,
                               height: self.scrollView.frame.height)
            let imageView = UIImageView(frame: frame)
            if UIDevice.current.userInterfaceIdiom == .pad {
                imageView.contentMode = .scaleAspectFit
            }
            imageView.sd_setImage(with: URL(string: image))
            self.scrollView.addSubview(imageView)
        }
        self.scrollView.contentSize = CGSize(
            width: CGFloat(home.images.count) * self.scrollView.frame.width,
            height: self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.priceLabel.text = Strings.formatBRL(home.pricingInfos.price)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(self.scrollView.contentOffset.x / self.scrollView.frame.width)
        self.pageControl.currentPage = pageNumber
    }
    
    func fillInfo() {
        businessTypeLabel.text = home.pricingInfos.businessType == .sale ? Strings.FOR_SALE : Strings.FOR_RENT
        if let condoFee = home.pricingInfos.monthlyCondoFee {
            condoFeeLabel.text = Strings.formatBRL(condoFee)
        }
        bedroomsLabel.text = "\(home.bedrooms)"
        bathroomsLabels.text = "\(home.bathrooms)"
        if let spaces = home.parkingSpaces {
            parkingLabel.text = "\(spaces)"
        }
        if let neighborhood = home.address.neighborhood, let city = home.address.city {
            if(!neighborhood.isEmpty && !city.isEmpty) {
                cityLabel.text = "\(neighborhood)・\(city)"
            }
        }
    }
}
