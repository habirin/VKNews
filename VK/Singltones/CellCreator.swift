//
//  CellCreator.swift
//  VK
//
//  Created by Ринат Хабибуллин on 19.02.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import Foundation
import UIKit

class CellCreator  {
    
     var oneNews: News!
   
    static var myCellCreator: CellCreator!
   
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        
        switch self.oneNews.dataContent[indexPath.row] {
            
        case .postAuthorInfoTableViewCell:
            let postAuthorInfoTableViewCellNib = UINib(nibName: "PostAuthorInfoTableViewCell", bundle: nil)
            tableView.register(postAuthorInfoTableViewCellNib, forCellReuseIdentifier: "PostAuthorInfoTableViewCell")
            
            let postAuthorInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostAuthorInfoTableViewCell", for: indexPath) as! PostAuthorInfoTableViewCell
            
            postAuthorInfoTableViewCell.avatarImage.image = UIImage.getImageFromString(stringUrl: oneNews.authorPhoto100)
            postAuthorInfoTableViewCell.postAuthorName.text = oneNews.authorName
            postAuthorInfoTableViewCell.date.text = oneNews.date
            postAuthorInfoTableViewCell.newsForSaveInCoreData = oneNews
            
            if oneNews.favoriteNews == false {
                postAuthorInfoTableViewCell.starButton.backgroundColor = UIColor.green
            }
            else {
                postAuthorInfoTableViewCell.starButton.backgroundColor = UIColor.red
            }
            return postAuthorInfoTableViewCell
            
        case let textInfo where textInfo == DataContent.postTextTableViewCell || textInfo == DataContent.repostTextTableViewCell:
            let textTableViewCellNib = UINib(nibName: "TextTableViewCell", bundle: nil)
            tableView.register(textTableViewCellNib, forCellReuseIdentifier: "TextTableViewCell")
            
            let textTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as! TextTableViewCell
            //textTableViewCell.delegate = tableView as! UpdateTextTableViewCellHeightDelegate
            if textInfo == DataContent.postTextTableViewCell {
                textTableViewCell.textInfo.text = oneNews.text
            }
            else {
                textTableViewCell.textInfo.text = oneNews.repostData?.text
            }
            textTableViewCell.indexPath = indexPath
            
            textTableViewCell.textInfo.numberOfLines = 5
            if textTableViewCell.textInfo.isTruncated == true {
                textTableViewCell.readAllButton.isHidden = false
            }
            else {
                textTableViewCell.readAllButton.isHidden = true
                
            }
            return textTableViewCell
            
        case let photoAttachments where photoAttachments == DataContent.postPhotoAttachmentsTableViewCell || photoAttachments == DataContent.repostPhotoAttachmentsTableViewCell:
            
            
            let photoAttachmentsTableViewCellNib = UINib(nibName: "PhotoAttachmentsTableViewCell", bundle: nil)
            tableView.register(photoAttachmentsTableViewCellNib, forCellReuseIdentifier: "PhotoAttachmentsTableViewCell")
            
            let photoAttachmentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PhotoAttachmentsTableViewCell", for: indexPath) as! PhotoAttachmentsTableViewCell
            if photoAttachments == DataContent.postPhotoAttachmentsTableViewCell {
                photoAttachmentsTableViewCell.photoAttachments = oneNews.photoAttachments
            }
            if photoAttachments == DataContent.repostPhotoAttachmentsTableViewCell {
                photoAttachmentsTableViewCell.photoAttachments = oneNews.repostData?.photoAttachments
            }
            photoAttachmentsTableViewCell.pagerView.reloadData()
            //photoAttachmentsTableViewCell.delegate = tableView as! PhotoAttachmentsTableViewCellDelegate
            
            return photoAttachmentsTableViewCell
            
            
            
            
        case let videoAttachments where videoAttachments == DataContent.postVideoAttachmentsTableViewCell || videoAttachments == DataContent.repostVideoAttachmentsTableViewCell:
            
            let videoAttachmentsTableViewCellNib = UINib(nibName: "VideoAttachmentsTableViewCell", bundle: nil)
            tableView.register(videoAttachmentsTableViewCellNib, forCellReuseIdentifier: "VideoAttachmentsTableViewCell")
            
            
            let videoAttachmentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideoAttachmentsTableViewCell", for: indexPath) as! VideoAttachmentsTableViewCell
            if videoAttachments == DataContent.postVideoAttachmentsTableViewCell {
                videoAttachmentsTableViewCell.videoAttachments = oneNews.videoAttachments
            }
            else {
                videoAttachmentsTableViewCell.videoAttachments = oneNews.repostData?.videoAttachments
            }
            
            videoAttachmentsTableViewCell.pagerView.reloadData()
            return videoAttachmentsTableViewCell
            
            
        case let audioAttachments where audioAttachments == DataContent.postAudioAttachmentsTableViewCell || audioAttachments == DataContent.repostAudioAttachmentsTableViewCell :
            
            let audioAttachmentsTableViewCellNib = UINib(nibName: "AudioAttachmentsTableViewCell", bundle: nil)
            tableView.register(audioAttachmentsTableViewCellNib, forCellReuseIdentifier: "AudioAttachmentsTableViewCell")
            
            let audioAttachmentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AudioAttachmentsTableViewCell", for: indexPath) as! AudioAttachmentsTableViewCell
            if audioAttachments == DataContent.postAudioAttachmentsTableViewCell {
                audioAttachmentsTableViewCell.audioAttachments = oneNews.audioAttachments
            }
            else {
                audioAttachmentsTableViewCell.audioAttachments = oneNews.repostData?.audioAttachments
            }
            audioAttachmentsTableViewCell.heightConstraint.constant = audioAttachmentsTableViewCell.tableView.contentSize.height
            audioAttachmentsTableViewCell.tableView.updateConstraints()
            
            DispatchQueue.main.async {
                audioAttachmentsTableViewCell.tableView.reloadData()
                audioAttachmentsTableViewCell.layoutIfNeeded()
            }
            return audioAttachmentsTableViewCell
            
        case . repostAuthorInfoTableViewCell:
            let repostAuthorInfoTableViewCellNib = UINib(nibName: "RepostAuthorInfoTableViewCell", bundle: nil)
            tableView.register(repostAuthorInfoTableViewCellNib, forCellReuseIdentifier: "RepostAuthorInfoTableViewCell")
            
            let repostAuthorInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RepostAuthorInfoTableViewCell", for: indexPath) as! RepostAuthorInfoTableViewCell
            
            
            repostAuthorInfoTableViewCell.avatarImage.image = UIImage.getImageFromString(stringUrl: (oneNews.repostData?.authorPhoto100)!)
            
            repostAuthorInfoTableViewCell.authorName.text = oneNews.repostData?.authorName
            return repostAuthorInfoTableViewCell
            
        case . postFooterCell:
            let postFooterTableViewCellNib = UINib(nibName: "FooterTableViewCell", bundle: nil)
            
            tableView.register(postFooterTableViewCellNib, forCellReuseIdentifier: "FooterTableViewCell")
            
            let postFooterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FooterTableViewCell", for: indexPath) as! FooterTableViewCell
            postFooterTableViewCell.likes.text = "❤️ \(oneNews.likesCount)"
            postFooterTableViewCell.comments.text = "📝 \(oneNews.commentsCount)"
            postFooterTableViewCell.reposts.text = "📎 \(oneNews.repostsCount)"
            return postFooterTableViewCell
            
        default:
            
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    init() {
        CellCreator.myCellCreator = self
    }
}
