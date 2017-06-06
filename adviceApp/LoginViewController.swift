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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUsernameField()
        setUpEnterButton()
        textfieldCharacterLimit()
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
        usernameField.layer.borderColor = UIColor.seafoamGreen.cgColor
        
    }
    
    func setUpEnterButton() {
        enterBtn.clipsToBounds = true
        enterBtn.layer.borderWidth = 0.60
        enterBtn.layer.cornerRadius = enterBtn.bounds.height * 0.50
        enterBtn.layer.borderColor = UIColor.seafoamGreen.cgColor
        self.enterBtn.isEnabled = false
        print("button is created and disabled")

    }
    
//    func makeBackgroundRed() {
//        
//        usernameField.layer.backgroundColor = UIColor.
//    }
    
    func makeBackgroundLilac() {
        UIView.animate(withDuration: 1.0, delay: 5.0, options: [.curveEaseIn], animations: {
            self.usernameField.layer.backgroundColor = UIColor.lilac.cgColor
        })
        UIView.setAnimationRepeatCount(3.0)
        
    }
   
    
    func textfieldCharacterLimit()  {
        guard let username = usernameField.text else { return }
        if (username.characters.count > 4) && (username.characters.count < 13) {
            makeBackgroundLilac()
            enterBtn.isEnabled = true
            print("username is right length")
            print("button is enabled")
        }
        
//        else {
//            enterBtn.isEnabled = false
//            print("button is still not enabled")
//        }
    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.text?.characters.count == 12 {
//            return true
//
//        } else {
//            return false
//        }
//    }
    
    // MARK:
    
    @IBAction func enterBtn(_ sender: Any) {
     

    }
    
  }




    





