//
//  PostPhotoAttachmentsTableViewCell.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 17.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import UIKit
import FSPagerView


protocol PhotoAttachmentsTableViewCellDelegate: class {
    func performSegue(photoAttachments: [PhotoAttachments], selectedImage: Int)
}
class PhotoAttachmentsTableViewCell: UITableViewCell, FSPagerViewDataSource, FSPagerViewDelegate {
    
    var photoAttachments: [PhotoAttachments]!
    
    weak var delegate: PhotoAttachmentsTableViewCellDelegate?
    
    @IBOutlet weak var height: NSLayoutConstraint!
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
        }
    }
    
    @IBOutlet weak var pagerView: FSPagerView! {
        
        didSet {
            self.pagerView.dataSource = self
            self.pagerView.delegate = self
            self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
            self.pagerView.isInfinite = false
            self.pagerView.interitemSpacing = 10
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            
        }
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        self.pageControl.numberOfPages = self.photoAttachments.count - 1
        return self.photoAttachments.count
    }
    
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if self.photoAttachments[index].photo604 != nil {
            cell.imageView?.image = UIImage.getImageFromString(stringUrl: self.photoAttachments[index].photo604)
        }
        else {
            cell.imageView?.image = UIImage.getImageFromString(stringUrl: self.photoAttachments[index].photo130)
        }
        self.pageControl.currentPage = index
        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        cell.textLabel?.isHidden = true
        
        return cell
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pagerView.itemSize = CGSize(width: self.height.constant, height: self.height.constant)
        
        
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        self.delegate?.performSegue(photoAttachments: self.photoAttachments, selectedImage: index)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
