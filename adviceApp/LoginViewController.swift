//
//  LoginViewController.swift
//  addvice
//
//  Created by Tameika Lawrence on 6/1/17.
//
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        //setUpUsernameField()
        
    }

    
    func setUpUsernameField() {
        
        usernameField.clipsToBounds = true
        usernameField.layer.borderWidth = 2.0
        usernameField.layer.borderColor = UIColor.clear.cgColor
        
    }
   

}
