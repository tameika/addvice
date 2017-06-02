//
//  ViewController.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 9/25/16.
//  Copyright © 2016 Tameika Lawrence. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData


class ViewController: UIViewController {
    
    // MARK: UI Properties
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var giveAdviceTextField: UITextField!
    @IBOutlet weak var displayAdviceTextLabel: UILabel!
    @IBOutlet weak var getAdviceBtnOutlet: UIButton!
    @IBOutlet weak var savedAdviceBarBtn: UIBarButtonItem!
    @IBOutlet weak var savedAdviceBtn: UIButton!
    @IBOutlet weak var giveAdviceBtnOutlet: UIButton!
    @IBOutlet weak var logoA: UIImageView!
    @IBOutlet weak var logoTitle: UILabel!
    @IBOutlet weak var flagAdviceBtn: UIButton!
    
    
    // MARK: Logic Properties
    
    let badWordsArray = BadWords.sharedInstance
    let store = DataStore.sharedInstance
    var badWordFlag = false
    var savedAdvice = [Advice]()
    var displayedFIRAdvice: String = ""
    var ref: FIRDatabaseReference!
    var firAdviceCollection = Set([String]())
    var removedAdvice = String()
    
    
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
        self.displayAdviceTextLabel.layer.borderColor = UIColor.eggplant.cgColor
    }
    
    func setUpAdviceTextField() {
        
        self.giveAdviceTextField.clipsToBounds = true
        self.giveAdviceTextField.layer.borderColor = UIColor.clear.cgColor
        self.giveAdviceTextField.layer.borderWidth = 2.0
        self.giveAdviceTextField.textColor = UIColor.black
    }
    
    func setupAdviceButtons() {
        
        self.getAdviceBtnOutlet.isEnabled = false
        self.savedAdviceBtn.isEnabled = false
        self.giveAdviceBtnOutlet.isEnabled = false
        self.flagAdviceBtn.alpha = 0.0
        
        self.giveAdviceBtnOutlet.clipsToBounds = true
        self.giveAdviceBtnOutlet.layer.cornerRadius = giveAdviceBtnOutlet.bounds.height * 0.50
        self.giveAdviceBtnOutlet.backgroundColor = UIColor.eggplant
        
        self.getAdviceBtnOutlet.clipsToBounds = true
        self.getAdviceBtnOutlet.layer.cornerRadius = getAdviceBtnOutlet.bounds.height * 0.50
        self.getAdviceBtnOutlet.backgroundColor = UIColor.eggplant
        
        self.savedAdviceBtn.clipsToBounds = true
        self.savedAdviceBtn.layer.cornerRadius = savedAdviceBtn.bounds.height * 0.50
        self.savedAdviceBtn.backgroundColor = UIColor.eggplant
        
        self.flagAdviceBtn.clipsToBounds = true
        self.flagAdviceBtn.layer.cornerRadius = flagAdviceBtn.bounds.height * 0.50
        self.flagAdviceBtn.backgroundColor = UIColor.eggplantDark
        
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
        
        
        logoA.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 1.0,
                       delay: 0.5,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 10.0,
                       options: .curveLinear,
                       animations: {
                        self.logoA.transform = CGAffineTransform.identity
        })
        
        
        UIView.animate(withDuration: 0.6,
                       delay: 0.1, usingSpringWithDamping: 0.50,
                       initialSpringVelocity: CGFloat(1.0),
                       options: .curveLinear,
                       animations: {
                        self.logoA.center.x += self.view.bounds.width
        }) { _ in
            (self.childViewControllers.first as? ContainerViewController)?.isUsersFirstTime()
        }
        
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
    
    func animateInFlagButton() {
        UIView.animate(withDuration: 0.8, delay: 0.6, options: .curveEaseInOut, animations: {
            self.flagAdviceBtn.alpha = 0.9
        })
        
    }
    
    
    
    // MARK: Dismiss Keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // MARK: Retrieving Database Data
    
    func getFIRAdvice(handler: @escaping () -> Void) {
        let ref = FIRDatabase.database().reference()
        let receivedRef = ref.child("Advice")
        receivedRef.observeSingleEvent(of: .value, with: { snapshot in
            if let firAdvice = snapshot.value as? [String : Any] {
                for (_, value) in firAdvice {
                    if let contentsDictionary = value as? [String : String] {
                        let content = contentsDictionary["content"] ?? "NO CONTENT"
                        self.firAdviceCollection.insert(content)
                    }
                }
                
            }
            handler()
            print("🌽\(self.firAdviceCollection.count)")
        })
    }
    
    
    // MARK: Giving Advice Logic
    
    @IBAction func submitAdviceBtnPressed(_ sender: UIButton) {
        animateGiveButtonPress()
        guard !badWordFlag else { return }
        guard let adviceReceived = giveAdviceTextField.text else { return }
        let newAdvice = Advice(context: store.persistentContainer.viewContext)
        newAdvice.content = adviceReceived
        store.adviceArray.append(newAdvice)
        giveAdviceTextField.text = ""
        getAdviceBtnOutlet.isEnabled = true
        giveAdviceBtnOutlet.isEnabled = false
        store.saveContext()
        let newRef = FIRDatabase.database().reference().child("Advice").childByAutoId()
        newRef.setValue(["user": "tameika", "content": adviceReceived])
    }
    
    
    //MARK: Getting Advice Logic
    
    @IBAction func receiveAdviceBtnPressed(_ sender: UIButton) {
        animateGetButtonPress()
        animateInFlagButton()
        animateInFlagButton()
        guard firAdviceCollection.count >= 1 else {
            displayAdviceTextLabel.textColor = UIColor.eggplant
            displayAdviceTextLabel.text = "no more advice available"
            return
        }
        savedAdviceBtn.isEnabled = true
        let randomFIRAdviceIndex = Int(arc4random_uniform(UInt32(firAdviceCollection.count)))
        print("🌮\(randomFIRAdviceIndex)")
        print("🍿\(self.firAdviceCollection.count)")
        removedAdvice = firAdviceCollection.remove(at: firAdviceCollection.index(firAdviceCollection.startIndex, offsetBy: randomFIRAdviceIndex))
        displayAdviceTextLabel.text = removedAdvice
        print("🍧", removedAdvice)
    }
    
    
    // MARK: Saving Advice Logic
    
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
    
    
    // MARK : Flagging Advice Logic
    
    @IBAction func flagAdviceBtn(_ sender: Any) {
        let ref = FIRDatabase.database().reference()
        let availableRef = ref.child("Advice")
        availableRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let firAdvice = snapshot.value as? [String : Any] else { return }
            for (key, value) in firAdvice {
                guard var contentDictionary = value as? [String : String] else { print("nothing"); return }
                if contentDictionary["content"] == self.removedAdvice {
                    availableRef.child(key).removeValue()
                    let alert = UIAlertController(title: "Thank You!", message: "This piece of advice will be removed.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    self.displayAdviceTextLabel.text = ""
                    
                } else {
                    print("IS NOT OBJECTIONABLE CONTENT")
                }
            }
        })
        
    }
    
    
    // MARK: Filtering Bad Words
    
    func badWordFilter() -> Bool {
        for word in badWordsArray.badWordsList {
            if let adviceText = giveAdviceTextField.text {
                if adviceText.contains(word) {
                    print(word)
                    let alert = UIAlertController(title: "Chill, chill, chill", message: "Watch your language.", preferredStyle: UIAlertControllerStyle.alert)
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


// MARK: UITextFieldDelegate Methods

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        if !(string + currentText).isEmpty && ((string + currentText).characters.count <= 160) {
            giveAdviceBtnOutlet.isEnabled = true
        }
        return true
    }
}




