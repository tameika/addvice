//
//  SignUpViewController.swift
//  addvice
//
//  Created by Tameika Lawrence on 6/1/17.
//
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class SignUpViewController: UIViewController {
    
    // MARK : UI Properties
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    // MARK : Logic Properties
    
    var containerVC = ContainerViewController()
    var adviceVC: ViewController!
    var alert = Alert()
    var existingUsers = [String]()
    var blockedUsers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUsernameField()
        setUpEmailField()
        setUpPasswordField()
        setUpEnterButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveExistingUsers()
    }
    
    // MARK : Dismiss Keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // MARK : Set Up UI Objects
    
    func setUpUsernameField() {
        usernameField.autocorrectionType = .no
        usernameField.autocapitalizationType = .none
        usernameField.clipsToBounds = true
        usernameField.layer.borderWidth = 0.60
        usernameField.layer.cornerRadius = usernameField.bounds.height * 0.50
        usernameField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName: UIColor.seafoamGreen])
        usernameField.layer.borderColor = UIColor.seafoamGreen.cgColor
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
    
    func setUpEnterButton() {
        enterBtn.clipsToBounds = true
        enterBtn.layer.borderWidth = 0.50
        enterBtn.layer.cornerRadius = enterBtn.bounds.height * 0.50
        enterBtn.layer.borderColor = UIColor.seafoamGreen.cgColor
    }
    
    // MARK : Retrieve Existing Users
    
    func retrieveExistingUsers() {
        let ref = FIRDatabase.database().reference()
        let availableRef = ref.child("Advice")
        availableRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let users = snapshot.value as? [String: Any] else { return }
            for (_, value) in users {
                guard var userDictionary = value as? [String: String] else { return }
                let user = userDictionary["user"] ?? "NO USER"
                self.existingUsers.append(user)
            }
        })
    }
    
    // MARK : Username Validation Logic
    
    func checkAvailability() {
        guard let username = usernameField.text else { return }
        if existingUsers.contains(username) {
            alert.isUnavailableAlert(presenting: self)
        } else {
            print("CHECKED PASSED")
        }
    }
    
    // MARK : Delete Username Field End Space
    
    @IBAction func usernameFieldAction(_ sender: Any) {
        guard var username = usernameField.text else { return }
        var nameArr = Array(username.characters)
        for i in nameArr.enumerated() {
            if i.element == " " {
                nameArr.remove(at: i.offset)
            }
        }
        username = String(nameArr)
        print(nameArr)
        checkAvailability()
    }
    
    // MARK : Prepare for Segue to Addvice Home
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adviceIdentifier" {
            if let dest = segue.destination as? ViewController {
                guard let username = usernameField.text else { print("GETTING USERNAME FAILED"); return }
                guard let email = emailField.text else { print("GETTING EMAIL FAILED"); return }
                dest.displayName = username
                dest.emailAddress = email
            }
        }
    }
    
    // MARK : Button Action Methods
    
    @IBAction func enterBtn(_ sender: Any) {
        guard let username = usernameField.text, let email = emailField.text, let password = passwordField.text else {print(1); return }
        if (username != "") && (email != "") && (password != "") {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (FIRUser, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "adviceIdentifier", sender: self)
                } else {
                    self.alert.isErrorAlert(presenting: self, error: error?.localizedDescription)
                }
            })
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


