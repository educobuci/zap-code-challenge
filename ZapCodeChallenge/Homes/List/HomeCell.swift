//
//  HomeListCell.swift
//  ZapCodeChallenge
//
//  Created by Eduardo Cobuci on 23/02/19.
//  Copyright © 2019 Eduardo Cobuci. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var characteristicsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var isFXDone = false
    var radius = 10
    
    func setupFX() {
        // Info blur background FX
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame.size = self.infoContainer.frame.size
        self.infoContainer.insertSubview(blurEffectView, at: 0)
        // Round the corners
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        isFXDone = true
    }
}
