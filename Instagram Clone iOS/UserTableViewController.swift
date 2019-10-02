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
    ////is following dictionary with boolean data type
    var isFollowing = ["" : false]
    
    
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
        query?.whereKey("username", notEqualTo: PFUser.current()?.username as Any)
        
        ////Finds objects *asynchronously* and calls the given block with the results
        query?.findObjectsInBackground(block: { (users, error) in
            
            if error != nil {
                
                print(error!)
                
            } else if let users = users {
                
                ////remove first object in usernames array
                self.usernames.removeAll()
                ////remove first object in objectIds
                self.objectIds.removeAll()
                ////remove first object in isFollowing dictionary
                self.isFollowing.removeAll()
                
                
                
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
                                
                                
                                
                                
                                ////methods for checking is following users
                                let query = PFQuery(className: "FollowingRelation")
                                
                                query.whereKey("Follower", equalTo: PFUser.current()?.objectId as Any)
                                query.whereKey("Following",equalTo: objectId)
                                
                                query.findObjectsInBackground(block: { (objects, error) in
                                    
                                    if let objects = objects {
                                        
                                        if objects.count > 0 {
                                            
                                            self.isFollowing[objectId] = true
                                            
                                        } else {
                                            
                                            self.isFollowing[objectId] = false
                                            
                                        }
                                        
                                        self.tableView.reloadData()
                                    }
                                })
                            }
                        }
                    }
                }
            }
        })
    }
    
    
    

    // MARK: - table view data source section
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        //#warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //#warning Incomplete implementation, return the number of rows
        ////return usernames in each row section
        return usernames.count
    }
    
    //MARK: - cell for row at index path section
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = usernames[indexPath.row]
        
        
        ////Update is following value and set to display checkmark
        if let followsBoolean = isFollowing[objectIds[indexPath.row]] {
            
            
            if followsBoolean {
                
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            }
        }
        
        return cell
    }
    
    
    
    
    
    
    
    //MARK: - did select row at index path section
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        
        ////unfollow methods, set display checkmark to none and remove data from parse server
        if let followsBoolean = isFollowing[objectIds[indexPath.row]] {
            
            
            if followsBoolean {
                
                isFollowing[objectIds[indexPath.row]] = false
                
                cell?.accessoryType = UITableViewCell.AccessoryType.none
                
                let query = PFQuery(className: "FollowingRelation")
                
                query.whereKey("Follower", equalTo: PFUser.current()?.objectId as Any)
                query.whereKey("Following",equalTo: objectIds[indexPath.row])
                
                query.findObjectsInBackground(block: { (objects, error) in
                    
                    if let objects = objects {
                        
                        for objects in objects {
                            
                            objects.deleteInBackground()
                        }
                    }
                    
                })
            
            } else {
                
                isFollowing[objectIds[indexPath.row]] = true
                
                cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
                
                
                let followingRelation = PFObject(className: "FollowingRelation")
                
                followingRelation["Follower"]  = PFUser.current()?.objectId
                followingRelation["Following"] = objectIds[indexPath.row]
                
                followingRelation.saveInBackground()
                
            }
        }
    }
}
