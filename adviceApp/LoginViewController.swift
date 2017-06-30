//
//  LoginViewController.swift
//  addvice
//
//  Created by Tameika Lawrence on 6/9/17.
//
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK : UI Properties
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    // MARK : Logic Properties
    
    var alert = Alert()
    var userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEmailField()
        setUpPasswordField()
        setUpLoginButton()
        self.navigationController?.navigationBar.isHidden = true
        emailField.autocapitalizationType = .none
        passwordField.autocapitalizationType = .none
    }
    
    // MARK : Set Up UI Objects
    
    func setUpEmailField() {
        emailField.clipsToBounds = true
        emailField.layer.borderWidth = 0.60
        emailField.layer.cornerRadius = emailField.bounds.height * 0.50
        emailField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: UIColor.eggplantDark])
        emailField.layer.borderColor = UIColor.seafoamGreen.cgColor
    }
    
    func setUpPasswordField() {
        passwordField.clipsToBounds = true
        passwordField.layer.borderWidth = 0.60
        passwordField.layer.cornerRadius = passwordField.bounds.height * 0.50
        passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: UIColor.eggplantDark])
        passwordField.layer.borderColor = UIColor.seafoamGreen.cgColor
    }
   
    func setUpLoginButton() {
        loginBtn.clipsToBounds = true
        loginBtn.layer.cornerRadius = loginBtn.bounds.height * 0.50
        loginBtn.layer.borderColor = UIColor.seafoamGreen.cgColor
    }
    
    // MARK : Responder Method 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // MARK : Prepare for Segue to Addvice Home 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginAdviceIdentifier" {
            if let dest = segue.destination as? ViewController {
                guard let username = userDefaults.object(forKey: "username") as? String else { return }
                dest.displayName = username
            }
        }
    }
    
  // MARK : Button Method
    
    @IBAction func loginBtn(_ sender: Any) {
        
        guard let username = emailField.text, let password = passwordField.text else { return }
        if username != "" && password != "" {
            FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: { (FIRUser, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "loginAdviceIdentifier", sender: self)
                    
                } else {
                    self.alert.isErrorAlert(presenting: self, error: error?.localizedDescription)
                }
            })
        }
    }
}
