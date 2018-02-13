//
//  VideoAttachments.swift
//  VK
//
//  Created by Ринат Хабибуллин on 24.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import Foundation
import SwiftyJSON

class VideoAttachments {
    let photo130: String
    let photo320: String
    let photo640: String
    let title: String
    let date: String
    init (videoAttach: JSON) {
        
        self.photo130 = videoAttach["photo_130"].stringValue
        self.photo640 = videoAttach["photo_640"].stringValue
        self.photo320 = videoAttach["photo_320"].stringValue
        self.title = videoAttach["title"].stringValue
        self.date = videoAttach["date"].stringValue
    }
    init (coreDataVideoAttch: VideoAttachmentsCD) {
        self.photo130 = coreDataVideoAttch.photo130!
        self.photo640 = coreDataVideoAttch.photo640!
        self.photo320 = coreDataVideoAttch.photo320!
        self.title = coreDataVideoAttch.title!
        self.date = coreDataVideoAttch.date!
    }
}

