//
//  News.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 15.11.2017.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import Foundation
import SwiftyJSON

enum DataContent {
    case postAuthorInfoTableViewCell
    case postTextTableViewCell
    case postPhotoAttachmentsTableViewCell
    case postVideoAttachmentsTableViewCell
    case postAudioAttachmentsTableViewCell
    case repostAuthorInfoTableViewCell
    case repostTextTableViewCell
    case repostPhotoAttachmentsTableViewCell
    case repostVideoAttachmentsTableViewCell
    case repostAudioAttachmentsTableViewCell
    case postFooterCell
}
class News: PostAndRepostData {
    
    
    var dataContent: [DataContent]  {
        var content = [DataContent]()
        content.append(DataContent.postAuthorInfoTableViewCell)
        if self.text != "" {
            content.append(DataContent.postTextTableViewCell)
        }
        if self.photoAttachments != nil {
            content.append(DataContent.postPhotoAttachmentsTableViewCell)
        }
        if self.videoAttachments != nil {
            content.append(DataContent.postVideoAttachmentsTableViewCell)
        }
        if self.audioAttachments != nil {
            content.append(DataContent.postAudioAttachmentsTableViewCell)
        }
        if let repostData = self.repostData {
            content.append(DataContent.repostAuthorInfoTableViewCell)
            
            if repostData.text != "" {
                content.append(DataContent.repostTextTableViewCell)
            }
            if repostData.photoAttachments != nil {
                content.append(DataContent.repostPhotoAttachmentsTableViewCell)
            }
            if repostData.videoAttachments != nil {
                content.append(DataContent.repostVideoAttachmentsTableViewCell)
            }
            if repostData.audioAttachments != nil {
                content.append(DataContent.repostAudioAttachmentsTableViewCell)
            }
        }
        content.append(DataContent.postFooterCell)
        return content
    }
    
    var repostData: PostAndRepostData?
    
    init(post: JSON, authorsDictionary: [Int : JSON]) {
        
        
        let postAuthor = authorsDictionary[abs(post["source_id"].intValue)]!
        super.init(post: post, author: postAuthor)
        
        if post["copy_history"][0] != nil {
            let repostAuthorId = abs(post["copy_history"][0]["owner_id"].intValue)
            let repostAuthor = authorsDictionary[repostAuthorId]!
            let repostContent = post["copy_history"][0]
            self.repostData = PostAndRepostData.init(post: repostContent, author: repostAuthor)
            
        }
        
    }
    init(coreDataNews: NewsCD) {
        super.init(dataFromCoreData: (coreDataNews.postDataCD?.dataCD)!)
        
        if coreDataNews.repostDataCD != nil {
            self.repostData = PostAndRepostData.init(dataFromCoreData: coreDataNews.repostDataCD!.dataCD!)
        }
    }
    
    
}

