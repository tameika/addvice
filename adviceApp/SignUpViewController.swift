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
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    var containerVC = ContainerViewController()
    var adviceVC: ViewController!
    var alert = Alert()
    var blockedUsers = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpUsernameField()
        setUpEmailField()
        setUpPasswordField()
        setUpEnterButton()
        //retrieveExistingUsers()
        
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
        
    }
    
    
    @IBAction func emailFieldAction(_ sender: Any) {
    }
    
    
    
    @IBAction func passwordFieldAction(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adviceIdentifier" {
            if let dest = segue.destination as? ViewController {
                guard let username = usernameField.text else { print("SETTING USERNAME FAILED"); return }
                dest.displayName = username

            }
        }
    }
    
    
    @IBAction func enterBtn(_ sender: Any) {
        guard let username = usernameField.text, let email = emailField.text, let password = passwordField.text else {print(1); return }
        if (username != "") && (email != "") && (password != "") {
            print(3)
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (FIRUser, error) in
                if error == nil {
                    print(4)
                    self.performSegue(withIdentifier: "adviceIdentifier", sender: self)
                } else {
                    print(6)
                    self.alert.isErrorAlert(presenting: self, error: error?.localizedDescription)
                    print(7)
                }
            })
            
        }
        
    }
  
    

    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//end
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







