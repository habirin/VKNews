//
//  FavoritesNewsViewController.swift
//  VK
//
//  Created by Ринат Хабибуллин on 12.02.2018.
//  Copyright © 2018 Ринат Хабибуллин. All rights reserved.
//

import UIKit
import MBProgressHUD

class FavoritesNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTextTableViewCellHeightDelegate, PhotoAttachmentsTableViewCellDelegate, PostAuthorInfoTableViewCellDelegate {
    
    
    func strarButtonUnPressed(indexInFavoriteNews: Int) {
        DispatchQueue.main.async {
            
            self.newsArray.remove(at: indexInFavoriteNews)
            self.myTableView.beginUpdates()
            self.myTableView.deleteSections([indexInFavoriteNews], with: .left)
            self.myTableView.endUpdates()
            
            MBProgressHUD.showAdded(to: super.view, animated: true)
            self.myTableView.reloadData()
            CoreDataManager.myCoreDataManager.deleteNewsFromCoreData(index: indexInFavoriteNews)
            MBProgressHUD.hideAllHUDs(for: super.view, animated: true)
            
        }
        
    }
    func strarButtonPressed(postAuthorInfoTableViewCell: PostAuthorInfoTableViewCell, newsForSaveInCoreData: News) {
        
    }
    
    @IBOutlet weak var myTableView: UITableView!
    var newsArray: [News] = []
    
    
    
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
    
    func performSegue(photoAttachments: [PhotoAttachments], selectedImage: Int) {
        PhotoViewController.photoArray = photoAttachments
        PhotoViewController.index = selectedImage
        performSegue(withIdentifier: "PhotoViewController", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        myTableView.reloadData()
        newsArray = CoreDataManager.myCoreDataManager.convertingFromCoreDataToNewsClass()
        myTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsArray = CoreDataManager.myCoreDataManager.convertingFromCoreDataToNewsClass()
        myTableView.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        (cell as! PostAuthorInfoTableViewCell).indexInFavoriteNews = indexPath.section
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
