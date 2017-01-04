//
//  AppController.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 1/3/17.
//  Copyright © 2017 flatiron. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class AppController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var actingVC: UIViewController!
    
}



// create a notif name for your vc

extension Notification.Name {
    
    static let closeAddviceHomeVC = Notification.Name("login-view-controller")
    static let closeLoginVC = Notification.Name("addvice-home-view-controller")
    
}

enum StoryboardID: String {
    case addviceHomeVC = "addvice-home-view-controller"
    case loginVC = "login-view-controller"
}

//create a notification observer to listen for the name
extension AppController {
    
    func addNotificationObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeAddviceHomeVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeLoginVC, object: nil)
        
    }
}
// load vc
extension AppController {
    
    func loadInitialViewController() {
        
        let id: StoryboardID = FIRAuth.auth()?.currentUser != nil ? .addviceHomeVC : .loginVC
        self.actingVC = self.loadViewController(withID: id)
        self.add(viewController: self.actingVC, animated: true)
        
        
    }
    
    func loadViewController(withID id: StoryboardID) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id.rawValue)
    }
}

    


extension AppController {
    
    func add(viewController: UIViewController, animated: Bool = false) {
        self.addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        containerView.alpha = 0.0
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        
        guard animated else { containerView.alpha = 1.0; return }
        
        UIView.transition(with: containerView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.containerView.alpha = 1.0
        }) { _ in }
    }
    
    func switchViewController(with notification: Notification) {
        
        switch notification.name {
        case Notification.Name.closeAddviceHomeVC:
            switchViewController(with: (StoryboardID.loginVC as? Notification)!)
        default:
            print("🔥Unable to match notification name!")
        }
        
        
    }
    
    
    
    
}




















