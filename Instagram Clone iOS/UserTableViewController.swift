//  UserTableViewController.swift
//  Instagram Clone iOS
//  Created by Jerry Tan on 29/09/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import Parse

class UserTableViewController: UITableViewController {
    
    ////usernames array
    var usernames = [""]
    
    
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
        
        ////Create a query which returns objects of this type
        let query = PFUser.query()
        
        ////Finds objects *asynchronously* and calls the given block with the results
        query?.findObjectsInBackground(block: { (users, error) in
            
            if error != nil {
                
                print(error!)
                
            } else if let users = users {
                
                ////remove first object in usernames array
                self.usernames.removeAll()
                
                for object in users {
                    
                    ////Cast object as PFUser
                    if let user = object as? PFUser {
                        
                        if let username = user.username {
                            
                            ////use components method to separate user email address to just display wording before the @
                            var usernameArray = username.components(separatedBy: "@")
                            
                            ////append data to usernames array
                            self.usernames.append(usernameArray[0])
                            
                        }
                    }
                }
                
                self.tableView.reloadData()
            }
            
        })
    }
    
    
    

    // MARK: - table view data source section
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        ////return usernames in each row section
        return usernames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = usernames[indexPath.row]
        return cell
    }
}
