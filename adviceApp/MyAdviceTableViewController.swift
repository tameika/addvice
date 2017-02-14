//
//  MyAdviceTableViewController.swift
//  adviceApp
//
//  Created by Tameika Lawrence on 11/27/16.
//  Copyright © 2016 flatiron. All rights reserved.
//

import UIKit



class MyAdviceTableViewController: UITableViewController {
    
    var savedAdviceList = [Advice]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        tableView.estimatedRowHeight = 50.0
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataStore.sharedInstance.fetchFavorites()
        savedAdviceList = DataStore.sharedInstance.favorites
        animateTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return savedAdviceList.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "adviceCell", for: indexPath)
        
     let pieceOfAdvice = savedAdviceList[indexPath.row]
      
        cell.textLabel?.text = pieceOfAdvice.content
        
        cell.backgroundColor = UIColor.clear
        
        cell.textLabel?.font = UIFont(name: "Avenir-Light", size: 22)
        
        cell.textLabel?.sizeToFit()
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.lineBreakMode = .byWordWrapping
 
     return cell
        
     }
    
   
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            self.savedAdviceList.remove(at: index.row)

            tableView.deleteRows(at: [index], with: .fade)
            
            DataStore.sharedInstance.favorites[index.row].isFavorited = false
            
            DataStore.sharedInstance.saveContext()
            
            DataStore.sharedInstance.fetchFavorites()
            
            self.tableView.reloadData()
            
            print("delete")
        }

        delete.backgroundColor = UIColor.darkGray
        
        return [delete]
    }
  
    
    func animateTableView() {
        
        tableView.reloadData()
        let cell = tableView.visibleCells
        let tableHeight = tableView.bounds.height
        for i in cell {
            let cell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0.0, y: tableHeight)
        }
        
        var index = 0
        for m in cell {
            let cell = m as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
                cell.transform = CGAffineTransform.identity;
            }, completion: nil)

            index += 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableViewAutomaticDimension
    }
    
    
}
