//
//  LoginViewController.swift
//  addvice
//
//  Created by Tameika Lawrence on 6/1/17.
//
//

import UIKit
import FirebaseDatabase


class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var enterBtn: UIButton!
    
    var containerVC = ContainerViewController()
    var adviceVC: ViewController!
    var allUsers = [String]()
    var isAvailable = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpUsernameField()
        setUpEnterButton()
        retrieveExistingUsers()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    // determines whether a segue w the indentifieer should be performed
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print("should perform segue fired")
        if containerVC.userDefaults.bool(forKey: "isFirstLaunch") == false {
            print("🍌 user is not new; isFirstLaunch = false")
            
            
            // if is current user return true and perform
            return true
        } else {
            
            //if is not current user return false and stay
            return false
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddviceIdentifier" {
            guard let username = usernameField.text else { return }
            guard let dest = segue.destination as? ViewController else { return }
            dest.displayName = username
        }
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
        usernameField.attributedPlaceholder = NSAttributedString(string: "start typing", attributes: [NSForegroundColorAttributeName: UIColor.seafoamGreen])
        usernameField.layer.borderColor = UIColor.seafoamGreen.cgColor
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
        checkAvailability()

        guard let username = usernameField.text else { return }
        if (username != "") && !(username.contains(" ")) && (username.characters.count >= 5) && (username.characters.count <= 12) {
            makeFieldBackgroundLilac()
            enterBtn.isEnabled = true
        } else {
            enterBtn.isEnabled = false
            return makeFieldBackgroundRed()
        }
    }
    
    
    
    func retrieveExistingUsers() {
        let ref = FIRDatabase.database().reference()
        let availableRef = ref.child("Advice")
        availableRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let existingUsers = snapshot.value as? [String: Any] else { return }
            for (_, value) in existingUsers {
                guard var userDictionary = value as? [String: String] else { return }
                print("☔️", userDictionary)
                let user = userDictionary["user"] ?? "NO USER"
                self.allUsers.append(user)
                print("🌶", self.allUsers)
            }
        })
        checkAvailability()
    }
    
    func checkAvailability() {
        print("inside checking availability")
        guard let username = usernameField.text else { print("i didn't get passed here"); return }
        for user in self.allUsers {
            print("🍐", user)
            print("❌", allUsers)
            if user == username {
                print("🍟", user)
                print("🍔", username)
                usernameUnavailableAlert()
            }
        }
    }
    
    
    func usernameUnavailableAlert() {
        let alertU = UIAlertController(title: "Username Unavailable", message: "Try adding a number.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertU.addAction(action)
        self.present(alertU, animated: true, completion: nil)
    }
    
    
    @IBAction func enterBtn(_ sender: Any) {
        
    }
    
    
    
}










