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
    
    var home: Home! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupImagePages()
    }
    
    func setupImagePages() {
        self.pageControl.numberOfPages = home.images.count
        for (index, image) in home.images.enumerated() {
            let frame = CGRect(x: (CGFloat(index) * self.scrollView.frame.width), y: 0,
                               width: self.scrollView.frame.width,
                               height: self.scrollView.frame.height)
            let imageView = UIImageView(frame: frame)
            imageView.sd_setImage(with: URL(string: image))
            self.scrollView.addSubview(imageView)
        }
        self.scrollView.contentSize = CGSize(
            width: CGFloat(home.images.count) * self.scrollView.frame.width,
            height: self.scrollView.frame.height)
        self.scrollView.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(self.scrollView.contentOffset.x / self.scrollView.frame.width)
        self.pageControl.currentPage = pageNumber
    }
}
