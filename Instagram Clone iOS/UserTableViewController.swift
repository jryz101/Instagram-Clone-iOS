//  UserTableViewController.swift
//  Instagram Clone iOS
//  Created by Jerry Tan on 29/09/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import Parse

class UserTableViewController: UITableViewController {
    
    ////usernames array
    var usernames = [""]
    ////object ids array
    var objectIds = [""]
    
    
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
        
        ////Add a constraint to the query that requires a particular key's object to be not equal to the provided object
        query?.whereKey("username", notEqualTo: PFUser.current()?.username)
        
        ////Finds objects *asynchronously* and calls the given block with the results
        query?.findObjectsInBackground(block: { (users, error) in
            
            if error != nil {
                
                print(error!)
                
            } else if let users = users {
                
                ////remove first object in usernames array
                self.usernames.removeAll()
                ////remove first object in object ids
                self.objectIds.removeAll()
                
                for object in users {
                    
                    ////Cast object as PFUser
                    if let user = object as? PFUser {
                        
                        ////retrieve username data
                        if let username = user.username {
                            
                            ////retrieve objectId
                            if let objectId = user.objectId {
                            
                            ////use components method to separate user email address to just display wording before the @
                            var usernameArray = username.components(separatedBy: "@")
                            
                            ////append usernames data to usernames array
                            self.usernames.append(usernameArray[0])
                            ////append objectIds data to objectId array
                            self.objectIds.append(objectId)
                        
                            }
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
    
    
    
    //MARK: - did select row at index path section
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
        
        ////follow users method
        let followingRelation = PFObject(className: "FollowingRelation")
        
        followingRelation["Follower"]  = PFUser.current()?.objectId
        followingRelation["Following"] = objectIds[indexPath.row]
        
        followingRelation.saveInBackground()
        
    }

}
