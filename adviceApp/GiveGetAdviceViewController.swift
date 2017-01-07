//
//  ViewController.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 9/25/16.
//  Copyright © 2016 flatiron. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    // MARK: UI Properties
    
    @IBOutlet weak var giveAdviceTextField: UITextField!
    
    @IBOutlet weak var displayAdviceTextLabel: UILabel!
    
    @IBOutlet weak var getAdviceBtnOutlet: UIButton!
 
    @IBOutlet weak var savedAdviceBarBtn: UIBarButtonItem!
    
    @IBOutlet weak var savedAdviceBtn: UIButton!
    
    @IBOutlet weak var giveAdviceBtnOutlet: UIButton!
    
    @IBOutlet weak var logoutBarBtn: UIBarButtonItem!
    
    
    var userHasSkippedLogin: Bool = false
    
    
    // MARK: Logic Properties
    
    let badWordsArray = BadWords.sharedInstance
    let store = DataStore.sharedInstance
    var badWordFlag = false
    var currentAdviceIndex: Int?
    var savedAdvice = [Advice]()
    var displayedAdvice: Advice!
    
    @IBAction func logout(_ sender: Any) {
        
        NotificationCenter.default.post(name: .closeAddviceVC, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userHasSkippedLogin {
            print("🍻inside userHasSkipped if statement")
            disableSaveButton()
            
        }
        
                
        giveAdviceTextField.delegate = self
        //self.giveAdviceBtnOutlet.layer.borderWidth = 0
        //self.giveAdviceBtnOutlet.clipsToBounds = true
        //self.giveAdviceBtnOutlet.layer.cornerRadius = giveAdviceBtnOutlet.bounds.height * 0.5
        //self.giveAdviceBtnOutlet.layer.borderColor = UIColor.white.cgColor
        //self.giveAdviceBtnOutlet.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        
//        self.getAdviceBtnOutlet.layer.borderWidth = 0
//        self.getAdviceBtnOutlet.clipsToBounds = true
//        self.getAdviceBtnOutlet.layer.cornerRadius = getAdviceBtnOutlet.bounds.height * 0.5
//        self.getAdviceBtnOutlet.layer.borderColor = UIColor.white.cgColor
//        self.getAdviceBtnOutlet.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
//
//        self.savedAdviceBtn.layer.borderWidth = 0
//        self.savedAdviceBtn.clipsToBounds = true
//        self.savedAdviceBtn.layer.cornerRadius = 10
//        self.savedAdviceBtn.layer.cornerRadius = savedAdviceBtn.bounds.height * 0.5
//        self.savedAdviceBtn.layer.borderColor = UIColor.white.cgColor
//        self.savedAdviceBtn.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        self.displayAdviceTextLabel.clipsToBounds = true 
        self.displayAdviceTextLabel.layer.cornerRadius = 5
        
        getAdviceBtnOutlet.isEnabled = false
        savedAdviceBtn.isEnabled = false
        giveAdviceBtnOutlet.isEnabled = false
        print(savedAdvice)
        store.fetchData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true

        
    }
    
    
    
    @IBAction func submitAdviceBtnPressed(_ sender: UIButton) {
        
        //animation
        guard !badWordFilter() else { return }
        
        guard let adviceReceived = giveAdviceTextField.text else { return }
        
        let newAdvice = Advice(context: store.persistentContainer.viewContext)
        
        newAdvice.content = adviceReceived
        
        store.adviceArray.append(newAdvice)
        
        giveAdviceTextField.text = ""
        
        getAdviceBtnOutlet.isEnabled = true
        
        giveAdviceBtnOutlet.isEnabled = false

        store.saveContext()
    }
    
    
    
    @IBAction func receiveAdviceBtnPressed(_ sender: UIButton) {
        
        //TODO: Receiving own advice. Fix that.
        
        savedAdviceBtn.isEnabled = true
        
        var randomAdviceIndex = Int(arc4random_uniform(UInt32(store.adviceArray.count)))
        
        if let currentAdviceIndex = currentAdviceIndex, store.adviceArray.count > 1 {
            
            while randomAdviceIndex == currentAdviceIndex {
                
                randomAdviceIndex = Int(arc4random_uniform(UInt32(store.adviceArray.count)))
            }
        }
        
        currentAdviceIndex = randomAdviceIndex
        
        displayedAdvice = store.adviceArray[randomAdviceIndex]
        
        displayAdviceTextLabel.text = displayedAdvice.content
    }
    
    
    @IBAction func saveAdvicePressed(_ sender: Any) {
        
        if displayAdviceTextLabel.text != nil {
            
            displayedAdvice.isFavorited = true
            
            store.saveContext()
            
            // TODO: Let the user know that it was saved (display something to them)
            // TODO: Also, should we then immediately display a new piece of advice after we save one?

        }
        
    }
    
    
    func disableSaveButton() {
        print("🎈inside disable save button method")
        savedAdviceBarBtn.isEnabled = false
    }
    
//    func disableLogoutButton() {
//        logoutBarBtn.isEnabled = false
//    }
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        
//        
//        try! FIRAuth.auth()?.signOut()
//        
//        self.performSegue(withIdentifier: "logoutIdentifier", sender: self)
//            
//            print("Successfully logged out \(FIRAuth.auth()?.currentUser?.email).")
//        
        
        
       
    }
   


    
    
    func badWordFilter() -> Bool {
        
        for word in badWordsArray.badWordsList {
            
            if let adviceText = giveAdviceTextField.text {
                
                if adviceText.contains(word) {
                    print(word)
                    
                    let alert = UIAlertController(title: "Wait A Fucking Minute", message: "You can't curse here.", preferredStyle: UIAlertControllerStyle.alert)
                    print("alert")
                    
                    let okAction = UIAlertAction(title: "OK Cool", style: .default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    return true
                    
                } else {
                    
                    
                }
            }
            
        }
        
        return false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "logoutIdentifier" {
            print("🍇 the current user is \(FIRAuth.auth()?.currentUser?.uid)")
            try! FIRAuth.auth()?.signOut()
            print("🎉Successfully logged out \(FIRAuth.auth()?.currentUser?.uid).")
            
        }else if segue.identifier == "showSavedAdvice" {
            print("going to showSavedAdvice")
        }
       
    }
    
    
 //end
    
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



// Todo: animate alert controller
// Todo: implement logout feature
// Todo: FLAG BAD ADVICE (1.1)




