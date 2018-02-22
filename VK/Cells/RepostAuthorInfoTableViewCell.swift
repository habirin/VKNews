//
//  RepostAuthorInfoTableViewCell.swift
//  VK
//
//  Created by Ринат Хабибуллин on 24.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import UIKit

class RepostAuthorInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    var sectionIndex: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
