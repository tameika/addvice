//
//  Extensions.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 1/22/17.
//  Copyright © 2017 flatiron. All rights reserved.
//

import Foundation
import UIKit

extension CGColor {
    
    static let white = UIColor.init(red:1.00, green:1.00, blue:1.00, alpha:0.70)
    static let lilac = UIColor.init(red:0.93, green:0.87, blue:0.95, alpha:1.0)
    
}


// MARK: - UIView Extension
extension UIView {
    
    func constrainEdges(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}



extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // TODO: Bug. If user hits space bar, it thinks that it qualifies as a String (where it thinks it's NOT empty) which enables the button. Soemthign to thing about. (1.1)
        
        let currentText = textField.text ?? ""
        if !(string + currentText).isEmpty {
            giveAdviceBtnOutlet.isEnabled = true
        }
        return true
    }
}
