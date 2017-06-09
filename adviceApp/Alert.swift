//
//  Alert.swift
//  addvice
//
//  Created by Tameika Lawrence on 6/8/17.
//
//

import Foundation
import UIKit

struct Alert {
    
    func isSavedAlert(presenting vc: UIViewController) {
        let savedAlert = UIAlertController(title: "Advice Saved!", message: "Click sav❥d Up Top To See", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Great", style: .destructive, handler: nil)
        savedAlert.addAction(okAction)
        vc.present(savedAlert, animated: true, completion: nil)
    }
    
    func isBadAlert(presenting vc: UIViewController) {
        let wordAlert = UIAlertController(title: "Chill, chill, chill", message: "Watch your language.", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK Cool", style: .default, handler: nil)
        wordAlert.addAction(okAction)
        vc.present(wordAlert, animated: true, completion: nil)
    }
    
    func isUnavailableAlert(presenting vc: UIViewController) {
        let usernameAlert = UIAlertController(title: "Username Unavailable", message: "Try adding a number.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        usernameAlert.addAction(okAction)
        vc.present(usernameAlert, animated: true, completion: nil)
    }
    
}
