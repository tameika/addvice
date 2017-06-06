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
        setEnterButton()
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
    
    func setEnterButton() {
        
        enterBtn.clipsToBounds = true
        enterBtn.layer.borderWidth = 0.60
        enterBtn.layer.cornerRadius = enterBtn.bounds.height * 0.50
        enterBtn.layer.borderColor = UIColor.seafoamGreen.cgColor
    }
   
    
    // MARK:
    
    @IBAction func enterBtn(_ sender: Any) {
        
        
    }

}




