//
//  ContainerViewController.swift
//  addvice
//
//  Created by Tameika Lawrence on 2/19/17.
//  Copyright © 2017 Tameika Lawrence. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.set(true, forKey: "isFirstLaunch")
        hideContainerView()
        setUpContainer()
        scrollView.delegate = self
    }
    
    func hideContainerView() {
        blurView.effect = nil
        scrollView.alpha = 0.0
    }
    
    func setUpContainer() {
        self.scrollView.clipsToBounds = true
        self.scrollView.layer.cornerRadius = 20.0
        
        self.pageControl.numberOfPages = 5
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor.lilac
        self.pageControl.currentPageIndicatorTintColor = UIColor.seafoamGreen
        self.pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
        
    
    func isUsersFirstTime() {
        print(userDefaults.bool(forKey: "isFirstLaunch"))
        
        if userDefaults.bool(forKey: "isFirstLaunch") == true {
            userDefaults.set(false, forKey: "isFirstLaunch")
            userDefaults.synchronize()
            UIView.animate(withDuration: 0.8,
                           delay: 0.6,
                           options: .curveEaseInOut,
                           animations: {
                            self.blurView.effect = UIBlurEffect(style: .dark)
                            self.scrollView.alpha = 1.0
            })
            
        } else if userDefaults.bool(forKey: "isFirstLaunch") == false {
            (self.parent as? ViewController)?.containerView.isHidden = true
            
        }
        
    }
    
    
    @IBAction func dismissTutorialView(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.6,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.hideContainerView()
        }) { _ in
            (self.parent as? ViewController)?.containerView.isHidden = true
        }
    }
    
}

extension ContainerViewController: UIScrollViewDelegate {
    
    
    
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x/scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}




