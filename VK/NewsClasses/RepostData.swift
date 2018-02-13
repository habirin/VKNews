//
//  RepostData.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 21.11.2017.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import Foundation


class RepostData {
    
    let author: AuthorInfo
    var attachments: [Attachments]?
    let text: String
    let date: String
    init (repost: JSON, author: JSON) {
        
        self.author = AuthorInfo.init(author: author)
        self.text = repost["text"].stringValue
        self.date = repost["date"].stringValue
        for attach in repost["attachments"].arrayValue {
            self.attachments?.append(Attachments.getAttchment(attach: attach))
        }
    }
}
