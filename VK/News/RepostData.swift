//
//  RepostData.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 21.11.2017.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import Foundation
import SwiftyJSON

class RepostData {
    
    let author: AuthorInfo
    
    let text: String
    let date: String
    var photoAttachments: [PhotoAttachments]!
    var videoAttachments: [VideoAttachments]!
    init (repost: JSON, author: JSON) {
        
        self.author = AuthorInfo.init(author: author)
        self.text = repost["text"].stringValue
        self.date = repost["date"].stringValue
        
        for attach in repost["attachments"].arrayValue {
            switch attach["type"].stringValue {
            case "photo":
                if self.photoAttachments == nil {
                    self.photoAttachments = []
                }
                
                let photoAttach = PhotoAttachments.init(photoAttach: attach["photo"])
                self.photoAttachments.append(photoAttach)
                
            case "video":
                if self.videoAttachments == nil {
                    self.videoAttachments = []
                }
                
                let videoAttach = VideoAttachments.init(videoAttach: attach["video"])
                self.videoAttachments.append(videoAttach)
                
            default: break
            }
            
            
        }
    }
}
