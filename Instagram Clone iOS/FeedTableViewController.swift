//  FeedTableViewController.swift
//  Instagram Clone iOS
//  Created by Jerry Tan on 09/10/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import Parse

class FeedTableViewController: UITableViewController {
    
    //MARK: - variable section
    var users = [String: String]()
    var comments = [String]()
    var usernames = [String]()
    var imageFiles = [PFFileObject]()
    
    
    
    
    
    
    //MARK: - view did load section
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////create a query which returns objects of this type
        let query = PFUser.query()
        
        ////add a constraint to the query that requires a particular key's object to be not equal to the provided object
        query?.whereKey("username", notEqualTo: PFUser.current()?.username as Any)
        
        ////finds objects *asynchronously* and calls the given block with the results
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects {
                
                for object in users {
                    
                    ////casting PFObject to PFUser
                    if let user = object as? PFUser {
                        
                        ////update user array and store username with objectId on user dictionary
                        self.users[user.objectId!] = user.username!
                        
                    }
                    
                }
                
            }
            ////getFollowerUserQuery for searching all the user that our current user follows
            let getFollowerUserQuery = PFQuery(className: "FollowingRelation")
            
            ////get the current user Follower objectId
            getFollowerUserQuery.whereKey("Follower", equalTo: PFUser.current()?.objectId as Any)
            
            ///finds objects *asynchronously* and calls the given block with the results.
            getFollowerUserQuery.findObjectsInBackground(block: { (objects, error) in
                
                if let followers = objects {
                    
                    for follower in followers {
                        
                        if let followedUser = follower["Following"] {
                            
                            ////the 'PFQuery' class defines a query that is used to query for `PFObject`s.
                            let query = PFQuery(className: "Post")
                            
                            ////add a constraint to the query that requires a particular key's object to be equal to the provided object.
                            query.whereKey("userid", equalTo: followedUser)
                            
                            query.findObjectsInBackground(block: { (objects, error) in
                                
                                if let posts = objects {
                                    
                                    for post in posts {
                                    
                                        ////append comments, usernames, and imagefile values to Parse server data table
                                        self.comments.append(post["message"] as! String)
                                        self.usernames.append(self.users[post["userid"] as! String]!)
                                        self.imageFiles.append(post["imageFile"] as! PFFileObject)
                                        
                                        
                                        self.tableView.reloadData()
                                        
                                    }
                                }
                            })
                        }
                    }
                }
            })
        })
    }
    
    
    
    
    

    // MARK: - Table view data source section
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        
        //// resize table view row height
        self.tableView.rowHeight = 300
        
        // Configure the cell...
        ////asynchronously* gets the data from cache if available or fetches its contents from the network.
        imageFiles[indexPath.row].getDataInBackground { (data, error) in
            
            if let imageData = data {
                
                if let imageToDisplay = UIImage(data: imageData) {
                    
                    cell.postedImage.image = imageToDisplay
                    
                }
            }
        }
        
        cell.comment.text = comments[indexPath.row]
        
        cell.userInfo.text = usernames[indexPath.row]

        return cell
    }
}
