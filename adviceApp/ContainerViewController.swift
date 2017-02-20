//
//  ContainerViewController.swift
//  addvice
//
//  Created by Tameika Lawrence on 2/19/17.
//  Copyright © 2017 flatiron. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.set(true, forKey: "isFirstLaunch")
        isUsersFirstTime()
        //blurBackground()
    }
    
    
    func setupContainerView() {
        
        self
    }
    
    
    
    func isUsersFirstTime() {
        print(userDefaults.bool(forKey: "isFirstLaunch"))
        
        if userDefaults.bool(forKey: "isFirstLaunch") == true {
            self.view.isHidden = false
            userDefaults.set(false, forKey: "isFirstLaunch")
            userDefaults.synchronize()
            
        } else if userDefaults.bool(forKey: "isFirstLaunch") == false {
            self.view.isHidden = true
        }
        
    }
    
    func blurBackground() {
        
        let blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView.init(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(blurEffectView)
    }
    
}
