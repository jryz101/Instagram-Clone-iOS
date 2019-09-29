//  UserTableViewController.swift
//  Instagram Clone iOS
//  Created by Jerry Tan on 29/09/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import Parse

class UserTableViewController: UITableViewController {
    
    
    
    //MARK: - logout action
    @IBAction func logoutButton(_ sender: Any) {
        
        ////log out user
        PFUser.logOut()
        
        ////perform segue after user log out
        performSegue(withIdentifier: "logoutSegue", sender: self)
        
    }
    
    
    
    
    //MARK: - view did load section
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    

    // MARK: - Table view data source section
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = "Test Cell"
        
        return cell
    }
}
