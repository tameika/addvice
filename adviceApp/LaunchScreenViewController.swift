//
//  LaunchScreenViewController.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 2/10/17.
//  Copyright © 2017 flatiron. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    
    @IBOutlet weak var appTitleLabel: UILabel! {
        
        didSet {
            
            appTitleLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            UIView.animate(withDuration: 1.0,
                           delay: 0.5,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 10.0,
                           options: .curveLinear,
                           animations: {
                            self.appTitleLabel.transform = CGAffineTransform.identity
                            print("successfully animated title")
            })

        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
