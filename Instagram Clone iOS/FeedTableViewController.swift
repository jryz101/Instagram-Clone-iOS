//  FeedTableViewController.swift
//  Instagram Clone iOS
//  Created by Jerry Tan on 09/10/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit

class FeedTableViewController: UITableViewController {
    
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        
        //// resize table view row height
        self.tableView.rowHeight = 300
        
        // Configure the cell...
        cell.postedImage.image = UIImage(named: "Demo Image.png")
        cell.comment.text = "Comment"
        cell.userInfo.text = "Username"

        return cell
    }
}
