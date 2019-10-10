//  FeedTableViewCell.swift
//  Instagram Clone iOS
//  Created by Jerry Tan on 09/10/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit

class FeedTableViewCell: UITableViewCell {
    
    //MARK: - outlets objects
    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var userInfo: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
