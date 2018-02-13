//
//  PostAuthorInfoTableViewCell.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 17.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import UIKit

class PostAuthorInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var postAuthorName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
