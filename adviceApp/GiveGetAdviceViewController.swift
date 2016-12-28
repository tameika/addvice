//
//  ViewController.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 9/25/16.
//  Copyright © 2016 flatiron. All rights reserved.
//

import UIKit

// create protocol (a type to use later) which holds property or method


// create an extension on the viewcontroller class to adopt and conform to the protocol
// send delegate to the needed viewcontroller using a segue


protocol disableSavedAdviceList {
    func disableSavedAdviceList()
}

class ViewController: UIViewController {
    
    // MARK: UI Properties
    
    @IBOutlet weak var giveAdviceTextField: UITextField!
    
    @IBOutlet weak var displayAdviceTextLabel: UILabel!
    
    @IBOutlet weak var getAdviceBtnOutlet: UIButton!
 
    @IBOutlet weak var savedAdviceBarBtn: UIBarButtonItem!
    
    @IBOutlet weak var savedAdviceBtn: UIButton!
    
    @IBOutlet weak var giveAdviceBtnOutlet: UIButton!
    
    var userHasSkippedLogin: Bool = false
    
    
    // MARK: Logic Properties
    
    let badWordsArray = BadWords.sharedInstance
    let store = DataStore.sharedInstance
    var badWordFlag = false
    var currentAdviceIndex: Int?
    var savedAdvice = [Advice]()
    var displayedAdvice: Advice!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userHasSkippedLogin {
            
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
            
            //
            
        }
        
    }
    
    
    func disableSaveButton() {
        savedAdviceBarBtn.isEnabled = false
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
        
        segue.identifier == "myAdviceListSegue"
            print("going to saved adivce list table")
//        } else  {
//            let dest = segue.destination as? LoginViewController
//            dest?.skipDelegate = self
//        }
    }
    
    
 //end
    
}


//extension ViewController: disableSavedAdviceList {
//    
//    func disableSavedAdviceList() {
//        savedAdviceBarBtn.isEnabled = false
//    }
//}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // TODO: Bug. If user hits space bar, it thinks that it qualifies as a String (where it thinks it's NOT empty) which enables the button. Soemthign to thing about.
        
        let currentText = textField.text ?? ""
        
        if !(string + currentText).isEmpty {
            
            giveAdviceBtnOutlet.isEnabled = true
            
        }
        
        
        
        
        
        return true
    }
}




//To do list:


//3. decide whether there should be limit to how many times get advice can be clicked

// decide how many times someone can submit advice

// animate alert controller

// FLAG BAD ADVICE 




