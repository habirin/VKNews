//
//  AudioAttachments.swift
//  VK
//
//  Created by Ринат Хабибуллин on 25.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import Foundation
import SwiftyJSON

class AudioAttachments {
    let title: String
    let artist: String
    let url: String
    init(audioAttach: JSON) {
        self.artist = audioAttach["artist"].stringValue
        self.title = audioAttach["title"].stringValue
        self.url = audioAttach["url"].stringValue
        
    }
    init (coreDataAudioAttch: AudioAttachmentsCD) {
        self.artist = coreDataAudioAttch.artist!
        self.title = coreDataAudioAttch.title!
        self.url = coreDataAudioAttch.url!
    }
}
