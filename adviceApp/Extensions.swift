//
//  Extensions.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 1/22/17.
//  Copyright © 2017 Tameika Lawrence. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static let lilac = UIColor(red:0.86, green:0.73, blue:0.94, alpha:1.0)
    static let seafoamGreen = UIColor(red:0.82, green:0.94, blue:0.87, alpha:1.0)
    static let eggplant = UIColor(red:0.17, green:0.03, blue:0.25, alpha:0.5)
    static let eggplantDark = UIColor(red:0.17, green:0.03, blue:0.25, alpha:1.0)
    static let errorRed = UIColor(red:0.95, green:0.22, blue:0.35, alpha:1.0)

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
