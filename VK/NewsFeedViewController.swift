//
//  NewsFeedViewController.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 15.11.2017.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

extension UIImage {
    
    static func getImageFromString(stringUrl: String) -> UIImage {
        
        if let url = URL(string: stringUrl) {
            
            let data = try? Data(contentsOf: url)
            return UIImage(data: data!)!
        }
        else {
            return UIImage.init(named: "no_image.jpg")!
        }
    }
}



var newsArray: [News] = []
class NewsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTextTableViewCellHeightDelegate, PhotoAttachmentsTableViewCellDelegate, PostAuthorInfoTableViewCellDelegate {
    func strarButtonUnPressed(indexInFavoriteNews: Int) {
        
    }
    
    func strarButtonPressed(postAuthorInfoTableViewCell: PostAuthorInfoTableViewCell, newsForSaveInCoreData: News) {
        DispatchQueue.main.async {
            self.myTableView.beginUpdates()
            newsForSaveInCoreData.favoriteNews = true
            postAuthorInfoTableViewCell.starButton.backgroundColor = UIColor.red
            self.myTableView.endUpdates()
        }
    }
    
    
    func performSegue(photoAttachments: [PhotoAttachments], selectedImage: Int) {
        PhotoViewController.photoArray = photoAttachments
        PhotoViewController.index = selectedImage
        performSegue(withIdentifier: "PhotoViewController", sender: nil)
    }
    
    
    @IBOutlet var myTableView: UITableView!
    
    func updateHeight(cell: TextTableViewCell) {
        DispatchQueue.main.async {
            self.myTableView.beginUpdates()
            if cell.textInfo.numberOfLines > 0 {
                cell.textInfo.numberOfLines = 0
                cell.readAllButton.setTitle("Свернуть", for: .normal)
                
            }
            else {
                cell.textInfo.numberOfLines = 5
                cell.readAllButton.setTitle("Читать полностью", for: .normal)
            }
            
            self.myTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == newsArray.count - 1 && indexPath.row == newsArray[indexPath.section].dataContent.count - 1 && newsArray.count != 0 {
            print("reload data")
            getNews()
            
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func numberOfSections(in tablvarew: UITableView) -> Int {
        
        return newsArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsArray[section].dataContent.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let oneNews = newsArray[indexPath.section]
        
        switch oneNews.dataContent[indexPath.row] {
            
        case .postAuthorInfoTableViewCell:
            let postAuthorInfoTableViewCellNib = UINib(nibName: "PostAuthorInfoTableViewCell", bundle: nil)
            tableView.register(postAuthorInfoTableViewCellNib, forCellReuseIdentifier: "PostAuthorInfoTableViewCell")
            
            let postAuthorInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostAuthorInfoTableViewCell", for: indexPath) as! PostAuthorInfoTableViewCell
            
            postAuthorInfoTableViewCell.avatarImage.image = UIImage.getImageFromString(stringUrl: oneNews.authorPhoto100)
            postAuthorInfoTableViewCell.postAuthorName.text = oneNews.authorName
            postAuthorInfoTableViewCell.date.text = oneNews.date
            postAuthorInfoTableViewCell.newsForSaveInCoreData = oneNews
            postAuthorInfoTableViewCell.delegate = self
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
            textTableViewCell.delegate = self
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
            photoAttachmentsTableViewCell.delegate = self
            
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
        
        
    }
    func getNews() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: super.view, animated: true)
        }
        ServerManager.myServerManager.doRequest(serverRequest: ServerRequest.getNewsFeed) { (response) in
            ServerManager.myServerManager.nextFrom = response["response"]["next_from"].stringValue
            print(ServerManager.myServerManager.nextFrom)
            let allNewsJson = response["response"]["items"].arrayValue
            let allNewsAuthorsJson = response["response"]["groups"].arrayValue + response["response"]["profiles"].arrayValue
            var allNewsAuthorDictionary = [Int : JSON]()
            for author in allNewsAuthorsJson {
                allNewsAuthorDictionary[author["id"].intValue] = author
            }
            for post in allNewsJson {
                
                let news = News.init(post: post, authorsDictionary: allNewsAuthorDictionary)
                if news.dataContent.count > 2 {
                    newsArray.append(news)
                }
            }
            
            
            self.myTableView.reloadData()
            MBProgressHUD.hide(for: super.view, animated: true)
            
        }
        
    }
   override func viewWillAppear(_ animated: Bool) {
       getNews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.myCoreDataManager = CoreDataManager.init()
        getNews()
        
    }
    // Do any additional setup after loading the view.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
