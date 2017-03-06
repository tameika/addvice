//
//  ContainerViewController.swift
//  addvice
//
//  Created by Tameika Lawrence on 2/19/17.
//  Copyright © 2017 flatiron. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var numberLabels: [UILabel]!
    
    var userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.set(true, forKey: "isFirstLaunch")
        hideContainerView()
        setUpContainer()
    }
    
    func hideContainerView() {
        blurView.effect = nil
        scrollView.alpha = 0.0
    }
    
    func setUpContainer() {
        self.scrollView.clipsToBounds = true
        self.scrollView.layer.cornerRadius = 20.0
        
        
        for label in numberLabels {
            label.clipsToBounds = true
            label.layer.cornerRadius = label.bounds.height * 0.50
        }
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
