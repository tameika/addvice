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
    @IBOutlet weak var loginView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //setUpUsernameField()
        //setUpLoginView()
        
    }

    
    func setUpUsernameField() {
        
        usernameField.clipsToBounds = true
        usernameField.layer.borderWidth = 0.50
        //usernameField.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func setUpLoginView() {
        
        loginView.clipsToBounds = true
        //loginView.layer.cornerRadius = loginView.bounds.height * 0.05
        loginView.layer.borderWidth = 0.50
        loginView.layer.borderColor = UIColor.white.cgColor
    }
   

}
