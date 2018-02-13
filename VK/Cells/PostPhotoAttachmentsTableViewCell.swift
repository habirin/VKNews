//
//  PostPhotoAttachmentsTableViewCell.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 17.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import UIKit

class PostPhotoAttachmentsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var sectionIndex: Int = 0
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return newsArray[self.sectionIndex].photoAttachments.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCollectionViewCellNib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        print(self.sectionIndex)
        print(newsArray[self.sectionIndex].photoAttachments[indexPath.row].photo130)
        print("Hello")
        collectionView.register(photoCollectionViewCellNib, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        let photoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        let url = URL(string: newsArray[sectionIndex].photoAttachments[indexPath.row].photo130)
       let data = try? Data(contentsOf: url!)
       photoCollectionViewCell.photo.image = UIImage(data: data!)
      
        return photoCollectionViewCell
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       
        collectionView.dataSource = self
        collectionView.delegate = self
      
        // Initialization code
    }
   
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
