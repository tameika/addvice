//
//  LoginViewController.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 12/20/16.
//  Copyright © 2016 flatiron. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var skipBtn: UIButton!
    
    //var skipDelegate: disableSavedAdviceList?

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        guard let username = usernameField.text, let password = passwordField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: { (FIRUser, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("🔥successfully logged in")
                self.performSegue(withIdentifier: "loginToAdviceHome", sender: self)
            }
            
        })
    }
    
    
    
    
     func prepare(for segue: UIStoryboardSegue) {
        
        if segue.identifier == "skipToAdviceHome" {
            
            let destNavController = segue.destination as! UINavigationController
            
            let firstVC = destNavController.viewControllers.first! as! ViewController
            
            firstVC.userHasSkippedLogin = true
            
        }
        
        
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
