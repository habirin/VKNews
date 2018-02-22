//
//  NewsFeedViewController.swift
//  VKNews
//
//  Created by Ринат Хабибуллин on 15.11.2017.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import UIKit
import MBProgressHUD
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
        CellCreator.myCellCreator.oneNews = newsArray[indexPath.section]
        let cell = CellCreator.myCellCreator.getCell(tableView: tableView, indexPath: indexPath)
        if cell is PostAuthorInfoTableViewCell {
           
            (cell as! PostAuthorInfoTableViewCell).delegate = self
            
        }
        else if cell is TextTableViewCell {
            (cell as! TextTableViewCell).delegate = self
            
        }
        else if cell is PhotoAttachmentsTableViewCell {
            (cell as! PhotoAttachmentsTableViewCell).delegate = self
        }
        
        return cell
    
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
        CellCreator.myCellCreator = CellCreator.init()
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
