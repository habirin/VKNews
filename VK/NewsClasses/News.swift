//
//  News.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 15.11.2017.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import Foundation


class News {

    let postAuthorInfo: AuthorInfo
    
    let likesCount: String
    let repostsCount: String
    let date: String
    
    var repostData: RepostData?
    var attachments: [Attachments]? = [Attachments]()
    var photoAttachments: [PhotoAttachments]!
    
    init(post: JSON, authorsDictionary: [Int : JSON]) {
        
        self.postAuthorInfo = AuthorInfo.init(author: authorsDictionary[abs(post["source_id"].intValue)]!)
        self.date = post["date"].stringValue
        self.likesCount = post["likes"]["count"].stringValue
        self.repostsCount = post["reposts"]["count"].stringValue
        
        if post["copy_history"][0] != nil {
            let repostAuthor = authorsDictionary[abs(post["copy_history"][0]["owner_id"].intValue)]
            self.repostData = RepostData.init(repost: post["copy_history"][0] , author: repostAuthor!)
           
        }
        
        for attach in post["attachments"].arrayValue {
            switch attach["type"].stringValue {
            case "photo":
                if self.photoAttachments == nil {
                    self.photoAttachments = []
                }
                
                let photoAttach = PhotoAttachments.init(photoAttach: attach["photo"])
                self.photoAttachments.append(photoAttach)
               
            
            default: break
            }
           
        
    }
    
}
}


