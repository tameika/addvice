//
//  LoginViewController.swift
//  addvice
//
//  Created by Tameika Lawrence on 6/9/17.
//
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpEmailField()
        setUpPasswordField()
        setUpLoginButton()

        self.navigationController?.navigationBar.isHidden = true
    }

       
    func setUpEmailField() {
        emailField.clipsToBounds = true
        emailField.layer.borderWidth = 0.60
        emailField.layer.cornerRadius = emailField.bounds.height * 0.50
        emailField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: UIColor.seafoamGreen])
        emailField.layer.borderColor = UIColor.seafoamGreen.cgColor
    }
    
    func setUpPasswordField() {
        passwordField.clipsToBounds = true
        passwordField.layer.borderWidth = 0.60
        passwordField.layer.cornerRadius = passwordField.bounds.height * 0.50
        passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: UIColor.seafoamGreen])
        passwordField.layer.borderColor = UIColor.seafoamGreen.cgColor
    }
   
    func setUpLoginButton() {
        loginBtn.clipsToBounds = true
        loginBtn.layer.borderWidth = 0.60
        loginBtn.layer.cornerRadius = loginBtn.bounds.height * 0.50
        loginBtn.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: UIColor.seafoamGreen])
        loginBtn.layer.borderColor = UIColor.seafoamGreen.cgColor

    }
}
