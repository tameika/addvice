//
//  LoginViewController.swift
//  addvice
//
//  Created by Tameika Lawrence on 6/1/17.
//
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    
    
    var containerVC = ContainerViewController()
    var adviceVC: ViewController!
    var allUsers = [String]()
    var isAvailable = true
    var alert = Alert()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpUsernameField()
        setUpEnterButton()
        //retrieveExistingUsers()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    
    
    // MARK: Dismiss keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    // MARK: Setting up UI Objects
    
    func setUpUsernameField() {
        usernameField.clipsToBounds = true
        usernameField.layer.borderWidth = 0.60
        usernameField.layer.cornerRadius = usernameField.bounds.height * 0.50
        usernameField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: UIColor.seafoamGreen])
        usernameField.layer.borderColor = UIColor.seafoamGreen.cgColor
    }
    
    func setUpPasswordField() {
        passwordField.clipsToBounds = true
        passwordField.layer.borderWidth = 0.60
        passwordField.layer.cornerRadius = passwordField.bounds.height * 0.50
        passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: UIColor.seafoamGreen])
        passwordField.layer.borderColor = UIColor.seafoamGreen.cgColor

    }
    
    func setUpEnterButton() {
        enterBtn.clipsToBounds = true
        enterBtn.layer.borderWidth = 0.50
        enterBtn.layer.cornerRadius = enterBtn.bounds.height * 0.50
        enterBtn.layer.borderColor = UIColor.seafoamGreen.cgColor
        self.enterBtn.isEnabled = false
    }
    
    
    // MARK: Username field validation animation
    
    func makeFieldBackgroundLilac() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn], animations: {
            self.usernameField.layer.backgroundColor = UIColor.lilac.cgColor
            self.usernameField.textColor = UIColor.eggplantDark
        })
        UIView.setAnimationRepeatCount(3.0)
    }
    
    func makeFieldBackgroundRed() {
        usernameField.layer.backgroundColor = UIColor.errorRed.cgColor
    }
    
    
    // MARK: Username validation logic
    
    @IBAction func usernameFieldAction(_ sender: Any) {
        if usernameField.text == "" {
            makeFieldBackgroundRed()
            
        } else {
            makeFieldBackgroundLilac()
        }
    }
    
    
    @IBAction func passwordFieldAction(_ sender: Any) {
        if usernameField.text == "" {
            makeFieldBackgroundRed()
        } else {
            makeFieldBackgroundLilac()
        }
    }
    
    
    
    
    @IBAction func enterBtn(_ sender: Any) {
        guard let username = usernameField.text else { return }
        guard let password = passwordField.text else { return }
        if username != "" && password != "" {
            FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: { (user, error) in
                if error == nil {
                    guard let adviceVC = self.storyboard?.instantiateViewController(withIdentifier: "showAddviceIdentifier") else { return }
                    self.present(adviceVC, animated: true, completion: nil)
                }
            })
            
        }
        
    }
    
    
    
}







//    func retrieveExistingUsers() {
//        let ref = FIRDatabase.database().reference()
//        let availableRef = ref.child("Advice")
//        availableRef.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let existingUsers = snapshot.value as? [String: Any] else { return }
//            for (_, value) in existingUsers {
//                guard var userDictionary = value as? [String: String] else { return }
//                let user = userDictionary["user"] ?? "NO USER"
//                self.allUsers.append(user)
//            }
//        })
//        checkAvailability()
//    }

//    func checkAvailability() {
//        print("inside checking availability")
//        guard let username = usernameField.text else { print("i didn't get passed here"); return }
//        for user in self.allUsers {
//            if user == username {
//                alert.isUnavailableAlert(presenting: self)
//            }
//        }
//    }







