//
//  PostAndRepostData.swift
//  VK
//
//  Created by Ринат Хабибуллин on 25.01.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import Foundation
import SwiftyJSON
extension String {
    func dateConverter() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(Int(self)!))
        
        let dateFormater = DateFormatter()
        
        dateFormater.dateFormat = "dd MMMM, hh:mm"
        
        let dataAfterFormat = dateFormater.string(from: date as! Date)
        
        return dateFormater.string(from: date as! Date)
    }
}


class PostAndRepostData {
    let authorName: String
    let authorScreenName: String
    let authorPhoto50: String
    let authorPhoto100: String
    
    
    let likesCount: String
    let repostsCount: String
    let commentsCount: String
    let date: String
    let text: String
    var photoAttachments: [PhotoAttachments]!
    var videoAttachments: [VideoAttachments]!
    var audioAttachments: [AudioAttachments]!
    
    var favoriteNews: Bool
    init(post: JSON, author: JSON) {
        self.favoriteNews = false
        
        switch author {
        case _ where author["last_name"] != nil:
            self.authorName = author["last_name"].stringValue + " " + author["first_name"].stringValue
            
        default: self.authorName = author["name"].stringValue
            
        }
        
        self.authorScreenName = author["screen_name"].stringValue
        self.authorPhoto50 = author["photo_50"].stringValue
        self.authorPhoto100 = author["photo_100"].stringValue
        
        self.date = post["date"].stringValue.dateConverter()
        self.likesCount = post["likes"]["count"].stringValue
        self.commentsCount = post["comments"]["count"].stringValue
        self.repostsCount = post["reposts"]["count"].stringValue
        self.text = post["text"].stringValue
        
        
        for attach in post["attachments"].arrayValue {
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
                
            case "audio":
                if self.audioAttachments == nil {
                    self.audioAttachments = []
                }
                let audioAttach = AudioAttachments.init(audioAttach: attach["audio"])
                self.audioAttachments.append(audioAttach)
            default: break
            }
            
            
        }
    }
    init(dataFromCoreData: DataCD) {
        self.favoriteNews = true
        self.authorName = (dataFromCoreData.authorName)!
        self.authorPhoto50 = (dataFromCoreData.authorPhoto50)!
        self.authorPhoto100 = (dataFromCoreData.authorPhoto100)!
        self.authorScreenName = (dataFromCoreData.authorScreenName)!
        self.commentsCount = (dataFromCoreData.commentsCount)!
        self.date = (dataFromCoreData.date)!
        self.likesCount = (dataFromCoreData.likesCount)!
        self.repostsCount = (dataFromCoreData.repostsCount)!
        self.text = (dataFromCoreData.text)!
        if dataFromCoreData.photoAttachmentsCD != nil {
            for photoCD in dataFromCoreData.photoAttachmentsCD! {
                if self.photoAttachments == nil {
                    self.photoAttachments = []
                }
                let photo = photoCD as! PhotoAttachmentsCD
                print(photo.photo130)
                self.photoAttachments.append(PhotoAttachments.init(coreDataPhotoAttach: photoCD as! PhotoAttachmentsCD))
            }
        }
        if dataFromCoreData.videoAttachmentsCD != nil {
            
            for videoCD in dataFromCoreData.videoAttachmentsCD!  {
                if self.videoAttachments == nil {
                    self.videoAttachments = []
                }
                self.videoAttachments.append(VideoAttachments.init(coreDataVideoAttch: videoCD as! VideoAttachmentsCD))
            }
        }
        if dataFromCoreData.audioAttachmentsCD != nil {
            for audioCD in dataFromCoreData.audioAttachmentsCD!  {
                if self.audioAttachments == nil {
                    self.audioAttachments = []
                }
                self.audioAttachments.append(AudioAttachments.init(coreDataAudioAttch: audioCD as! AudioAttachmentsCD))
            }
        }
        
    }
}
