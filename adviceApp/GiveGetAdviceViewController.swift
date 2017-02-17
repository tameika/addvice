//
//  ViewController.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 9/25/16.
//  Copyright © 2016 flatiron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import QuartzCore
import CoreData


class ViewController: UIViewController {
    
    // MARK: UI Properties
    
    @IBOutlet weak var giveAdviceTextField: UITextField! // giveAdviceTextField
    @IBOutlet weak var displayAdviceTextLabel: UILabel!
    @IBOutlet weak var getAdviceBtnOutlet: UIButton! // getAdviceButton
    @IBOutlet weak var savedAdviceBarBtn: UIBarButtonItem! // savedAdviceButton
    @IBOutlet weak var savedAdviceBtn: UIButton!
    @IBOutlet weak var giveAdviceBtnOutlet: UIButton!
    @IBOutlet weak var logoA: UIImageView!
    @IBOutlet weak var logoTitle: UILabel!
    
    
    
    // MARK: Logic Properties
    
    let badWordsArray = BadWords.sharedInstance
    let store = DataStore.sharedInstance
    var badWordFlag = false
    var savedAdvice = [Advice]()
    var displayedFIRAdvice: String = ""
    var ref: FIRDatabaseReference!
    var firAdviceArray = [String]()
    var removedAdvice = String()
    
    
    let seafoamGreen = UIColor(red:0.82, green:0.94, blue:0.87, alpha:1.0)
    let eggplant = UIColor(red:0.17, green:0.03, blue:0.25, alpha:0.5)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        giveAdviceTextField.delegate = self
        setUpAdviceTextLabel()
        setUpAdviceTextField()
        setupAdviceButtons()
        store.fetchData()
    }
    
    // MARK: Setting Up UI Objects
    
    func setUpAdviceTextLabel() {
        
        self.displayAdviceTextLabel.clipsToBounds = true
        self.displayAdviceTextLabel.layer.cornerRadius = 5.0
        self.displayAdviceTextLabel.layer.borderWidth = 1.0
        self.displayAdviceTextLabel.layer.borderColor = eggplant.cgColor
    }
    
    func setUpAdviceTextField() {
        
        self.giveAdviceTextField.borderStyle = .roundedRect
        self.giveAdviceTextField.layer.borderColor = UIColor.clear.cgColor
        self.giveAdviceTextField.layer.borderWidth = 2.0
        self.giveAdviceTextField.textColor = UIColor.black
    }
    
    func setupAdviceButtons() {
        
        self.getAdviceBtnOutlet.isEnabled = false
        self.savedAdviceBtn.isEnabled = false
        self.giveAdviceBtnOutlet.isEnabled = false
        
        self.giveAdviceBtnOutlet.clipsToBounds = true
        self.giveAdviceBtnOutlet.layer.cornerRadius = giveAdviceBtnOutlet.bounds.height * 0.5
        self.giveAdviceBtnOutlet.backgroundColor = eggplant
        self.giveAdviceBtnOutlet.titleEdgeInsets = UIEdgeInsetsMake(0.0, -5.0, 0.0, -5.0)
        
        self.getAdviceBtnOutlet.clipsToBounds = true
        self.getAdviceBtnOutlet.layer.cornerRadius = getAdviceBtnOutlet.bounds.height * 0.5
        self.getAdviceBtnOutlet.backgroundColor = eggplant
        
        self.savedAdviceBtn.clipsToBounds = true
        self.savedAdviceBtn.layer.cornerRadius = savedAdviceBtn.bounds.height * 0.5
        self.savedAdviceBtn.backgroundColor = eggplant
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        logoA.center.x -= view.bounds.width
        logoTitle.center.x -= view.bounds.width
        animateInLogoTitle()
        giveAdviceBtnOutlet.isUserInteractionEnabled = false
        
        getFIRAdvice(handler: { _ in
            DispatchQueue.main.async {
                self.giveAdviceBtnOutlet.isUserInteractionEnabled = true
            }
        })
    }
    
    
    // MARK: Logo Animation
    
    func animateInLogoTitle() {
        
        UIView.animate(withDuration: 0.6,
                       delay: 0.0,
                       usingSpringWithDamping: 0.50, initialSpringVelocity: CGFloat(1.0),
                       options: .curveLinear,
                       animations: {
                        self.logoTitle.center.x += self.view.bounds.width
        })
        
        UIView.animate(withDuration: 0.6,
                       delay: 0.1, usingSpringWithDamping: 0.50,
                       initialSpringVelocity: CGFloat(1.0),
                       options: .curveLinear,
                       animations: {
                        self.logoA.center.x += self.view.bounds.width
        })
        
        logoA.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 1.0,
                       delay: 0.5,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 10.0,
                       options: .curveLinear,
                       animations: {
                        self.logoA.transform = CGAffineTransform.identity
        })
    }
    
    // MARK: Button Animation
    
    func animateGiveButtonPress() {
        UIView.animate(withDuration: 0.1, animations: {
            self.giveAdviceBtnOutlet.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1, animations: {
                            self.giveAdviceBtnOutlet.transform = CGAffineTransform.identity
                        })
        })
    }
    
    func animateGetButtonPress() {
        UIView.animate(withDuration: 0.1, animations: {
            self.getAdviceBtnOutlet.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1, animations: {
                            self.getAdviceBtnOutlet.transform = CGAffineTransform.identity
                        })
        })
    }
    
    func animateSaveButtonPress() {
        UIView.animate(withDuration: 0.1, animations: {
            self.savedAdviceBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1, animations: {
                            self.savedAdviceBtn.transform = CGAffineTransform.identity
                        })
        })
        
    }
    
    // MARK: Dismiss Keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    func getFIRAdvice(handler: @escaping () -> Void) {
        let ref = FIRDatabase.database().reference()
        let receivedRef = ref.child("Advice")
        receivedRef.observeSingleEvent(of: .value, with: { snapshot in
            if let firAdvice = snapshot.value as? [String : Any] {
                for (_, value) in firAdvice {
                    if let contentsDictionary = value as? [String : String] {
                        let content = contentsDictionary["content"] ?? "NO CONTENT"
                        self.firAdviceArray.append(content)
                    }
                }
                
                // TODO: Add a completion closure to this function and then call on it here letting the caller know all is good.
                
            }
            handler()
            print("🌽\(self.firAdviceArray.count)")
        })
    }
    
    // MARK: Giving Advice Logic
    
    @IBAction func submitAdviceBtnPressed(_ sender: UIButton) {
        animateGiveButtonPress()
        guard !badWordFilter() else { return }
        guard let adviceReceived = giveAdviceTextField.text else { return }
        let newAdvice = Advice(context: store.persistentContainer.viewContext)
        newAdvice.content = adviceReceived
        store.adviceArray.append(newAdvice)
        giveAdviceTextField.text = ""
        getAdviceBtnOutlet.isEnabled = true
        giveAdviceBtnOutlet.isEnabled = false
        store.saveContext()
        let ref = FIRDatabase.database().reference()
        ref.child("Advice").childByAutoId().setValue(["content": adviceReceived])
    }
    
    
    
    //MARK: Getting Advice Logic
    
    @IBAction func receiveAdviceBtnPressed(_ sender: UIButton) {
        animateGetButtonPress()
        guard firAdviceArray.count > 1 else {
            displayAdviceTextLabel.textColor = seafoamGreen
            displayAdviceTextLabel.text = "no more advice available"
            return
        }
        savedAdviceBtn.isEnabled = true
        let randomFIRAdviceIndex = Int(arc4random_uniform(UInt32(firAdviceArray.count)))
        print("🌮\(randomFIRAdviceIndex)")
        print("🍿\(self.firAdviceArray.count)")
        removedAdvice = firAdviceArray.remove(at: randomFIRAdviceIndex)
        displayAdviceTextLabel.text = removedAdvice
        print("🍧", removedAdvice)
    }
    
    
    // MARK: Saving Advice
    
    func saveThisAdvice(selectedAdvice: String) {
        let advice = Advice(context: store.persistentContainer.viewContext)
        advice.content = selectedAdvice
        advice.isFavorited = true
        print("📢selected advice is now of type Advice")
    }
    
    
    @IBAction func saveAdvicePressed(_ sender: Any) {
        animateSaveButtonPress()
        if displayAdviceTextLabel.text != nil {
            saveThisAdvice(selectedAdvice: removedAdvice)
            print("🔮", removedAdvice)
            store.saveContext()
            adviceIsSavedAlert()
        }
    }
    
    
    func adviceIsSavedAlert() {
        let alert = UIAlertController(title: "Advice Saved!", message: "Click sav❥d Up Top To See", preferredStyle: UIAlertControllerStyle.alert)
        print("advice is saved alert")
        let okAction = UIAlertAction(title: "Great", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: Filter Bad Words
    
    func badWordFilter() -> Bool {
        for word in badWordsArray.badWordsList {
            if let adviceText = giveAdviceTextField.text {
                if adviceText.contains(word) {
                    print(word)
                    let alert = UIAlertController(title: "Chill, chill, chill", message: "You can't curse here.", preferredStyle: UIAlertControllerStyle.alert)
                    print("bad word alert")
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
    
}


// MARK: - UITextFieldDelegate Methods
extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // TODO: Bug. If user hits space bar, it thinks that it qualifies as a String (where it thinks it's NOT empty) which enables the button. Soemthign to thing about. (1.1)
        
        let currentText = textField.text ?? ""
        if !(string + currentText).isEmpty && ((string + currentText).characters.count <= 164) {
            giveAdviceBtnOutlet.isEnabled = true
        }
        return true
    }
}




/* Todo:
 - include tutorial??
 //TODO: Receiving own advice. Fix dat.
 
 
 VERSION 1.1
 - prevent saving same advice multiple times
 - add timestamp to advice
 - add saved counter for each advice
 - add character counter
 - button to clear the screen?
 
 */
