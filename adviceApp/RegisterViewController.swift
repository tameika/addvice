//
//  RegisterViewController.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 12/12/16.
//  Copyright © 2016 flatiron. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true 
        
        
        registerBtn.layer.borderWidth = 2.0
        registerBtn.layer.borderColor = CGColor.white.cgColor
        registerBtn.clipsToBounds = true
        //registerBtn.layer.cornerRadius = registerBtn.bounds.height * 0.5
        registerBtn.backgroundColor = UIColor.clear
        
        cancelBtn.layer.borderWidth = 2.0
        cancelBtn.layer.borderColor = CGColor.white.cgColor
        cancelBtn.clipsToBounds = true
        cancelBtn.backgroundColor = UIColor.clear
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        usernameField.center.x -= view.bounds.width
//        passwordField.center.x -= view.bounds.width
//        registerBtn.center.y += view.bounds.width * 2.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        UIView.animate(withDuration: 0.6,
//                       delay: 0.0,
//                       usingSpringWithDamping: CGFloat(0.50),
//                       initialSpringVelocity: CGFloat(1.0),
//                       options: UIViewAnimationOptions.curveLinear,
//                       animations: {
//                        self.usernameField.center.x += self.view.bounds.width
//        },
//                       completion: { Void in()  }
//        )
//
//
//        UIView.animate(withDuration: 0.6,
//                       delay: 0.1,
//                       usingSpringWithDamping: CGFloat(0.50),
//                       initialSpringVelocity: CGFloat(1.0),
//                       options: UIViewAnimationOptions.allowUserInteraction,
//                       animations: {
//                        self.passwordField.center.x += self.view.bounds.width
//        },
//                       completion: { Void in()  }
//        )
//        
//        
//        UIView.animate(withDuration: 0.8,
//                       delay: 0.1,
//                       options: .curveEaseInOut,
//                       animations:  {
//                        self.registerBtn.center.y -= self.view.center.y * 2.3
//        },
//                       completion: { Void in()
//        })
        

    }


    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        print("🔥inside the register btn and it was pressed")
 
        guard let username = usernameField.text, let password = passwordField.text, let passwordConfirmation = confirmPasswordField.text else { return }
        
        guard username != "" && password != "" && passwordConfirmation != "" else { return }
        
        if password != passwordConfirmation {
            
            confirmPasswordField.backgroundColor = UIColor.red
            //animate field also
        }else{
            
 
        FIRAuth.auth()?.createUser(withEmail: username, password: password, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                print("🔥successfully created new user")
                
                NotificationCenter.default.post(name: .closeLoginVC, object: nil)
        
            }else{
                print("🔥failure to create new user")
            }
        })
        }
    
    }
    

    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
 
    
    
    // TODO: fix constraints for all devices
    // TODO: present user with registration success message
    
    
    
}



