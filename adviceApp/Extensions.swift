//
//  Extensions.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 1/22/17.
//  Copyright © 2017 flatiron. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //static let white = UIColor.init(red:1.00, green:1.00, blue:1.00, alpha:0.70)
    static let lilac = UIColor(red:0.86, green:0.73, blue:0.94, alpha:1.0)
    
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

extension UITextField {
    
    func useUnderline() {
        
        let border = CALayer()
        let borderWidth = CGFloat(2.0)
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderColor = UIColor.white.cgColor
        
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
