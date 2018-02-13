//
//  Attachments.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 21.11.2017.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import Foundation


class Attachments {
    static func getAttchment(attach: JSON) -> Attachments {
        
        switch attach {
        case _ where attach["photo"] != nil:
            let photoAttach = Attachments.Photo.init(photoAttach: attach["photo"])
            print("photo")
            return photoAttach
        case _ where attach["video"] != nil:
            let videoAttach = Attachments.Video.init(videoAttach: attach["video"])
            return videoAttach
        case _ where attach["audio"] != nil:
            let audioAttach = Attachments.Audio.init(audioAttach: attach["audio"])
            return audioAttach
        default: return Attachments()
        }
        
    }
 
    class Audio: Attachments {
        let title: String
        let artist: String
        let url: String
        init(audioAttach: JSON) {
            self.artist = audioAttach["artist"].stringValue
            self.title = audioAttach["title"].stringValue
            self.url = audioAttach["url"].stringValue
            
        }
    }
    class Photo: Attachments {
        let photo804: String
        let photo130: String
        let text: String
        init (photoAttach: JSON) {
            self.photo130 = photoAttach["photo_130"].stringValue
            self.photo804 = photoAttach["photo_804"].stringValue
            self.text = photoAttach["text"].stringValue
        }
    }
    class Video: Attachments {
        let photo130: String
        let photo320: String
        let photo800: String
        let title: String
        let date: String
        init (videoAttach: JSON) {
            self.photo130 = videoAttach["photo_130"].stringValue
            self.photo800 = videoAttach["first_frame_800"].stringValue
            self.photo320 = videoAttach["photo320"].stringValue
            self.title = videoAttach["title"].stringValue
            self.date = videoAttach["date"].stringValue
        }
    }
    
}
