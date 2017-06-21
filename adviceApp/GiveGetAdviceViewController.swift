//
//  ViewController.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 9/25/16.
//  Copyright © 2016 Tameika Lawrence. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
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
    @IBOutlet weak var navBarDisplayName: UINavigationItem!
    
    
    // MARK: Logic Properties
    
    let badWordsArray = BadWords.sharedInstance
    let store = DataStore.sharedInstance
    var isBadWord = false
    var savedAdvice = [Advice]()
    var displayedFIRAdvice: String = ""
    var ref: FIRDatabaseReference!
    var firAdviceCollection = Set([String]())
    var removedAdvice = String()
    var blockedUsers = [String]()
    var displayName = String()
    var emailAddress = String()
    var alert = Alert()
    var userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giveAdviceTextField.delegate = self
        navBarDisplayName.title! = displayName
        setDisplayName()
        setUpAdviceTextLabel()
        setUpAdviceTextField()
        setupAdviceButtons()
        store.fetchData()
        giveAdviceTextField.autocapitalizationType = .none
    }
    
    
    func setDisplayName() {
        userDefaults.set(displayName, forKey: "username")
        userDefaults.synchronize()
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
                       delay: 0.0, usingSpringWithDamping: 0.50, initialSpringVelocity: CGFloat(1.0), options: .curveLinear, animations: {
                        self.logoTitle.center.x += self.view.bounds.width
        })
        
        logoA.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 10.0, options: .curveLinear, animations: {
            self.logoA.transform = CGAffineTransform.identity
        })
        
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.50, initialSpringVelocity: CGFloat(1.0), options: .curveLinear, animations: {
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
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
            self.flagAdviceBtn.alpha = 0.9
        })
    }
    
    // MARK : Dismiss Keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // MARK : Retrieving Database Data
    
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
        })
    }
    
    // MARK : Giving Advice Logic
    
    @IBAction func submitAdviceBtnPressed(_ sender: UIButton) {
        animateGiveButtonPress()
        guard !isBadWord else { return }
        guard var adviceReceived = giveAdviceTextField.text else { return }
        adviceReceived += (" - " + displayName)
        let newAdvice = Advice(context: store.persistentContainer.viewContext)
        newAdvice.content = adviceReceived
        store.adviceArray.append(newAdvice)
        giveAdviceTextField.text = ""
        getAdviceBtnOutlet.isEnabled = true
        giveAdviceBtnOutlet.isEnabled = false
        store.saveContext()
        let newRef = FIRDatabase.database().reference().child("Advice").childByAutoId()
        newRef.setValue(["user": displayName, "content": adviceReceived])
    }
    
    //MARK : Blocking User Logic
    
    func blockUser() {
        for advice in firAdviceCollection{
            for user in blockedUsers {
                if advice.contains(user) {
                    guard let index = firAdviceCollection.index(of: advice) else { return }
                    firAdviceCollection.remove(at: index)
                }
            }
        }
    }
    
    //MARK : Getting Advice Logic
    
    @IBAction func receiveAdviceBtnPressed(_ sender: UIButton) {
        animateGetButtonPress()
        animateInFlagButton()
        blockUser()
        guard firAdviceCollection.count >= 1 else {
            displayAdviceTextLabel.textColor = UIColor.eggplant
            displayAdviceTextLabel.text = "no more advice available"
            return
        }
        savedAdviceBtn.isEnabled = true
        let randomFIRAdviceIndex = Int(arc4random_uniform(UInt32(firAdviceCollection.count)))
        removedAdvice = firAdviceCollection.remove(at: firAdviceCollection.index(firAdviceCollection.startIndex, offsetBy: randomFIRAdviceIndex))
        displayAdviceTextLabel.text = removedAdvice
    }
    
    // MARK : Saving Advice Logic
    
    func saveThisAdvice(selectedAdvice: String) {
        let advice = Advice(context: store.persistentContainer.viewContext)
        advice.content = selectedAdvice
        advice.isFavorited = true
    }
    
    func saveBlockedUser() {
        
        let newBlock = Advice(context: store.persistentContainer.viewContext)
        for user in blockedUsers {
            print("👫",user)
            newBlock.blocked = user
            print("🗣",newBlock)
            store.blockedArray.append(newBlock)
            store.saveContext()
        }
        
        print("❗️",store.blockedArray)
    }
    
    @IBAction func saveAdvicePressed(_ sender: Any) {
        animateSaveButtonPress()
        if displayAdviceTextLabel.text != nil {
            saveThisAdvice(selectedAdvice: removedAdvice)
            store.saveContext()
            alert.isSavedAlert(presenting: self)
        }
    }
    
    // MARK : Flagging Content Logic
    
    @IBAction func flagAdviceBtn(_ sender: Any) {
        var allUsers = Set([String]())
        let ref = FIRDatabase.database().reference()
        let availableRef = ref.child("Advice")
        
        availableRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let databaseData = snapshot.value as? [String : Any] else { return }
            //print("👅",databaseData)
            for (key, value) in databaseData {
                guard let contentDict = value as? [String : String] else { return }
                //print("💤",contentDict)
                guard let user = contentDict["user"] else { return }
                allUsers.insert(user)
                //print("👍🏽",allUsers)
                
            }
            
        })

        
        
        
        let isFlaggedAlert = UIAlertController(title: "Choose One", message: "What would you like to do?", preferredStyle: .alert)
        print(1)
        
        let block = UIAlertAction(title: "block this user", style: .destructive, handler: { (action) in
            for name in allUsers {
                if self.removedAdvice.contains(name) {
                    
                    self.blockedUsers.append(name)
                    print("💔",self.blockedUsers)
                    self.saveBlockedUser()
                }
            }
        })
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: { (action) in
            print("cancel tapped")
        })
        
        let actions = [block, cancel]
        for a in actions {
            isFlaggedAlert.addAction(a)
        }
        self.present(isFlaggedAlert, animated: true, completion: nil)
        print("👥", self.blockedUsers)

        
        
    
        
//                    let remove = UIAlertAction(title: "remove this advice", style: .destructive, handler: { (action) in
//                        print("remove tapped")
//
//                    })
//                    
                   //
                //}
                
            //})
        
    }
    
    // MARK: Logout Logic
    
    @IBAction func logoutBtn(_ sender: UIBarButtonItem) {
        guard let firebaseAuth = FIRAuth.auth() else { return }
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "logoutIdentifier", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: \(firebaseAuth.currentUser)", signOutError)
        }
    }
    
    
    // MARK : Filtering Bad Words
    
    func badWordFilter() -> Bool {
        for word in badWordsArray.badWordsList {
            if let adviceText = giveAdviceTextField.text {
                if adviceText.contains(word) {
                    alert.isBadAlert(presenting: self)
                }
                return true
            } else {
                
            }
        }
        return false
    }
}

// MARK : UITextFieldDelegate Methods

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        if !(string + currentText).isEmpty && ((string + currentText).characters.count <= 160) {
            giveAdviceBtnOutlet.isEnabled = true
        }
        return true
    }
}




