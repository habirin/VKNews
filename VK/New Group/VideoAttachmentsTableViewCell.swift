//
//  VideoTableViewCell.swift
//  VK
//
//  Created by Ринат Хабибуллин on 24.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import UIKit
import FSPagerView
class VideoAttachmentsTableViewCell: UITableViewCell, FSPagerViewDataSource, FSPagerViewDelegate {
    
    var videoAttachments: [VideoAttachments]!
    
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
            self.pagerView.transformer = FSPagerViewTransformer(type: .coverFlow)
            self.pagerView.isInfinite = false
            
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            
        }
        
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        self.pageControl.numberOfPages = self.videoAttachments.count - 1
        return self.videoAttachments.count
    }
    
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if self.videoAttachments[index].photo320 != nil {
            cell.imageView?.image = UIImage.getImageFromString(stringUrl: self.videoAttachments[index].photo320)
            
        }
        else {
            cell.imageView?.image = UIImage.getImageFromString(stringUrl: self.videoAttachments[index].photo130)
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
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

