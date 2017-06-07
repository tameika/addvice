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
    @IBOutlet weak var enterBtn: UIButton!
    
    var containerVC = ContainerViewController()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //isCurrentUser()
        setUpUsernameField()
        setUpEnterButton()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
//    func isCurrentUser() {
//        
//        if containerVC.userDefaults.bool(forKey: "isFirstLaunch") == false {
//            performSegue(withIdentifier: "showAddviceIdentifier", sender: self)
//            print("🍌 user is not new; isFirstLaunch = false")
//        } else if containerVC.userDefaults.bool(forKey: "isFirstLaunch") == true {
//            shouldPerformSegue(withIdentifier: "showAddviceIdentifier", sender: self)
//
//        }
//    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if containerVC.userDefaults.bool(forKey: "isFirstLaunch") == false {
            print("🍌 user is not new; isFirstLaunch = false")
            return true
        } else {
        }
        return false

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
        usernameField.attributedPlaceholder = NSAttributedString(string: "start typing here", attributes: [NSForegroundColorAttributeName: UIColor.seafoamGreen])
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
        guard let username = usernameField.text else { return }
        if (username != "") && !(username.contains(" ")) && (username.characters.count >= 5) && (username.characters.count <= 12) {
            makeFieldBackgroundLilac()
            enterBtn.isEnabled = true
        } else {
            enterBtn.isEnabled = false
            return makeFieldBackgroundRed()
        }

    }
    
    
    @IBAction func enterBtn(_ sender: Any) {
     
       
    }
    
    
    
  }




    





