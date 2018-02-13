//
//  PostAuthorInfoTableViewCell.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 17.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import UIKit
import CoreData
protocol PostAuthorInfoTableViewCellDelegate: class {
    func strarButtonPressed(postAuthorInfoTableViewCell: PostAuthorInfoTableViewCell, newsForSaveInCoreData: News)
    
    func strarButtonUnPressed(indexInFavoriteNews: Int)
    
}
class PostAuthorInfoTableViewCell: UITableViewCell {
    var newsForSaveInCoreData: News!
    var indexInFavoriteNews: Int!
    
    weak var delegate: PostAuthorInfoTableViewCellDelegate?
    @IBOutlet weak var starButton: UIButton!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBAction func starButton(_ sender: Any) {
        
        CoreDataManager.myCoreDataManager.saveNews(newsForSaveInCoreData: newsForSaveInCoreData)
        if newsForSaveInCoreData.favoriteNews == false {
            self.delegate?.strarButtonPressed(postAuthorInfoTableViewCell: self, newsForSaveInCoreData: newsForSaveInCoreData)
        }
        else {
            self.delegate?.strarButtonUnPressed(indexInFavoriteNews: indexInFavoriteNews)
        }
    }
    
    
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
