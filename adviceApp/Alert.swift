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
    
    func isErrorAlert(presenting vc: UIViewController, error message: String?) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        errorAlert.addAction(defaultAction)
        
        vc.present(errorAlert, animated: true, completion: nil)
    
}

}
