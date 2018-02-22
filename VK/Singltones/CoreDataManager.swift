//
//  CoreDataManager.swift
//  VK
//
//  Created by Ринат Хабибуллин on 12.02.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static var myCoreDataManager: CoreDataManager!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveNews(newsForSaveInCoreData: News) {
        var newsCD = [NewsCD]()
        
        func getData(dataCD: DataCD, data: PostAndRepostData) -> DataCD {
            
            
            dataCD.authorName = data.authorName
            dataCD.authorPhoto50 = data.authorPhoto50
            dataCD.authorPhoto100 = data.authorPhoto100
            dataCD.authorScreenName = data.authorScreenName
            dataCD.commentsCount = data.commentsCount
            dataCD.date = data.date
            dataCD.likesCount = data.likesCount
            dataCD.repostsCount = data.repostsCount
            dataCD.text = data.text
            
            return dataCD
        }
        func getPhotoData(photoAttachmentsCD: PhotoAttachmentsCD, photoAttachments: PhotoAttachments) -> PhotoAttachmentsCD {
            
            
            photoAttachmentsCD.photo130 = photoAttachments.photo130
            photoAttachmentsCD.photo604 = photoAttachments.photo604
            photoAttachmentsCD.text = photoAttachments.text
            
            return photoAttachmentsCD
            
        }
        func getVideoData(videoAttachmentsCD: VideoAttachmentsCD, videoAttachments: VideoAttachments) -> VideoAttachmentsCD {
            videoAttachmentsCD.photo130 = videoAttachments.photo130
            videoAttachmentsCD.photo320 = videoAttachments.photo320
            videoAttachmentsCD.photo640 = videoAttachments.photo640
            videoAttachmentsCD.date = videoAttachments.date
            videoAttachmentsCD.title = videoAttachments.title
            return videoAttachmentsCD
        }
        func getAudioData(audioAttachmentsCD: AudioAttachmentsCD, audioAttachments: AudioAttachments) -> AudioAttachmentsCD {
            audioAttachmentsCD.url = audioAttachments.url
            audioAttachmentsCD.title = audioAttachments.title
            audioAttachmentsCD.artist = audioAttachments.artist
            
            return audioAttachmentsCD
        }
        let news = NewsCD(entity: NewsCD.entity(), insertInto: context)
        news.favoriteNews = true
        news.postDataCD = PostDataCD(entity: PostDataCD.entity(), insertInto: context)
        news.postDataCD?.dataCD = DataCD(entity: DataCD.entity(), insertInto: context)
        
        news.postDataCD?.dataCD = getData(dataCD: (news.postDataCD?.dataCD)!, data: newsForSaveInCoreData)
        
        
        if newsForSaveInCoreData.photoAttachments != nil {
            
            for photo in newsForSaveInCoreData.photoAttachments {
                var photoEntity = PhotoAttachmentsCD(entity: PhotoAttachmentsCD.entity(), insertInto: context)
                photoEntity = getPhotoData(photoAttachmentsCD: photoEntity, photoAttachments: photo)
                photoEntity.dataCD = news.postDataCD?.dataCD
                
            }
            print(news.postDataCD?.dataCD?.photoAttachmentsCD?.count)
        }
        if newsForSaveInCoreData.videoAttachments != nil {
            for video in newsForSaveInCoreData.videoAttachments {
                var videoEntity = VideoAttachmentsCD(entity: VideoAttachmentsCD.entity(), insertInto: context)
                videoEntity = getVideoData(videoAttachmentsCD: videoEntity, videoAttachments: video)
                videoEntity.dataCD = news.postDataCD?.dataCD
            }
            
        }
        if newsForSaveInCoreData.audioAttachments != nil {
            for audio in newsForSaveInCoreData.audioAttachments {
                var audioEntity = AudioAttachmentsCD(entity: AudioAttachmentsCD.entity(), insertInto: context)
                audioEntity = getAudioData(audioAttachmentsCD: audioEntity, audioAttachments: audio)
                audioEntity.dataCD = news.postDataCD?.dataCD
            }
        }
        
        
        if newsForSaveInCoreData.repostData != nil {
            news.repostDataCD = RepostDataCD(entity: RepostDataCD.entity(), insertInto: context)
            news.repostDataCD?.dataCD = DataCD(entity: DataCD.entity(), insertInto: context)
            news.repostDataCD?.dataCD = getData(dataCD: (news.repostDataCD?.dataCD)!, data: newsForSaveInCoreData.repostData!)
            
            
            
            if newsForSaveInCoreData.repostData?.photoAttachments != nil {
                for photo in (newsForSaveInCoreData.repostData?.photoAttachments)! {
                    var photoEntity = PhotoAttachmentsCD(entity: PhotoAttachmentsCD.entity(), insertInto: context)
                    photoEntity = getPhotoData(photoAttachmentsCD: photoEntity, photoAttachments: photo)
                    photoEntity.dataCD?.repostDataCD?.newsCD = news
                    print(photoEntity.photo130)
                }
            }
            if newsForSaveInCoreData.repostData?.videoAttachments != nil {
                for video in (newsForSaveInCoreData.repostData?.videoAttachments)! {
                    var videoEntity = VideoAttachmentsCD(entity: VideoAttachmentsCD.entity(), insertInto: context)
                    videoEntity = getVideoData(videoAttachmentsCD: videoEntity, videoAttachments: video)
                    videoEntity.dataCD?.repostDataCD?.newsCD = news
                }
            }
            if newsForSaveInCoreData.repostData?.audioAttachments != nil {
                for audio in (newsForSaveInCoreData.repostData?.audioAttachments)! {
                    var audioEntity = AudioAttachmentsCD(entity: AudioAttachmentsCD.entity(), insertInto: context)
                    audioEntity = getAudioData(audioAttachmentsCD: audioEntity, audioAttachments: audio)
                    audioEntity.dataCD?.repostDataCD?.newsCD = news
                }
            }
            
        }
        do {
            try context.save()
            newsCD.append(news)
        } catch {
            
        }
        
    }
    func deleteNewsFromCoreData(index: Int) {
        
        do {
            let result = try context.fetch(NewsCD.fetchRequest())
            let newsCD = result as! [NewsCD]
           
            context.delete(newsCD[index])
            
            try context.save()
            
        }
        catch {
            
        }
        
        
    }
    func convertingFromCoreDataToNewsClass() -> [News] {
        var favoritesArray:[News] = []
        
        do {
            let result = try context.fetch(NewsCD.fetchRequest())
            let newsCD = result as! [NewsCD]
            
            for oneNewCD in newsCD {
                let new = News.init(coreDataNews: oneNewCD)
                favoritesArray.append(new)
            }
            
            
        }
        catch {
            
        }
        return favoritesArray
    }
    
    init() {
        CoreDataManager.myCoreDataManager = self
    }
    
}
